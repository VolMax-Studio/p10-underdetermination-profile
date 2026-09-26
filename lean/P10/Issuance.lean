import P10.Core

namespace P10

/--
Kernel-facing witness material required before the receipt layer may emit
`NotDemonstrated(reason=underdetermined)`.
-/
structure WitnessCertificate (profile : Profile)
    (evidence : profile.Evidence) (claim : profile.Claim) where
  world₀ : profile.World
  world₁ : profile.World
  compatible₀ : Compatible profile evidence world₀
  compatible₁ : Compatible profile evidence world₁
  valuesDiffer : Eval profile claim world₀ ≠ Eval profile claim world₁

namespace WitnessCertificate

theorem sound {profile : Profile} {evidence : profile.Evidence}
    {claim : profile.Claim}
    (certificate : WitnessCertificate profile evidence claim) :
    Underdetermined profile evidence claim :=
  underdetermined_of_witnesses profile evidence claim
    certificate.world₀ certificate.world₁
    certificate.compatible₀ certificate.compatible₁ certificate.valuesDiffer

theorem worldsDistinct {profile : Profile} {evidence : profile.Evidence}
    {claim : profile.Claim}
    (certificate : WitnessCertificate profile evidence claim) :
    certificate.world₀ ≠ certificate.world₁ :=
  worlds_distinct_of_values_differ profile claim
    certificate.world₀ certificate.world₁ certificate.valuesDiffer

theorem encodingsDistinct {profile : Profile} {evidence : profile.Evidence}
    {claim : profile.Claim}
    (certificate : WitnessCertificate profile evidence claim) :
    profile.encodeWorld certificate.world₀ ≠
      profile.encodeWorld certificate.world₁ :=
  encodings_distinct_of_values_differ profile claim
    certificate.world₀ certificate.world₁ certificate.valuesDiffer

end WitnessCertificate

end P10
