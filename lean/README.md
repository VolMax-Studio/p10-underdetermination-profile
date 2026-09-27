# P10 Lean Certificate Kernel

This directory contains a profile-level certificate checker for the P10
underdetermination result. It does not amend, replace, or fork the frozen
Track-A kernel.

The boundary is intentional:

- Track-A remains the domain-specific time-series completeness kernel.
- Track-A `NOT_DEMONSTRATED` means that expected observations are missing. It
  must not be reinterpreted as P10 `NotDemonstrated(reason=underdetermined)`.
- P10 issuance requires its own pair of compatible canonical worlds whose
  claim evaluations differ, checked under a frozen P10 profile.
- The existing Track-A MCP adapter and its transport contracts should be
  reused or extended when P10 integration begins; no second replacement MCP
  adapter is planned.
- This work is not a Track-A Core v0.4 amendment.

## Soundness boundary

The certificate checker is sound but not complete. A valid certificate proves
underdetermination relative to the frozen profile and evidence. Failure to
produce a witness certificate does not establish determinacy.

`CertificateTargetV0` is constructed by the checker from the profile,
evidence, claim, and witness values that index `WitnessCertificate`. The
certificate supplies only a proof term for that checker-owned type. Lean checks
the term against the elaborated target up to definitional equality; it does not
trust a proposition selected or declared by the certificate.

This implementation gate targets the frozen P10 v0.1.1 specification artifact
with SHA-256
`b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`.

`VerifierManifestV0.json` records the concrete toolchain executable, checker
source manifest, dependency lock, `.olean` build manifest, axiom policy, and
acceptance command used for the gated build. The manifest deliberately does
not claim that receipt, transparency-log, or cryptographic verification has
already been implemented.

Run the acceptance checks from the repository root:

```sh
./scripts/check-lean.sh
```

The script rejects proof placeholders, treats compiler warnings as errors, and
fails if any audited declaration depends on axioms.
