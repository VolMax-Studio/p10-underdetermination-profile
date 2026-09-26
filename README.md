# P10 Underdetermination Profile

P10 defines a third-party-verifiable binding for `NotDemonstrated(reason=underdetermined)`. A conforming receipt carries two canonical witness worlds that are compatible with the same closed evidence set and produce different values for the same frozen claim. The witness result is checked against committed profile semantics and bound into a SCITT Transparent Statement containing an in-toto Statement v1 predicate.

## Status

Version 0.1.1 is a publication candidate. Independent-review and release status are recorded separately and bound to the exact profile artifact by SHA-256.

## Documents

- [`P10_Underdetermination_Profile_v0.1.1.md`](P10_Underdetermination_Profile_v0.1.1.md) — profile specification and conformance criteria.
- `P10_Independent_Gate_Report_v0.1.1.md` — reserved for the standalone publication-review record that binds the exact v0.1.1 profile hash; it is added only after an independent PASS.
- [`SOURCE_SNAPSHOT.md`](SOURCE_SNAPSHOT.md) — inspected sources and verification boundaries.
- [`SHA256SUMS`](SHA256SUMS) — SHA-256 manifest for publication artifacts.
- [`CITATION.cff`](CITATION.cff) — citation metadata.
- [`LICENSE`](LICENSE) — license terms.

## Scope

P10 is a profile-and-binding contribution, not a new mathematical theorem or a new wire format. Its claimed distinction is limited to concrete divergent-world witnesses drawn from a pre-evidence committed model class, checked under executable `Compatibleπ` and `Evalπ` semantics by Lean, and bound to a uniquely resolved instance-specific profile and verifier manifest, checkpoint-complete evidence coverage, and transparency-log registration-order verification.

P10 does not claim novelty for independent determinability, decision-time or pre-evidence binding as a general idea, indeterminate receipts, claim/ruleset/evidence binding, content-addressed evidence, local recomputation, SCITT transport, or the general need for evidence-coverage and omission controls.

The profile does not identify the actual world, establish either witness claim value as true, prove that the declared model faithfully represents reality, or establish completeness outside the committed log and evidence scope.

## Verification

From the repository root:

```sh
sha256sum -c SHA256SUMS
```

Any independent verdict must identify the exact SHA-256 of the profile artifact it reviews.
