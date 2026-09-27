# Traceability Matrix — draft-nestorov-scitt-p10-underdetermination-00

**Source of record:** `P10_Underdetermination_Profile_v0.1.1.md`, SHA-256 `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`, tag `v0.1.1` → commit `e2a02a73df9e50f624512043dcb007fc337ba587`, Zenodo version DOI `10.5281/zenodo.22994744`.

**Rule:** every BCP 14 keyword in the draft MUST trace to a row in Table 1 with the identical keyword and an equivalent obligation. A draft BCP 14 keyword with no row is a gate finding. Every row in Table 2 MUST remain lowercase (non-normative) in the draft. Status values: `TODO`, `TRANSCRIBED`, `VERIFIED` (gate only).

## Table 0 — Exemption

| ID | Src line | Treatment |
|---|---|---|
| X01 | 10 | BCP 14 key-word boilerplate. Replaced by the standard kramdown-rfc `{::boilerplate bcp14-tagged}` block; not a normative statement of the profile and not counted in Table 1. |

## Table 1 — Normative statements in v0.1.1 (17 source lines, boilerplate excluded)

| ID | Src line | Src section | Draft target | Keywords | Source text (verbatim) | Draft location | Status |
|---|---|---|---|---|---|---|---|
| N01 | 128 | 2.2 Issuance conditions | Sec 3.2 Issuance Conditions | MUST, MUST NOT | The resolved checker MUST construct `CertificateTargetV0` exclusively from the committed profile, closed evidence set, committed claim, and canonical receipt witnesses. The certificate MUST NOT supply or select its own target proposition. | Sec 3.2 Issuance Conditions | TRANSCRIBED |
| N02 | 136 | 2.2 Issuance conditions | Sec 3.2 Issuance Conditions | MUST NOT | ¬FormallyUnderdeterminationCapable(π, c)   → profile MUST NOT issue an underdetermination receipt | Sec 3.2 Issuance Conditions | TRANSCRIBED |
| N03 | 139 | 2.2 Issuance conditions | Sec 3.2 Issuance Conditions | MUST | For infinite `Wπ`, `Underdeterminedπ` is still checked with a concrete witness pair and decidable `Compatibleπ` and `Evalπ`. `Determinateπ(eᵈ, c)` is a universal claim: the verifier accepts a Lean proof term, but generation of such a proof is not guaranteed. If no proof term is available, preflight MUST return `HALT`, not an epistemic verdict. | Sec 3.2 Issuance Conditions | TRANSCRIBED |
| N04 | 151 | 2.3 `InstanceCommitment` and subject | Sec 4 Instance Commitment | MUST | `SubjectDeriveV0` uses frozen, domain-separated canonical encoding and returns a text string (`tstr`) for CWT `sub`. Its digest is bound by the commitment. Before the first evidence admission, the following MUST be registered: | Sec 4 Instance Commitment | TRANSCRIBED |
| N05 | 170 | 2.3 `InstanceCommitment` and subject | Sec 4 Instance Commitment | MUST | - `instance_owner_iss = issuer_id` in the same frozen canonical representation, and the commitment MUST carry a valid owner signature with that protected `iss`. | Sec 4 Instance Commitment | TRANSCRIBED |
| N06 | 171 | 2.3 `InstanceCommitment` and subject | Sec 4 Instance Commitment | MUST | - Uniqueness is checked **within committed L** by `(instance_owner_iss, request_id, instance_subject)`, where `instance_subject` MUST be the result of `SubjectDeriveV0(issuer_id, request_id)`. | Sec 4 Instance Commitment | TRANSCRIBED |
| N07 | 172 | 2.3 `InstanceCommitment` and subject | Sec 4 Instance Commitment | MUST | - Full replay MUST find exactly one valid `InstanceCommitment` for that tuple, containing exactly one `profile_digest` and `claim_digest`. Zero commitments yields `HALT`; two or more, or conflicting digests, yield `REJECT`. | Sec 4 Instance Commitment | TRANSCRIBED |
| N08 | 193 | 2.4 `FullPrefixReplay` and registration order | Sec 5 Full-Prefix Replay | MUST | “The same L” means the same `LogIdentityV0`: the same TS `iss`, checkpoint verification key, VDS algorithm, and leaf-encoding profile. The commitment's `log_identity_digest` MUST match the L identified by the outer receipt; a mismatch yields `REJECT`. | Sec 5 Full-Prefix Replay | TRANSCRIBED |
| N09 | 207 | 2.4 `FullPrefixReplay` and registration order | Sec 5 Full-Prefix Replay | MUST | The verifier MUST have authorized read access to the leaf bytes and protected headers of the entire Statement Sequence through `S_R`, as well as all payload bytes of subject-view candidates needed for classification under the frozen rules. Payloads for unrelated subjects are not required. Trust in the commitment-bound checkpoint key, VDS algorithm, and `LeafEncodeV0` is an explicit premise. If the complete prefix or a required subject payload is unavailable, the result is `HALT`, with no epistemic verdict. | Sec 5 Full-Prefix Replay | TRANSCRIBED |
| N10 | 209 | 2.4 `FullPrefixReplay` and registration order | Sec 5 Full-Prefix Replay | MUST | Replay verifies that the profile and unique commitment were registered before the first relevant admission, that exactly one valid owner-signed closure precedes the final receipt, and that all those entries are in committed L. An entry or proof from another log identity yields `REJECT`; a separate parallel log is outside the claim and MUST be disclosed by the limitation. P10 v0 uses `RFC9162_SHA256` (VDS alg `1`). Inclusion and consistency proofs may accompany the transcript, but do not by themselves prove the absence of other entries. | Sec 5 Full-Prefix Replay | TRANSCRIBED |
| N11 | 279 | 2.6 `EvidenceClosure` and checkpoint-bounded `CoverageProof` | Sec 7 Evidence Closure and Coverage | MUST, MUST | - `checkpoint_preclosure_transcript_digest` MUST describe the uninterrupted `ClosureTranscriptViewπ` subsequence immediately before the closure leaf. Entries for other subjects and unauthorized matching-`sub` entries do not invalidate closure. If a valid owner-signed lifecycle entry or `RelevantAdmissionπ` lands between transcript preparation and closure registration, that closure candidate is invalid (fail-closed). The issuer MUST replay the subject view, rebuild the references, and register a new closure; the invalid attempt is not counted as a valid closure. | — | TODO |
| N12 | 320 | 3. Semantic bridges and declared limitations | Sec 10 Security Considerations | SHOULD | Where sibling `InstanceCommitment` payloads are accessible, a verifier SHOULD report the number visible through `S_R` for the same `(instance_owner_iss, claim_digest)`. Version 0.1.1 assigns no acceptance or rejection semantics to that count. This recommendation does not expand the payload-availability requirement of `FullPrefixReplay`; mandatory sibling counting requires a future profile with an additional availability or indexing rule. | — | TODO |
| N13 | 324 | 3. Semantic bridges and declared limitations | Sec 10 Security Considerations | MUST | Every row of this table is included in the receipt's `limitations` field. The P10 predicate specification marks `limitations` as a mandatory **must-understand** field: a P10 verifier MUST reject a predicate without it, even though generic in-toto v1 rules otherwise require unknown fields to be ignored. | — | TODO |
| N14 | 363 | 4. Issuer-signed fields and post-registration verifier output (outline) | Sec 9 Statement and Predicate Structure | MUST | Before accepting the epistemic outcome, the verifier MUST establish `ActiveProfileBindingV0`. Registration order proves when the committed object entered `L`; it is not by itself evidence that the object was used. P10 establishes verifier-time use by independently resolving the unique instance-bound profile and its `VerifierManifestV0`, matching every required artifact, constructing `CertificateTargetV0` from the committed inputs, and type-checking the submitted certificate against that target under exactly that resolved combination. | — | TODO |
| N15 | 418 | 7.1 Mutation tests (MUST yield REJECT or the stated outcome) | Appendix A.1 Mutation Tests | MUST | ### 7.1 Mutation tests (MUST yield REJECT or the stated outcome) | — | TODO |
| N16 | 451 | 7.1 Mutation tests (MUST yield REJECT or the stated outcome) | Appendix A.1 Mutation Tests | MUST | \| M30 \| Issuer-signed P10 payload contains `S_R`, receipt ref, or final replay/coverage result \| REJECT; post-registration values MUST remain outside the payload \| | — | TODO |
| N17 | 479 | 7.4 Publication review requirement | OMIT (process) — deliberate omission of a process MUST; gate must confirm | MUST, MUST | An independent publication review MUST bind the exact SHA-256 of this artifact. The review MUST cover the complete document, including the formal core, closure and coverage semantics, declared trust boundaries, mutation tests, prior-art boundary, and publication metadata. A verdict over any other byte sequence does not apply to this artifact. | — | TODO |

Note: the §7.1 heading row (source line 418) makes the mutation-test tables normative in aggregate. Each of M1–M35 and AP1 is traced individually in Table 3.

## Table 2 — Lowercase modal words that MUST stay non-normative (16 source lines)

Every source line containing a lowercase modal word has its own row, including lines that also appear in Table 1 and compounds such as "must-understand". Only the capitalized keywords are normative; every word listed here stays lowercase in the draft.

| ID | Src line | Src section | Draft target | Words | Source text (verbatim) | Draft location | Status |
|---|---|---|---|---|---|---|---|
| L01 | 130 | 2.2 Issuance conditions | Sec 3.2 Issuance Conditions | required | Every artifact digest above binds both the exact bytes and its frozen artifact identifier or path and format. An unavailable required profile, manifest, checker, build, dependency, `.olean`, axiom-policy, acceptance-command, or toolchain artifact yields `HALT`, with no epistemic verdict. A digest mismatch, substitution, or certificate checked under any other profile, checker, build, axiom policy, or toolchain yields `REJECT`. | Sec 3.2 Issuance Conditions | TRANSCRIBED |
| L02 | 207 | 2.4 `FullPrefixReplay` and registration order | Sec 5 Full-Prefix Replay | required, required | The verifier MUST have authorized read access to the leaf bytes and protected headers of the entire Statement Sequence through `S_R`, as well as all payload bytes of subject-view candidates needed for classification under the frozen rules. Payloads for unrelated subjects are not required. Trust in the commitment-bound checkpoint key, VDS algorithm, and `LeafEncodeV0` is an explicit premise. If the complete prefix or a required subject payload is unavailable, the result is `HALT`, with no epistemic verdict. | Sec 5 Full-Prefix Replay | TRANSCRIBED |
| L03 | 209 | 2.4 `FullPrefixReplay` and registration order | Sec 5 Full-Prefix Replay | may | Replay verifies that the profile and unique commitment were registered before the first relevant admission, that exactly one valid owner-signed closure precedes the final receipt, and that all those entries are in committed L. An entry or proof from another log identity yields `REJECT`; a separate parallel log is outside the claim and MUST be disclosed by the limitation. P10 v0 uses `RFC9162_SHA256` (VDS alg `1`). Inclusion and consistency proofs may accompany the transcript, but do not by themselves prove the absence of other entries. | Sec 5 Full-Prefix Replay | TRANSCRIBED |
| L04 | 278 | 2.6 `EvidenceClosure` and checkpoint-bounded `CoverageProof` | Sec 7 Evidence Closure and Coverage | required | - No closure, replay, or required payload bytes → `HALT`, with no epistemic verdict. A conflicting commitment/closure, or an omitted, duplicated, misordered, unauthorized, or post-closure relevant admission → `REJECT`. | — | TODO |
| L05 | 304 | 3. Semantic bridges and declared limitations | Sec 10 Security Considerations | required | \| Replay/order \| The complete VDS prefix of committed L reconstructs `S_R` and registration order (§2.4) \| Authorized access to all leaf/protected-header data and required subject payloads; registration order is not issuance order; other logs are outside the claim \| | — | TODO |
| L06 | 314 | 3. Semantic bridges and declared limitations | Sec 10 Security Considerations | may | > `FormallyUnderdeterminationCapable` does not establish that the determining evidence fixture is practically obtainable, representative, or likely to occur under the deployed acquisition process. A formally valid profile may remain operationally abstention-biased. | — | TODO |
| L07 | 324 | 3. Semantic bridges and declared limitations | Sec 10 Security Considerations | must | Every row of this table is included in the receipt's `limitations` field. The P10 predicate specification marks `limitations` as a mandatory **must-understand** field: a P10 verifier MUST reject a predicate without it, even though generic in-toto v1 rules otherwise require unknown fields to be ignored. | — | TODO |
| L08 | 348 | 4. Issuer-signed fields and post-registration verifier output (outline) | Sec 9 Statement and Predicate Structure | must | limitations                   -- mandatory must-understand P10 field | — | TODO |
| L09 | 361 | 4. Issuer-signed fields and post-registration verifier output (outline) | Sec 9 Statement and Predicate Structure | may | These post-registration values are P10 verifier output over the Transparent Statement. They may be serialized in a separate verification report, but are not part of the issuer-signed P10 predicate and do not enter its digest. The standard SCITT Receipt remains in COSE unprotected-header label `394`, avoiding a hash cycle. | — | TODO |
| L10 | 363 | 4. Issuer-signed fields and post-registration verifier output (outline) | Sec 9 Statement and Predicate Structure | required | Before accepting the epistemic outcome, the verifier MUST establish `ActiveProfileBindingV0`. Registration order proves when the committed object entered `L`; it is not by itself evidence that the object was used. P10 establishes verifier-time use by independently resolving the unique instance-bound profile and its `VerifierManifestV0`, matching every required artifact, constructing `CertificateTargetV0` from the committed inputs, and type-checking the submitted certificate against that target under exactly that resolved combination. | — | TODO |
| L11 | 365 | 4. Issuer-signed fields and post-registration verifier output (outline) | Sec 9 Statement and Predicate Structure | required | **The only v0 envelope:** a SCITT Signed Statement (`COSE_Sign1`) whose payload is an in-toto Statement v1 with the P10 predicate. After registration and attachment of a SCITT Receipt, it becomes a Transparent Statement. Profile commitment, instance commitment, evidence admissions, evidence closure, and final P10 adjudication statement use the same pattern, the same L, and the same protected CWT `sub`. A bare in-toto predicate, standalone signed in-toto envelope, or SCITT Statement without the required Receipt is insufficient. No new wire format is introduced. | — | TODO |
| L12 | 377 | 5. Prior art | Appendix B Prior Art | may | \| **Pramāṇa (arXiv 2605.20312 v1)** \| Typed `ClaimAttestation`; `verify(claim, source)` returns VERIFIED/REJECTED/UNVERIFIABLE; a deterministic theorem prover may be an oracle for `InferenceClaim`; A2A/MCP wire extension and source-byte digest. \| Does not freeze a pre-evidence world class or compatibility semantics. UNVERIFIABLE is an outcome label without a concrete divergent witness pair. \| | — | TODO |
| L13 | 378 | 5. Prior art | Appendix B Prior Art | must | \| **ClaimReceipt (arXiv 2609.01992 v1)** \| Claim sufficiency is defined over executions: identical retained evidence must imply an identical claim value (§2.1, Eq. 1). It explicitly describes the identification boundary/divergent executions, distinguishes contract and evidential abstention (`I_C`, `I_E`, §5.1), freezes the specification before implementation (§4.1), and places a signed manifest and assignment matrix with an OpenTimestamps proof before prospective ingress (§3.3). Coverage is a set property and requires manifest/ingress commitment before outcome. \| P10 closure/reconciliation follows the same broad prospective-ingress/terminal-reconciliation pattern; generic coverage is not novel to P10. The narrower remainder is that ClaimReceipt does not freeze an explicit world class with executable `Compatibleπ`, nor does INCONCLUSIVE carry a concrete divergent witness pair checked by the Lean kernel and registration-order-bound to the profile/instance. \| | — | TODO |
| L14 | 432 | 7.1 Mutation tests (MUST yield REJECT or the stated outcome) | Appendix A.1 Mutation Tests | required | \| M11 \| Bare in-toto predicate, standalone signed in-toto envelope, or SCITT Statement without the required Receipt \| REJECT \| | — | TODO |
| L15 | 445 | 7.1 Mutation tests (MUST yield REJECT or the stated outcome) | Appendix A.1 Mutation Tests | required | \| M24 \| A detached/encrypted payload required by frozen admission rules is unavailable \| HALT, no epistemic verdict \| | — | TODO |
| L16 | 454 | 7.1 Mutation tests (MUST yield REJECT or the stated outcome) | Appendix A.1 Mutation Tests | required | \| M33 \| Checker source, `.olean` artifact, dependency lock, Lean toolchain, axiom policy, acceptance command, or build manifest differs from `VerifierManifestV0` \| REJECT; unavailable required artifact → HALT, with no epistemic verdict \| | — | TODO |

## Table 3 — Mutation and adversarial tests

| Test | Src line | Draft location | Expected outcome unchanged? | Status |
|---|---|---|---|---|
| M1 | 422 | Appendix A | — | TODO |
| M2 | 423 | Appendix A | — | TODO |
| M3 | 424 | Appendix A | — | TODO |
| M4 | 425 | Appendix A | — | TODO |
| M5 | 426 | Appendix A | — | TODO |
| M6 | 427 | Appendix A | — | TODO |
| M7 | 428 | Appendix A | — | TODO |
| M8 | 429 | Appendix A | — | TODO |
| M9 | 430 | Appendix A | — | TODO |
| M10 | 431 | Appendix A | — | TODO |
| M11 | 432 | Appendix A | — | TODO |
| M12 | 433 | Appendix A | — | TODO |
| M13 | 434 | Appendix A | — | TODO |
| M14 | 435 | Appendix A | — | TODO |
| M15 | 436 | Appendix A | — | TODO |
| M16 | 437 | Appendix A | — | TODO |
| M17 | 438 | Appendix A | — | TODO |
| M18 | 439 | Appendix A | — | TODO |
| M19 | 440 | Appendix A | — | TODO |
| M20 | 441 | Appendix A | — | TODO |
| M21 | 442 | Appendix A | — | TODO |
| M22 | 443 | Appendix A | — | TODO |
| M23 | 444 | Appendix A | — | TODO |
| M24 | 445 | Appendix A | — | TODO |
| M25 | 446 | Appendix A | — | TODO |
| M26 | 447 | Appendix A | — | TODO |
| M27 | 448 | Appendix A | — | TODO |
| M28 | 449 | Appendix A | — | TODO |
| M29 | 450 | Appendix A | — | TODO |
| M30 | 451 | Appendix A | — | TODO |
| M31 | 452 | Appendix A | — | TODO |
| M32 | 453 | Appendix A | — | TODO |
| M33 | 454 | Appendix A | — | TODO |
| M34 | 455 | Appendix A | — | TODO |
| M35 | 456 | Appendix A | — | TODO |
| AP1 | 462 | Appendix A | — | TODO |

## Table 4 — Section map (complete; every source section accounted for)

| Source section | Draft target | Treatment |
|---|---|---|
| P10 Underdetermination Profile v0.1.1 | Front matter | Title/version → draft front matter; "Hard deadline" line dropped (process metadata) |
| 1. Claim of record | Sec 1 Introduction | Transcribe; no semantic change |
| 2. Formal core | Sec 3 Formal Core | Heading only |
| 2.1 Definitions | Sec 3.1 Definitions | Transcribe; no semantic change |
| 2.2 Issuance conditions | Sec 3.2 Issuance Conditions | Transcribe; no semantic change |
| 2.3 `InstanceCommitment` and subject | Sec 4 Instance Commitment | Transcribe; no semantic change |
| 2.4 `FullPrefixReplay` and registration order | Sec 5 Full-Prefix Replay | Transcribe; no semantic change |
| 2.5 `EvidenceAdmission` | Sec 6 Evidence Admission | Transcribe; no semantic change |
| 2.6 `EvidenceClosure` and checkpoint-bounded `CoverageProof` | Sec 7 Evidence Closure and Coverage | Transcribe; no semantic change |
| 2.7 Canonical codec | Sec 8 Canonical Encoding | Transcribe; no semantic change |
| 3. Semantic bridges and declared limitations | Sec 10 Security Considerations | Transcribe; no semantic change |
| 4. Issuer-signed fields and post-registration verifier output (outline) | Sec 9 Statement and Predicate Structure | Transcribe; no semantic change |
| 5. Prior art | Appendix B Prior Art | Transcribe; no semantic change |
| 6. Explicit non-claims | Sec 1.2 Non-Claims | Transcribe; no semantic change |
| 7. Conformance and independent-review criteria | Appendix A Conformance Tests | Heading only |
| 7.1 Mutation tests (MUST yield REJECT or the stated outcome) | Appendix A.1 Mutation Tests | Transcribe; no semantic change |
| 7.2 Adversarial-profile test | Appendix A.2 Adversarial-Profile Test | Transcribe; no semantic change |
| 7.3 Prior-art boundary question | Appendix B Prior Art | Transcribe; no semantic change |
| 7.4 Publication review requirement | OMIT (process) | Omitted from the draft; release/review process, not protocol. Omission recorded here for the gate. |
| 8. Source snapshot and verification boundaries | Appendix C Source Snapshot | Transcribe; no semantic change |
| 9. Publication path | OMIT (process) | Omitted from the draft; release/review process, not protocol. Omission recorded here for the gate. |
| 10. Change log | Appendix D Document History | Transcribe; no semantic change |
| v0.1.1 — 2026-09-27 | Appendix D Document History | Transcribe as source history; add a line stating the draft-00 transcription made no semantic change |

## Table 5 — NEW-PROSE register (text with no v0.1.1 source)

Every sentence in the draft that has no v0.1.1 source is listed here. NEW-PROSE MUST contain no BCP 14 keyword. Expected locations: Abstract (summary), Privacy Considerations (D4), IANA Considerations sentence (D3), Acknowledgments (D8), Document History "-00" line.

| ID | Draft location | Sentence (verbatim) | BCP 14 keywords (must be none) | Status |
|---|---|---|---|---|
| P01 | Abstract | P10 defines a third-party-verifiable binding for NotDemonstrated(reason=underdetermined). | none | TRANSCRIBED |
| P02 | Abstract | A conforming receipt carries two canonical witness worlds that are compatible with the same closed evidence set and produce different values for the same frozen claim. | none | TRANSCRIBED |
| P03 | Abstract | The witness result is checked against committed profile semantics and bound into a SCITT Transparent Statement containing an in-toto Statement v1 predicate. | none | TRANSCRIBED |
| P04 | Abstract | The result establishes underdetermination only relative to the declared profile and does not identify the actual world or establish either claim value as true. | none | TRANSCRIBED |
| P05 | IANA Considerations | This document has no IANA actions. | none | TRANSCRIBED |
| P06 | Sec 1.1 Scope and Relationship to SCITT | The profile defines a third-party-verifiable underdetermination binding for SCITT using an in-toto Statement v1 predicate; the envelope structure is specified in Section 9. | none | TRANSCRIBED |
| P07 | Sec 2 Conventions and Terminology | The following notation and symbols are defined in the referenced sections: | none | TRANSCRIBED |
| P08 | Sec 2 Conventions and Terminology | Wπ, Compatibleπ, and Evalπ are defined in Section 3.1. | none | TRANSCRIBED |
| P09 | Sec 2 Conventions and Terminology | Eπ and VerifierManifestV0 are defined in Section 3.2. | none | TRANSCRIBED |
| P10 | Sec 2 Conventions and Terminology | InstanceCommitment is defined in Section 4. | none | TRANSCRIBED |
| P11 | Sec 2 Conventions and Terminology | L and S_R are defined in Section 5. | none | TRANSCRIBED |
| P12 | Sec 2 Conventions and Terminology | SubjectView, RelevantAdmissionπ, EvidenceClosure, and CoverageProof are defined in Section 7. | none | TRANSCRIBED |
| P13 | Sec 3.2 Issuance Conditions | The prerequisites in this summary are detailed in Section 4 for instance commitment, Section 5 for profile registration and replay, Section 7 for coverage closure, and Section 8 for canonical world encoding. | none | TRANSCRIBED |
