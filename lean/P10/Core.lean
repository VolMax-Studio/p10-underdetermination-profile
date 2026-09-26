namespace P10

/--
The executable semantic surface frozen by a P10 profile.

`profileDigest` is the external commitment identifier. The Lean kernel does
not implement SHA-256; the receipt layer binds this identifier to the
canonical serialized profile.
-/
structure Profile where
  World : Type
  Evidence : Type
  Claim : Type
  Value : Type
  compatible : Evidence → World → Prop
  eval : Claim → World → Value
  encodeWorld : World → String
  decodeWorld : String → Option World
  decode_encode : ∀ world, decodeWorld (encodeWorld world) = some world
  encode_injective : Function.Injective encodeWorld
  profileDigest : String

def Compatible (profile : Profile) (evidence : profile.Evidence)
    (world : profile.World) : Prop :=
  profile.compatible evidence world

def Eval (profile : Profile) (claim : profile.Claim)
    (world : profile.World) : profile.Value :=
  profile.eval claim world

/--
Underdetermination relative to one frozen profile and one evidence value:
two compatible worlds assign different values to the same claim.
-/
def Underdetermined (profile : Profile) (evidence : profile.Evidence)
    (claim : profile.Claim) : Prop :=
  ∃ world₀ world₁,
    Compatible profile evidence world₀ ∧
    Compatible profile evidence world₁ ∧
    Eval profile claim world₀ ≠ Eval profile claim world₁

/-- The minimal witness rule at the center of the P10 kernel. -/
theorem underdetermined_of_witnesses (profile : Profile)
    (evidence : profile.Evidence) (claim : profile.Claim)
    (world₀ world₁ : profile.World)
    (compatible₀ : Compatible profile evidence world₀)
    (compatible₁ : Compatible profile evidence world₁)
    (valuesDiffer : Eval profile claim world₀ ≠ Eval profile claim world₁) :
    Underdetermined profile evidence claim := by
  exact ⟨world₀, world₁, compatible₀, compatible₁, valuesDiffer⟩

/-- Different claim values force the two semantic worlds to be distinct. -/
theorem worlds_distinct_of_values_differ (profile : Profile)
    (claim : profile.Claim) (world₀ world₁ : profile.World)
    (valuesDiffer : Eval profile claim world₀ ≠ Eval profile claim world₁) :
    world₀ ≠ world₁ := by
  intro worldsEqual
  apply valuesDiffer
  cases worldsEqual
  rfl

/-- Canonical encodings of a valid witness pair must also be distinct. -/
theorem encodings_distinct_of_values_differ (profile : Profile)
    (claim : profile.Claim) (world₀ world₁ : profile.World)
    (valuesDiffer : Eval profile claim world₀ ≠ Eval profile claim world₁) :
    profile.encodeWorld world₀ ≠ profile.encodeWorld world₁ := by
  intro encodingsEqual
  exact (worlds_distinct_of_values_differ profile claim world₀ world₁ valuesDiffer)
    (profile.encode_injective encodingsEqual)

/-- A claim that is constant across all worlds cannot be underdetermined. -/
theorem not_underdetermined_of_constant_eval (profile : Profile)
    (evidence : profile.Evidence) (claim : profile.Claim)
    (constantEval : ∀ world₀ world₁,
      Eval profile claim world₀ = Eval profile claim world₁) :
    ¬ Underdetermined profile evidence claim := by
  intro underdetermined
  obtain ⟨world₀, world₁, _, _, valuesDiffer⟩ := underdetermined
  exact valuesDiffer (constantEval world₀ world₁)

end P10
