# P10 Underdetermination Profile

P10 defines a third-party-verifiable binding for `NotDemonstrated(reason=underdetermined)`. A conforming receipt carries two canonical witness worlds that are compatible with the same closed evidence set and produce different values for the same frozen claim. The witness result is checked against committed profile semantics and bound into a SCITT Transparent Statement containing an in-toto Statement v1 predicate.

## Status

Version 0.1.0 is a versioned specification artifact. Independent-review and release status are recorded separately and bound to the exact profile artifact by SHA-256.

## Documents

- [`P10_Underdetermination_Profile_v0.1.0.md`](P10_Underdetermination_Profile_v0.1.0.md) — profile specification and conformance criteria.
- [`P10_Independent_Gate_Report_v0.1.0.md`](P10_Independent_Gate_Report_v0.1.0.md) — standalone publication-review record.
- [`SOURCE_SNAPSHOT.md`](SOURCE_SNAPSHOT.md) — inspected sources and verification boundaries.
- [`SHA256SUMS`](SHA256SUMS) — SHA-256 manifest for publication artifacts.
- [`CITATION.cff`](CITATION.cff) — citation metadata.
- [`LICENSE`](LICENSE) — license terms.

## Scope

P10 is a profile-and-binding contribution, not a new mathematical theorem or a new wire format. It profiles SCITT and in-toto structures, commits the relevant semantics before evidence admission, requires complete checkpoint-bounded replay within the committed transparency log, and binds explicit limitations into the receipt.

The profile does not identify the actual world, establish either witness claim value as true, prove that the declared model faithfully represents reality, or establish completeness outside the committed log and evidence scope.

## Verification

From the repository root:

```sh
sha256sum -c SHA256SUMS
```

Any independent verdict must identify the exact SHA-256 of the profile artifact it reviews.
