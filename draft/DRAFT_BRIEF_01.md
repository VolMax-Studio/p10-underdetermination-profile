# Draft Brief — `draft-nestorov-scitt-p10-underdetermination-01`

**Status:** CANDIDATE PREPARATION ONLY. This brief does not ratify an erratum, amend P10 v0.1.1, authorize publication, or alter the submitted `-00` draft. Any row that would require `Changed semantics? = YES` is a STOP condition and must be resolved as a possible new profile release before `-01` prose is written.

**Prepared:** 2026-10-10

## 1. Revision identity

- Internet-Draft name remains **`draft-nestorov-scitt-p10-underdetermination`** so `-01` is a revision of `-00`.
- Candidate document title: **P10 Underdetermination Profile: Adjudication Statements over SCITT**.
- The title may change; the Internet-Draft name does not.
- `SCITT Receipt` remains reserved for the RFC 9942 / RFC 9943 receipt layer.
- Candidate P10 term: **P10 Adjudication Statement** for the P10 adjudication object/result. No global replacement is permitted until the occurrence audit in `TRACEABILITY_01_INITIAL.md` is gate-complete.

## 2. Source pins

| Item | Pin |
|---|---|
| P10 profile source of record | `P10_Underdetermination_Profile_v0.1.1.md` |
| Profile SHA-256 | `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558` |
| Profile tag / commit | `v0.1.1` → `e2a02a73df9e50f624512043dcb007fc337ba587` |
| Profile Zenodo version DOI | `10.5281/zenodo.22994744` |
| Submitted `-00` Markdown SHA-256 | `093f55572a07d34b033d50cc3e57bfb6c1dedc0b7856978e3bd5a519ec9ec1b5` |
| Submitted `-00` TXT SHA-256 | `00d46d1041a391c3ec03b77a1eb96a5221448a8a2d432b97d813cd63412da819` |
| Submitted `-00` XML SHA-256 | `c23cbbaa3c2b49f7523d7f4638bfdbbdb55759d17c87df4da71108da76a47612` |
| `-00` traceability SHA-256 | `1372b54cf4d7a414e74a51a15e49616dba97e52fb8fe17c41120803a72e0dc39` |
| IETF 127 I-D cutoff | 2026-11-02 23:59 UTC |
| Working submission target | 2026-10-23 through 2026-10-26 |

## 3. Fail-closed revision rule

The target for every profile-derived row is:

> **Changed semantics? NO**

Allowed classes in `-01`:

1. **UNCHANGED PROFILE** — transcribed from v0.1.1 with no semantic change.
2. **EDITORIAL TERMINOLOGY REPAIR** — wording changes only after occurrence-level classification establishes that the referent is unchanged.
3. **HUMAN-RATIFIED INTERPRETIVE RECORD** — an already ratified clarification that introduces no new field, checkpoint, acceptance condition, or profile obligation.
4. **CANDIDATE ERRATUM** — may be prepared, but MUST NOT be called ratified or incorporated as an adopted erratum until Ivan explicitly ratifies it.
5. **INSTANCE PROSE** — implementation/deployment facts learned from S2/S3; does not modify the abstract profile.
6. **RFC 7942 IMPLEMENTATION STATUS** — informative implementation report; does not modify profile semantics.
7. **NEW INFORMATIVE PROSE** — no BCP 14 keywords unless separately justified and traced.

If an accurate mapping requires `Changed semantics? YES`, drafting stops at that row and the issue is escalated to a possible new P10 profile release.

## 4. Errata and interpretive records

### 4.1 E01 — historical `-00` record

`-00` applied the already ratified replacement of the undefined `S_C` sentence with the actual issuer-signed payload fields:

- `evidence_closure_ref`
- `evidence_admission_refs`
- `preclosure_transcript_digest`

The old `DRAFT_BRIEF.md` rationale described `S_C` as “obsolete r2.3 notation”. **Do not carry that characterization into `-01`.** Current review finds `S_C` once in v0.1.1 and no definition for it.

Historical E01 remains part of the provenance of `-00`; `-01` does not rewrite that historical record.

### 4.2 E02 — human-ratified interpretive record for `S₁`

Human-ratified on 2026-10-03 in tag `v0.1.0-schema-r9-e02-ratified`, resolving to schema commit:

`4431d33e363d1684743f457eb709789e38568c8f`

Ratified interpretation:

> `S₁` is editorial outline notation and introduces no additional wire field, VDS checkpoint, or acceptance condition.

Schema SHA-256:

`7fc847ea66114f87b22e79b5c93f55d80d3e92923b613a9ad8efee17df92a455`

For `-01`, E02 is an **interpretive record**, not evidence that profile v0.1.1 gained a field or requirement.

### 4.3 E03 — CANDIDATE, PENDING IVAN RATIFICATION

**Source location:** profile v0.1.1 §2.6, the single use of `S_C`:

> To avoid a post-registration hash cycle, the issuer-signed payload binds `S_C`, ordered references, and the pre-closure transcript. The outer SCITT Receipt supplies `S_R`; `S_R`, the final replay transcript, and the coverage-verification result are not fields in the issuer-signed payload. Full-prefix replay occurs after receipt acquisition.

**Candidate interpretation:**

> `S_C` is undefined editorial shorthand in v0.1.1. In this sentence it denotes no additional wire field, checkpoint, digest, or acceptance condition. The issuer-signed bindings intended by the surrounding normative structure are the already enumerated `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`. The outer SCITT Receipt supplies `S_R` after registration.

**Candidate replacement sentence:**

> To avoid a post-registration hash cycle, the issuer-signed P10 payload binds `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`. The outer SCITT Receipt supplies `S_R`; `S_R`, the final replay transcript, and the coverage-verification result are not fields in the issuer-signed payload. Full-prefix replay occurs after Receipt acquisition.

**Why this is intended to be semantics-preserving:** the three fields already appear in the issuer-signed field list and in the closure/replay structure. E03 does not create a field, checkpoint, digest, acceptance condition, or new ordering rule.

**Status:** `PENDING HUMAN RATIFICATION`. Until Ivan explicitly ratifies E03, `-01` MUST NOT label it as a ratified erratum.

## 5. Profile vs. executed instance

### 5.1 Profile layer

Sections 1–9 of `-01` continue to describe the abstract P10 profile. S3-derived operational facts MUST NOT be silently promoted into abstract profile requirements.

The profile already requires `FullPrefixReplay` and already states that the verifier needs authorized access to the exact registered leaf bytes / protected headers through `S_R`, plus subject payloads needed for classification. `-01` does not add that obligation.

### 5.2 Instance / transparency-substrate layer

Appendix B describes what the executed P10-over-SCITT instance required in practice. In particular:

- exact checkpoint-bounded prefix `[0,n)`;
- exact Signed Statement bytes and protected headers;
- payload material needed by the frozen classification rules;
- preservation of registration order;
- `RFC9162_SHA256` for the executed instance;
- `LeafEncodeV0` and the executed `LogIdentityV0`;
- stable Receipt key for the executed instance;
- serialized lifecycle registration;
- issuer ES256 authentication in the facade;
- no claim that these instance choices become mandatory for arbitrary P10 profiles.

### 5.3 Auditor-level access mapping

The executed instance requires the P10 verifier to be provisioned with access at least equivalent to the RFC 9943 auditor/content-access role needed to obtain the material used for replay. This is an **operator/deployment requirement of the described P10-over-SCITT instance**, not a new abstract P10 v0.1.1 requirement.

The material may be supplied by the Transparency Service or associated storage. P10 does not require one storage architecture; it requires the replay material to be available to the verifier.

## 6. Proposed `-01` structure

1. Introduction
   - 1.1 Scope and Relationship to SCITT
   - 1.2 Profile, Instance, and Transparency Substrate
   - 1.3 Non-Claims
2. Conventions and Terminology
   - 2.1 P10 Adjudication Statement
   - 2.2 SCITT Signed Statement
   - 2.3 SCITT Receipt
   - 2.4 Profile vs. Instance Parameters
3. Formal Core
4. Instance Commitment and Subject
5. Full-Prefix Replay and Registration Order
6. Evidence Admission
7. Evidence Closure and Checkpoint-Bounded Coverage
8. Canonical Encoding
9. Statement and Predicate Structure
10. Implementation Status (RFC 7942)
11. Security Considerations
12. Privacy Considerations
13. IANA Considerations
14. References
Appendix A. Conformance Tests
Appendix B. Executed P10-over-SCITT Instance
Appendix C. Reproduction and Artifact Pins
Appendix D. Profile-to-Draft Traceability

## 7. RFC 7942 Implementation Status

Include the standard note that this section is to be removed before publication as an RFC.

### 7.1 Implementation identity

Organization: VolMax Studio Lab d.o.o.

Implementation family to describe:

- P10 profile / Lean artifacts;
- S2a coverage/evidence-closure kernel;
- S2b replay verifier;
- S3 P10-over-SCITT transparency deployment/capture path;
- Replay Workbench as an interface over the frozen replay chain.

### 7.2 Maturity and demonstrated scope

Describe as a **research prototype / executed demonstration**, not as production SCITT interoperability.

Demonstrated boundary:

- executed lifecycle over a two-bit toy semantic fixture;
- accepted S3 capture/result under the frozen S3-A definition;
- offline replay reproducing the accepted result;
- later HP application integration record reproducing the accepted `BINDING_MATCH` verdict;
- no claim of arbitrary-profile generality;
- no claim of arbitrary-SCITT-service interoperability;
- no claim of issuer/operator organizational independence.

### 7.3 S2a liveness limitation — MUST be disclosed in §10.6

Frozen S2a tag: `v0.1.0-s2a-ratified` → commit

`741d56d36d7b2bfe2e9e0080a1cba4393e4a47da`

The ratified implementation performs C2 availability checks before the later relevance/authorization logic. In `coverageCheck`:

- any transcript row marked unavailable causes `HALT(c2_rowUnavailable)`;
- every detailed matching-sub entry must have `payload.isSome`, otherwise `HALT(c2_subjectPayloadUnavailable)`;
- key unavailability for an authorized issuer also HALTs.

Therefore a matching-sub entry that is ultimately unauthorized can still prevent progress if its payload is unavailable. This is a **soundness-preserving liveness limitation / conservative incompleteness**: it can cause HALT, but cannot create an epistemic verdict.

Do not “repair” this in `-01`; disclose it as an implementation limitation.

### 7.4 S3 facade boundary

The executed facade authenticates issuer signatures with ES256 against a preconfigured issuer table before append and verifies checkpoint/inclusion material before issuing its Receipt.

It does **not** claim full RFC 9943 Transparency Service conformance. In particular, the prototype does not implement full Registration Policy authorization semantics such as authorizing particular issuers for particular subjects/payload policies. It also has no witnesses, key rotation, X.509 deployment, or multi-writer deployment.

### 7.5 Entry-size limitation and detached payloads — Appendix B.3

The S3 facade enforces:

- `len(LeafEncodeV0(statement)) <= 65535`;
- for this encoding, Signed Statement bytes are limited to `<= 65474`.

For a COSE statement with detached payload (`payload = null`), the signed payload is supplied separately to registration/authentication. This allows the logged Signed Statement to remain below the leaf-input limit, but required payload material still has to remain available for the frozen replay/admission rules.

This is an executed-instance / Tessera-facade constraint, not a generic P10 theorem.

## 8. License and availability matrix for §10 / Appendix C.3

| Artifact | Visibility / license statement to use in `-01` |
|---|---|
| `p10-underdetermination-profile` v0.1.1 | Public; MIT license. |
| `p10-coverage-lean-s2` at `v0.1.0-s2a-ratified` | Public repository, but the ratified tag's `LICENSE` explicitly says **NO LICENSE HAS BEEN SELECTED** and all rights are reserved. Do not describe the ratified S2a source as open-source under MIT merely because a later branch state differs. |
| `p10-replay-verifier` at `v0.1.1-s2b-public` | Public distribution; tag states **MIT OR Apache-2.0**. Underlying ratified checkpoint is `v0.1.0-s2b-complete`. |
| `p10-scitt-transparency-s3` at `v0.1.0-s3-accepted` | Private repository at present. No root `LICENSE` is present at the accepted tag. Do not promise public source or redistribution rights. Publicly expose only the artifacts Ivan explicitly chooses to publish. |
| Replay Workbench | Lives inside the private S3 repository at present; availability must be described separately from the publicly licensed S2b verifier. |

`Code and Artifact Availability` MUST distinguish **review access**, **public availability**, and **license rights**. A private or reviewable artifact is not thereby openly licensed.

## 9. Executed evidence pins currently suitable for Appendix C

### 9.1 S2a

- tag: `v0.1.0-s2a-ratified`
- commit: `741d56d36d7b2bfe2e9e0080a1cba4393e4a47da`
- preregistration v0.2.6 SHA-256: `d6fbeb13bf229d0e10c17031a887ef7944ae8e6acc68b6e898a007d5a851c9e0`
- `VerifierManifestS2aV0` SHA-256: `f8380b19b43334925e7f7621e1f7d7912f36c789199d3f8d069b87f5ea176d46`
- `VectorManifestS2aV0` SHA-256: `dd2d567e04fae52244feec988a56df26e4721f833f072dd7073959d9170e39ec`

### 9.2 S2b

- public tag: `v0.1.1-s2b-public`
- public-tag commit: `8e89f9a4192bdd0ab280556701dc595eb55539d2`
- license at public tag: MIT OR Apache-2.0
- underlying ratified checkpoint: `v0.1.0-s2b-complete`

### 9.3 S3 accepted result

- accepted tag: `v0.1.0-s3-accepted`
- accepted result/evidence commit: `5acc277a13dc122e39fcb5f9f3e646b06cc95009`
- capture/anchor commit: `149953c29780e566b0b23f7a1b975dc93349daf2`
- capture-index SHA-256: `2662c2daf912d2ce4796a26b13464d7bc2df6ba8825fa399fed3a87185d700a7`
- runner-verdict SHA-256: `6368022f06cc6ef6e4c9698cd45e71c44db505b4bf8b5812aaf0cbe26f41db22`
- accepted outcome: `BINDING_MATCH`, only within the frozen toy-profile scope and declared runtime.

The S3 acceptance tag explicitly did **not** claim an independent-host rerun at acceptance time. Later host/application evidence must be described as later evidence, not retroactively folded into the acceptance tag.

### 9.4 Later HP Replay Workbench integration evidence

`apps/replay-workbench/evidence/hp-20261009/NOTES.md` records a later HP application run. The successful job reports:

- application execution `COMPLETED`;
- wrapper exit `0`;
- P10 runner outcome `BINDING_MATCH`;
- stage `post-s2a`, reason code `BindingMatch`;
- `runner/verdict.json` SHA-256 equal to the accepted digest `6368022f...db22`;
- all 14 reproduction checks pass;
- reproduction `MATCH`.

The same evidence note states that these are application-generated integration records, not independent attestations.

## 10. Receipt terminology gate

Before editing any profile-derived prose, `TRACEABILITY_01_INITIAL.md` must be upgraded from initial audit to gate-complete audit.

Rules:

1. No global replacement of `receipt` / `Receipt`.
2. Every occurrence in v0.1.1 is classified by referent.
3. Minimum classes:
   - `P10_OBJECT` — candidate for editorial rename to `P10 Adjudication Statement` where grammar permits;
   - `SCITT_RECEIPT` — MUST remain `SCITT Receipt`;
   - `EXTERNAL_OR_PRIOR_ART` — preserve source terminology;
   - `IDENTIFIER_OR_FIELD` — change only if a separate compatibility decision authorizes it.
4. Normative rows receive an explicit `Changed semantics?` value.
5. If any occurrence cannot be classified unambiguously, editing stops at that occurrence.

## 11. Drafting / gate sequence

1. Freeze this brief and the initial traceability matrix as candidate planning artifacts only.
2. Ivan explicitly ratifies or rejects candidate E03.
3. Complete the machine-assisted occurrence audit of `receipt` / `Receipt` against exact v0.1.1 bytes.
4. Promote the occurrence matrix to gate-complete status.
5. Create `draft-nestorov-scitt-p10-underdetermination-01.md` from `-00`; do not edit the profile source artifact.
6. Apply only rows classified `NO semantic change` or informative instance/implementation prose.
7. Update full BCP 14 traceability and lowercase-modal tables inherited from `-00`.
8. Add RFC 7942 Implementation Status with removal notice.
9. Add Appendix B instance description, Appendix C pins/availability, Appendix D delta traceability.
10. Run `kdrfc -> xml2rfc -> idnits` under the pinned build toolchain.
11. Independent gate over exact `-01` bytes and traceability.
12. Ivan is the final ratifier before upload/publication.

## 12. Current STOP conditions

The following are intentionally unresolved and block final `-01` prose where relevant:

- E03 is **not ratified yet**.
- Receipt terminology audit is **initial**, not gate-complete.
- Exact public/private artifact set for Appendix C has not been selected by Ivan.
- `-01` source/build hashes do not exist until the source is created and built.

None of these blocks continued preparation of the brief, traceability matrix, or RFC 7942 section skeleton.
