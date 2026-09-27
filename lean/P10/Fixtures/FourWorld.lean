import P10.Issuance

namespace P10.Fixtures.FourWorld

/-- Four completely enumerated worlds with one observed and one hidden bit. -/
inductive World where
  | w00
  | w01
  | w10
  | w11
  deriving DecidableEq, Repr

structure Evidence where
  observedFirst : Bool
  observedSecond : Option Bool
  deriving DecidableEq, Repr

inductive Claim where
  | secondBit
  deriving DecidableEq, Repr

def firstBit : World → Bool
  | .w00 | .w01 => false
  | .w10 | .w11 => true

def secondBit : World → Bool
  | .w00 | .w10 => false
  | .w01 | .w11 => true

def compatible (evidence : Evidence) (world : World) : Prop :=
  evidence.observedFirst = firstBit world ∧
    match evidence.observedSecond with
    | none => True
    | some observed => observed = secondBit world

def evaluate (_claim : Claim) (world : World) : Bool :=
  secondBit world

def encodeWorld : World → String
  | .w00 => "00"
  | .w01 => "01"
  | .w10 => "10"
  | .w11 => "11"

def decodeWorld : String → Option World
  | "00" => some .w00
  | "01" => some .w01
  | "10" => some .w10
  | "11" => some .w11
  | _ => none

theorem decode_encode (world : World) :
    decodeWorld (encodeWorld world) = some world := by
  cases world <;> rfl

theorem encode_injective : Function.Injective encodeWorld := by
  intro world₀ world₁ encodingsEqual
  have decodedEqual : some world₀ = some world₁ := by
    calc
      some world₀ = decodeWorld (encodeWorld world₀) := (decode_encode world₀).symm
      _ = decodeWorld (encodeWorld world₁) := congrArg decodeWorld encodingsEqual
      _ = some world₁ := decode_encode world₁
  exact Option.some.inj decodedEqual

def profile : P10.Profile where
  World := World
  Evidence := Evidence
  Claim := Claim
  Value := Bool
  compatible := compatible
  eval := evaluate
  encodeWorld := encodeWorld
  decodeWorld := decodeWorld
  decode_encode := decode_encode
  encode_injective := encode_injective
  profileDigest := "fixture:four-world:v0.2.0"

def evidence : profile.Evidence := ⟨false, none⟩

/-- Evidence that fixes both bits and therefore determines the claim. -/
def determiningEvidence : profile.Evidence := ⟨false, some false⟩

def claim : profile.Claim := .secondBit

def certificate : P10.WitnessCertificate profile evidence claim where
  world₀ := .w00
  world₁ := .w01
  proof := by
    refine ⟨?_, ?_, ?_⟩
    · exact ⟨rfl, trivial⟩
    · exact ⟨rfl, trivial⟩
    · change false ≠ true
      intro valuesEqual
      nomatch valuesEqual

/-- Positive fixture: the hidden second bit differs across compatible worlds. -/
theorem underdetermined : P10.Underdetermined profile evidence claim :=
  certificate.sound

/-- Negative mutation: a world with the wrong observed bit is incompatible. -/
theorem rejects_incompatible_world :
    ¬ P10.Compatible profile evidence World.w10 := by
  intro compatibleWorld
  obtain ⟨observedBitMatches, _⟩ := compatibleWorld
  change false = true at observedBitMatches
  nomatch observedBitMatches

/-- Negative mutation: duplicating one world cannot produce differing values. -/
theorem rejects_duplicate_world :
    ¬ (P10.Eval profile claim World.w00 ≠
      P10.Eval profile claim World.w00) := by
  intro valuesDiffer
  exact valuesDiffer rfl

/-- Determining evidence forces the claim value to `false`. -/
theorem determining_compatible_eval_false (world : World)
    (compatibleWorld : P10.Compatible profile determiningEvidence world) :
    P10.Eval profile claim world = false := by
  cases world with
  | w00 => rfl
  | w01 =>
      obtain ⟨_, observedBitMatches⟩ := compatibleWorld
      change false = true at observedBitMatches
      nomatch observedBitMatches
  | w10 =>
      obtain ⟨observedBitMatches, _⟩ := compatibleWorld
      change false = true at observedBitMatches
      nomatch observedBitMatches
  | w11 =>
      obtain ⟨observedBitMatches, _⟩ := compatibleWorld
      change false = true at observedBitMatches
      nomatch observedBitMatches

/-- Negative fixture: evidence that fixes the claim cannot be underdetermined. -/
theorem determining_evidence_not_underdetermined :
    ¬ P10.Underdetermined profile determiningEvidence claim := by
  intro underdeterminedClaim
  obtain ⟨world₀, world₁, compatible₀, compatible₁, valuesDiffer⟩ :=
    underdeterminedClaim
  apply valuesDiffer
  exact (determining_compatible_eval_false world₀ compatible₀).trans
    (determining_compatible_eval_false world₁ compatible₁).symm

/-- Issuance is impossible when the evidence determines the claim. -/
theorem no_certificate_for_determining_evidence :
    ¬ Nonempty (P10.WitnessCertificate profile determiningEvidence claim) := by
  intro certificateExists
  obtain ⟨certificate⟩ := certificateExists
  exact determining_evidence_not_underdetermined certificate.sound

/-- Negative mutation: canonical witness encodings cannot be exchanged. -/
theorem canonical_witnesses_distinct :
    profile.encodeWorld certificate.world₀ ≠
      profile.encodeWorld certificate.world₁ :=
  certificate.encodingsDistinct

end P10.Fixtures.FourWorld
