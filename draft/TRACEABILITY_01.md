# Traceability Matrix — `draft-nestorov-scitt-p10-underdetermination-01`

**Status:** ACTIVE / DRAFTING. The `-01` source exists and profile-derived edits remain constrained by `Changed semantics? = NO`. The draft is not ratified and publication is not authorized.

**Primary source:** `P10_Underdetermination_Profile_v0.1.1.md`, SHA-256 `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`.

**Baseline draft:** `draft-nestorov-scitt-p10-underdetermination-00.md`, SHA-256 `093f55572a07d34b033d50cc3e57bfb6c1dedc0b7856978e3bd5a519ec9ec1b5`.

**Baseline traceability:** `draft/TRACEABILITY.md`, SHA-256 `1372b54cf4d7a414e74a51a15e49616dba97e52fb8fe17c41120803a72e0dc39`.

## 1. Global invariant

For every profile-derived change proposed for `-01`:

> `Changed semantics? = NO`

A required `YES` is a STOP condition and opens a possible new-profile-release decision. It is not silently absorbed into the Internet-Draft.

## 2. Delta matrix: v0.1.1 / `-00` -> candidate `-01`

| ID | Source / baseline | Candidate `-01` treatment | Class | Changed semantics? | Authority / record | Status |
|---|---|---|---|---|---|---|
| D01 | I-D title contains “Receipts for SCITT” | Change document title to “P10 Underdetermination Profile: Adjudication Statements over SCITT”; keep I-D name unchanged | EDITORIAL | NO | `a1defd8` sterile `-01` baseline | APPLIED |
| D02 | v0.1.1 uses `receipt` for the P10 adjudication object in multiple places | Rename only occurrences classified `P10_OBJECT`; preserve SCITT Receipt, identifiers, frozen literals, and external/prior-art terminology | EDITORIAL TERMINOLOGY | NO, occurrence-by-occurrence only | `3a60f77`; draft scan 65 total → 23 edited / 42 preserved | APPLIED |
| D03 | v0.1.1 uses SCITT Receipt for `S_R` / COSE label 394 | Preserve term `SCITT Receipt` | UNCHANGED PROFILE | NO | RFC 9942/9943 terminology | REQUIRED |
| D04 | `S₁` appears once without definition | Clarify as editorial outline notation; no new field/checkpoint/acceptance condition | HUMAN-RATIFIED INTERPRETIVE RECORD | NO | E02, ratified 2026-10-03 | APPLIED FROM RATIFIED RECORD |
| D05 | `S_C` appears once without definition | Interpret as shorthand for already listed `evidence_closure_ref`, `evidence_admission_refs`, `preclosure_transcript_digest` | HUMAN-RATIFIED INTERPRETIVE RECORD | NO | E03, `v0.1.1-draft01-e03-ratified` | APPLIED FROM RATIFIED RECORD |
| D06 | Profile already requires full-prefix replay and authorized read access | Keep profile obligation unchanged | UNCHANGED PROFILE | NO | v0.1.1 §2.4 | REQUIRED |
| D07 | S3 shows verifier/operator deployment needs auditor-equivalent content access | Describe in Appendix B.3 as the executed instance's exact, complete, checkpoint-bounded content-access requirement; do not prescribe SCITT storage architecture | INSTANCE PROSE | NO | S3 accepted capture + v0.1.1 full-prefix replay requirement | APPLIED |
| D08 | S3 executed instance uses RFC9162_SHA256, LeafEncodeV0, LogIdentityV0, one Receipt key for the capture, and serialized registration | Describe in Appendix B.2/B.4 as executed-instance parameters, not general P10 requirements | INSTANCE PROSE | NO | signed S3-A freeze + accepted S3-B/S3-C evidence | APPLIED |
| D09 | S3 registration path performs issuer-signature checks, but P10 does not use operator-side registration checks as verifier evidence and the facade does not implement full Registration Policy authorization semantics | Separate TS registration behavior from S2b independent signature verification; state explicit non-claim of general RFC 9943/SCRAPI conformance | RFC 7942 / LIMITATION | NO | S2b ratified/public evidence + S3 prototype evidence | APPLIED |
| D10 | Ratified S2a C2 availability gate is stricter than profile | Disclose subject-payload liveness / denial-of-progress limitation in §10.7; HALT remains non-verdict | RFC 7942 / LIMITATION | NO | S2a ratified source | APPLIED |
| D11 | S3/Tessera facade leaf input cap 65535; statement cap 65474 | Disclose in Appendix B.3; note separate 1 MiB detached-payload verification path | INSTANCE LIMITATION | NO | frozen S3-A deployment definition | APPLIED |
| D12 | `-00` has no RFC 7942 Implementation Status section | Add §10 with removal notice, implementation scope, demonstrated execution, implementation experience, limitations, and licensing status | NEW INFORMATIVE PROSE | NO | RFC 7942 + pinned implementation evidence | APPLIED |
| D13 | `-00` does not separate profile and executed instance as explicitly as now needed | Add §1.2 + Appendix B boundary language | NEW INFORMATIVE PROSE | NO | architecture clarification | APPLIED |
| D14 | `-00` has external implementation refs but not per-artifact availability/license matrix | Add §10.8 repository-by-repository availability/license statement and Appendix C reproduction/artifact pin matrix | NEW INFORMATIVE PROSE | NO | repository/tag/license + retained execution evidence | APPLIED |
| D15 | Executed demonstration uses deliberately minimal two-bit fixture semantics | Disclose explicitly in §10.7; do not imply realistic-domain validation | RFC 7942 / LIMITATION | NO | S1 fixture + S3 accepted demonstration evidence | APPLIED |
| D16 | Executed chain includes the S1 Lean underdetermination certificate and its instance linkage before final binding | Describe S1 role in §10.4 and the actual S2b -> S2a -> post-S2a execution order in §10.5 | RFC 7942 / IMPLEMENTATION DESCRIPTION | NO | ratified S1 + ratified S2a + S2b post-S2a binding evidence | APPLIED |
| D17 | Executed implementation exposed a JCS dependency-selection failure and an RFC 9942 proof-representation integration pitfall | Report only the two executed findings in §10.6 with explicit formulation ceilings | RFC 7942 / IMPLEMENTATION EXPERIENCE | NO | G10-JCS evidence + S3 retained dry-run evidence | APPLIED |
| D18 | Executed S3 bootstrap used an out-of-band preconfigured issuer table plus logged policy and verification-material declarations | Describe the actual bootstrap in Appendix B.4; logged declarations are not the registration trust source and do not prove policy enforcement | INSTANCE PROSE | NO | signed S3-A freeze + accepted eight-leaf capture | APPLIED |
| D19 | S3 capture anchor was operator-generated and committed before verification, not independently timestamped | State repository ordering and its evidence ceiling in Appendix B.1/B.3 | INSTANCE PROVENANCE | NO | `149953c` capture commit + `5acc277` result ancestry | APPLIED |
| D20 | Accepted run used a container environment; Python was recorded but not pinned; later HP replay was a second host under the same operator | Describe host/reproduction boundary in Appendix B.5/B.6 without claiming Python independence or third-party attestation | INSTANCE PROSE / LIMITATION | NO | accepted run-info + HP second-host evidence | APPLIED |
| D21 | `SCRAPI` appears without expansion or citation | Expand first use as SCITT Reference APIs and add an explicit versioned `SCRAPI-11` informative reference | EDITORIAL | NO | `draft-ietf-scitt-scrapi-11` | APPLIED |
| D22 | Reproduction evidence is distributed across tags, capture records, runner outputs, HP evidence, and Workbench export | Add Appendix C with uniform `PINNED` / `RECORDED` / `OPEN` evidence matrices and explicit non-inference for absent artifacts | NEW INFORMATIVE PROSE | NO | retained public/private repository evidence + Workbench export audit | APPLIED |

## 3. Notation records

### E01 — historical `-00` erratum record

The `-00` brief recorded a ratified replacement of the v0.1.1 `S_C` sentence with concrete issuer-signed fields. The historical rationale called `S_C` obsolete. That characterization is not reused in `-01` planning; current source review establishes only that `S_C` is undefined in v0.1.1.

### E02 — ratified 2026-10-03

Tag: `v0.1.0-schema-r9-e02-ratified` -> commit `4431d33e363d1684743f457eb709789e38568c8f`.

Ratified text:

> `S₁` is editorial outline notation and introduces no additional wire field, VDS checkpoint, or acceptance condition.

Classification for `-01`: `HUMAN-RATIFIED INTERPRETIVE RECORD`; `Changed semantics? NO`.

### E03 — ratified 2026-10-10

Source text:

> To avoid a post-registration hash cycle, the issuer-signed payload binds `S_C`, ordered references, and the pre-closure transcript. The outer SCITT Receipt supplies `S_R`; `S_R`, the final replay transcript, and the coverage-verification result are not fields in the issuer-signed payload. Full-prefix replay occurs after receipt acquisition.

Candidate interpretation:

> `S_C` is undefined editorial shorthand. It introduces no additional wire field, VDS checkpoint, digest, or acceptance condition. In context, the issuer-signed bindings are the already enumerated `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`.

Status: `RATIFIED` by Ivan Nestorov on 2026-10-10.

Signed tag: `v0.1.1-draft01-e03-ratified` → commit `ea055cce47de3f1e741d91cd921d5916a8a16936`.

## 4. Receipt terminology audit — MACHINE-RECONCILED

**Purpose:** prevent a mass rename from changing SCITT semantics or quoted/prior-art terminology.

**Machine reconciliation:** the exact pinned v0.1.1 source was scanned case-insensitively for every `receipt` substring occurrence.

- source SHA-256: `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`
- raw occurrence inventory: `draft/RECEIPT_OCCURRENCES_01.tsv`
- inventory SHA-256: `354b3d7856028e894ed39c7c3391cd3355de72c3e79b78cd59f907fcb479eac4`
- exact raw occurrences: **56**
- exact classifications: **56/56**
- ambiguous classifications: **0**
- authoritative candidate reconciliation: `draft/RECEIPT_RECONCILIATION_01.md`
- reconciliation SHA-256: `e39304421ee160a8da64025dcb397beaba7642563bfa923bf1385506dedef9b8`

The R01–R45 table below is retained as the initial human audit for provenance; where its grouping differs from the raw machine inventory, the 56-row reconciliation artifact is authoritative for `-01` terminology planning.

Classes:

- `P10_OBJECT` — the P10 adjudication/result object; candidate for `P10 Adjudication Statement` terminology.
- `SCITT_RECEIPT` — RFC 9942/9943 Receipt; preserve.
- `EXTERNAL_OR_PRIOR_ART` — another system's terminology or quoted system name; preserve.
- `IDENTIFIER_OR_FIELD` — compatibility-sensitive code/field text; no rename without a separate decision.
- `AMBIGUOUS` — STOP until resolved.

| ID | Source locator / phrase | Class | Candidate action | Changed semantics? |
|---|---|---|---|---|
| R01 | §1: “the receipt carries two semantically distinct worlds” | P10_OBJECT | “the P10 Adjudication Statement carries …” | NO |
| R02 | §2.2: “canonical receipt witnesses” | P10_OBJECT | “canonical adjudication witnesses” or explicit P10-object wording; preserve witness semantics | NO |
| R03 | §2.2: “issue an underdetermination receipt” | P10_OBJECT | “issue a P10 Adjudication Statement with an underdetermination outcome” | NO |
| R04 | §2.4: “L identified by the outer receipt” | SCITT_RECEIPT | Make explicit “outer SCITT Receipt” | NO |
| R05 | §2.4: “closure precedes the final receipt” | P10_OBJECT | Candidate “closure precedes the final P10 adjudication Signed Statement”; gate must confirm intended referent | NO if confirmed |
| R06 | §2.6 formula: `receipt.evidence_digest` | IDENTIFIER_OR_FIELD | Do not rename as prose. Confirm schema/API compatibility separately. | NO / HOLD |
| R07 | §2.6: “The receipt is computed over closed e” | P10_OBJECT | Rename P10 referent only | NO |
| R08 | §2.6: “The outer SCITT Receipt supplies S_R” | SCITT_RECEIPT | Preserve | NO |
| R09 | §2.6: “after receipt acquisition” immediately after outer-SCITT-Receipt sentence | SCITT_RECEIPT | Clarify “after SCITT Receipt acquisition” | NO |
| R10 | §2.7: “codec digest is part of the profile and receipt” | P10_OBJECT | Rename P10 referent only | NO |
| R11 | §3 AP1 heading: “mandatory in the receipt” | P10_OBJECT | Rename to P10 Adjudication Statement | NO |
| R12 | §3 coverage/instance heading: “mandatory in the receipt” | P10_OBJECT | Rename to P10 Adjudication Statement | NO |
| R13 | §3 mandatory limitation text: “This receipt establishes completeness …” | P10_OBJECT | Preserve legacy `receipt` literal inside frozen P10 v0.1 limitation bytes; use `P10 Adjudication Statement` in descriptive prose | NO |
| R14 | same limitation: “This receipt establishes uniqueness …” | P10_OBJECT | Same frozen-literal treatment as R13 | NO |
| R15 | §3: “included in the receipt's limitations field” | P10_OBJECT | Rename P10 referent, but preserve actual `limitations` field | NO |
| R16 | §4 identifier `receipt_checkpoint_ref` | IDENTIFIER_OR_FIELD | Preserve unless schema compatibility decision explicitly changes it | HOLD |
| R17 | §4 comment: “SCITT Receipt in COSE unprotected label 394” | SCITT_RECEIPT | Preserve | NO |
| R18 | §4 comment: “verified checkpoint from the receipt” | SCITT_RECEIPT | Clarify to “from the SCITT Receipt” | NO |
| R19 | §4: “standard SCITT Receipt remains in COSE … 394” | SCITT_RECEIPT | Preserve | NO |
| R20 | §4: “attachment of a SCITT Receipt” | SCITT_RECEIPT | Preserve | NO |
| R21 | §4: “SCITT Statement without the required Receipt” | SCITT_RECEIPT | Preserve / make explicit SCITT Receipt if needed | NO |
| R22 | §5 prior-art Wadkins row: “receipt-carried divergent-world pair” | P10_OBJECT | Candidate P10 terminology only; do not alter quoted external system names | NO |
| R23 | §5 `verification.*` row: “JWS receipts” | EXTERNAL_OR_PRIOR_ART | Preserve | NO |
| R24 | §5 SCITT Agent Action Capsule: “SCITT receipt with disposition vocabulary” | EXTERNAL_OR_PRIOR_ART | Preserve source terminology | NO |
| R25 | §5 AWS row: “No third-party-verifiable receipt or witness pair” | EXTERNAL_OR_PRIOR_ART | Preserve unless prose is separately rewritten without changing comparison | NO |
| R26 | §5 supervaluationism row: “Not receipt/binding systems” | EXTERNAL_OR_PRIOR_ART | Preserve or editorially rephrase comparison; not a P10 object definition | NO |
| R27 | §5 differentiation: “an indeterminate receipt” | EXTERNAL_OR_PRIOR_ART | Preserve; refers to prior-art category | NO |
| R28 | §6: “the receipt identifies the actual world …” | P10_OBJECT | Rename P10 referent only | NO |
| R29 | §6: “an `indeterminate` receipt … is novel” | EXTERNAL_OR_PRIOR_ART | Preserve | NO |
| R30 | §6: “claim, ruleset, or evidence set into a signed receipt” | EXTERNAL_OR_PRIOR_ART | Preserve | NO |
| R31 | §6: “local receipt recomputation” | EXTERNAL_OR_PRIOR_ART | Preserve | NO |
| R32 | §6: “SCITT transport for a verification receipt” | EXTERNAL_OR_PRIOR_ART | Preserve | NO |
| R33 | §6: “receipt's verdict” | P10_OBJECT | Rename P10 referent only | NO |
| R34 | M2: “No case yields an underdetermination receipt” | P10_OBJECT | Rename P10 referent only | NO |
| R35 | M5: “Receipt without an earlier profile-registration entry” | P10_OBJECT | Rename to P10 Adjudication Statement after confirming test target | NO if confirmed |
| R36 | M11: “SCITT Statement without the required Receipt” | SCITT_RECEIPT | Preserve | NO |
| R37 | M12: “Receipt derived from self-reported timestamps” | P10_OBJECT | Rename P10 referent only | NO |
| R38 | M16: “receipt not after closure or not over exactly the closed set” | P10_OBJECT | Rename P10 referent only | NO |
| R39 | M26: “Each receipt claims completeness only within its committed L” | P10_OBJECT | Rename P10 referent only | NO |
| R40 | M27: “Receipt/replay uses a different TS iss, checkpoint key, VDS algorithm, or leaf encoding …” | SCITT_RECEIPT_OR_REPLAY_INPUT | Do not rename to P10 Adjudication Statement; mutation checks the transparency-log identity used by the SCITT Receipt/replay path | NO |
| R41 | M30: “receipt ref” in issuer-signed payload | SCITT_RECEIPT / IDENTIFIER | Preserve semantics; use explicit `SCITT Receipt reference` in prose if rewritten | NO |
| R42 | M35: `receipt.verifier_digest` | IDENTIFIER_OR_FIELD | Do not rename without schema/API compatibility decision | HOLD |
| R43 | AP1 result text: “issued receipt proves …” | P10_OBJECT | Rename P10 referent only | NO |
| R44 | AP1 result text: “receipt carries the AP1 limitation” | P10_OBJECT | Rename P10 referent only | NO |
| R45 | §8 source snapshot: “standard SCITT Receipt in COSE … 394” | SCITT_RECEIPT | Preserve | NO |

### Frozen M13/M14 compatibility decision

M13/R13 and M14/R14 are semantically P10-object occurrences, but their exact wording is part of the frozen P10 v0.1 `limitations` constant.

The frozen `StatementPayloadSchemaV0` r9 has SHA-256 `7fc847ea66114f87b22e79b5c93f55d80d3e92923b613a9ad8efee17df92a455`. The canonical bare `limitations` array is 5718 bytes with SHA-256 `7c9252664b112621087d0a74b3f8fd5ec50f9ed912cc0d1a611bc227d3d15214`. The S2b implementation checks those canonical bytes and digest exactly.

Therefore `-01` MUST preserve the legacy literal `receipt` inside those two frozen strings. Outside the frozen constant, descriptive prose uses `P10 Adjudication Statement`. The retained legacy literal does not denote a SCITT Receipt.

This is a compatibility-preserving editorial decision: **Changed semantics? NO**.

### Protected substring / name audit

These are not ordinary P10 `receipt` prose and MUST be protected from naive substring replacement:

- `ClaimReceipt` — proper name of prior work.
- `receipt_checkpoint_ref` — field/identifier.
- `receipt.evidence_digest` — schema/formal identifier in v0.1.1 notation.
- `receipt.verifier_digest` — schema/formal identifier in mutation test M35.
- plural `receipts` in descriptions of external JWS receipt systems / cross-instance metadata — classify by context, do not globally replace.

**Machine-reconciled gate finding:** former R40 is resolved as `SCITT_RECEIPT_OR_REPLAY_INPUT`. No `AMBIGUOUS` receipt occurrence remains. Global replacement remains prohibited because classifications are occurrence-specific.

## 5. S2a implementation limitation mapping

| ID | Ratified source | Behavior | `-01` target | Class | Profile semantics changed? |
|---|---|---|---|---|---|
| I-S2A-01 | `P10S2/Coverage.lean`, `v0.1.0-s2a-ratified` | C2 HALTs if any `T.rows` row is unavailable | §10.6 Known Limitations | IMPLEMENTATION LIMITATION | NO |
| I-S2A-02 | same | C2 requires `payload.isSome` for every `T.detailed` matching-sub entry before later relevance/authorization logic | §10.6 Known Limitations | IMPLEMENTATION LIMITATION | NO |
| I-S2A-03 | same | key-unavailable HALT applies to authorized issuer entries | §10.6 Known Limitations | IMPLEMENTATION LIMITATION | NO |

Interpretation: conservative liveness loss / soundness-preserving incompleteness. HALT is not an epistemic verdict.

## 6. S3 instance mapping

| ID | Executed/candidate source | Fact | `-01` target | Class | Profile semantics changed? |
|---|---|---|---|---|---|
| I-S3-01 | S3 facade | ES256 issuer authentication against preconfigured issuer table before append | §10.4 / App B.4 | IMPLEMENTED INSTANCE BEHAVIOR | NO |
| I-S3-02 | S3 facade | facade does not authorize issuer per subject, parse payload semantics, or enforce full Registration Policy | §10.6 | LIMITATION / NON-CLAIM | NO |
| I-S3-03 | S3 facade | `LeafEncodeV0(statement) <= 65535`, statement <= 65474 | App B.3 | INSTANCE LIMITATION | NO |
| I-S3-04 | S3 facade | detached COSE payload supplied separately when Signed Statement payload is null | App B.3/B.4 | INSTANCE MECHANISM | NO |
| I-S3-05 | profile + executed deployment | verifier needs exact checkpoint-bounded prefix and subject payload material; deployment maps this to auditor-equivalent content access | App B.3 | OPERATOR/SUBSTRATE REQUIREMENT | NO |
| I-S3-06 | S3 accepted tag | accepted `BINDING_MATCH` within frozen toy-profile scope and declared runtime | §10.5 / App C | IMPLEMENTATION EVIDENCE | NO |
| I-S3-07 | later HP application evidence | later application run reproduced accepted verdict digest and 14/14 reproduction checks | §10.5 / App C | LATER INTEGRATION EVIDENCE | NO |

## 7. License / availability trace

| ID | Artifact pin | Observed license / availability | `-01` treatment |
|---|---|---|---|
| LIC01 | profile `v0.1.1` | MIT | state directly |
| LIC02 | S2a `v0.1.0-s2a-ratified` | `LICENSE`: “NO LICENSE HAS BEEN SELECTED”; all rights reserved | do not call open-source / MIT at ratified pin |
| LIC03 | S2b `v0.1.1-s2b-public` | tag: `MIT OR Apache-2.0` | state public dual license |
| LIC04 | S3 `v0.1.0-s3-accepted` | repository private; no root `LICENSE` at accepted tag | describe as private/review artifact only unless Ivan publishes/licenses it |

## 8. Preconditions before first `-01` prose edit

- [x] Ivan ratified E03 on 2026-10-10; signed tag `v0.1.1-draft01-e03-ratified`.
- [x] Machine-assisted exact-source `receipt` occurrence scan recorded: 56/56 classified, 0 ambiguous.
- [x] R40 resolved as `SCITT_RECEIPT_OR_REPLAY_INPUT`; no P10-object rename.
- [x] Identifier renames are not authorized for the `-01` editorial pass; `receipt_checkpoint_ref` and `receipt.*` identifiers are preserved by default.
- [x] Mandatory limitation-byte implications resolved: M13/M14 preserve the frozen P10 v0.1 literal; canonical bytes and digest remain unchanged.
- [ ] RFC 7942 section skeleton contains removal notice and exact artifact/license boundaries.
- [ ] Full inherited BCP 14 traceability from `-00` is carried forward and updated only after draft text exists.

Remaining unchecked items are drafting/build/publication prerequisites; the receipt terminology gate itself is complete. The correct state remains **PRE-DRAFT / PREPARED, NOT RATIFIED**.
