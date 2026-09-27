import P10.Fixtures.FourWorld

open P10
open P10.Fixtures.FourWorld

/-- Deliberately weaker than the checker-constructed certificate target. -/
def WeakerTarget : Prop := True

theorem weakerProof : WeakerTarget := True.intro

-- Both checks are required to fail with a type mismatch.
#check (weakerProof : CertificateTargetV0 profile evidence claim .w00 .w01)
#check (certificate : WitnessCertificate profile determiningEvidence claim)
