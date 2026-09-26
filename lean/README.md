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

Run the acceptance checks from the repository root:

```sh
./scripts/check-lean.sh
```

The script rejects proof placeholders, treats compiler warnings as errors, and
fails if any audited declaration depends on axioms.
