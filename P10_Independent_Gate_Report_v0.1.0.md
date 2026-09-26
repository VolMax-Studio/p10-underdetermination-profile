# P10 v0.1.0 Independent Publication Gate Report

**Status:** Independent publication gate — completed.
**Artifact under review:** `P10_Underdetermination_Profile_v0.1.0.md`
**Bound artifact SHA-256:** `415b976580fc58b0557ae3705aac219e2dd722fb474d6e6bb80d83953d9909b8`
**Nature of this record:** technical publication review only. It is not human ratification and not publication authorization.

---

## 1. Verified Input

The gate was executed over the exact bytes present in the review directory. No file was modified.

**Independent SHA-256 computation (recomputed, not transferred):**

| File | Computed SHA-256 | SHA256SUMS entry | Match |
|---|---|---|---|
| `P10_Underdetermination_Profile_v0.1.0.md` | `415b976580fc58b0557ae3705aac219e2dd722fb474d6e6bb80d83953d9909b8` | identical | ✓ |
| `README.md` | `5f67c68c009df54044b3a99895f4e282b47db20421e5406007d01777d4f58fbe` | identical | ✓ |
| `SOURCE_SNAPSHOT.md` | `88a1b231ac3b5825b2774daddb76757436feeb8a4754f585fc158fd662a5c3bb` | identical | ✓ |
| `CITATION.cff` | `6aebc969987a9b1ab1a8a4b571b32a85fd72a06aec3b0a320d4b73cd4ac9eab5` | identical | ✓ |
| `LICENSE` | `e5d6d5ebcebd8e1d8b00051fc39cc51f7f0bcbe775be8c95a9c80399eca81906` | identical | ✓ |

- The profile artifact digest **equals the bound value** `415b976580fc58b0557ae3705aac219e2dd722fb474d6e6bb80d83953d9909b8`. This verdict is bound exclusively to that digest.
- The profile was read in full (434 lines, 36,093 bytes — the entire byte range).
- `SOURCE_SNAPSHOT.md` (line 10) records the same profile digest; it is consistent with the independently computed value.
- The prior gate record (`P10_Independent_Gate_Report_v0.1.0.md`) states `PENDING`; no prior verdict is carried forward.

---

## 2. Scope and Method

The complete artifact was reviewed as a whole (not a diff), covering: the record-level claim (§1); formal definitions (§2.1); issuance conditions and precommitments (§2.2); `InstanceCommitment`, subject derivation, and uniqueness tuple (§2.3); log identity `LogIdentityV0`, leaf encoding `LeafEncodeV0`, and full-prefix replay (§2.4); `EvidenceAdmission` and admitter/lifecycle authorization (§2.5); `EvidenceClosure`, `CoverageProofπ`, `SubjectView`, `ClosureTranscriptViewπ`, and `RelevantAdmissionπ` semantics (§2.6); canonicalization/codec (§2.7); trust boundaries and mandatory verbatim limitations (§3, AP1 + coverage/instance text); envelope and issuer-signed vs post-registration field separation (§4); prior art (§5); explicit non-claims (§6); mutation tests M1–M30 and adversarial test AP1, prior-art boundary, publication-review requirement (§7); source snapshot (§8); publication path (§9). BCP 14 usage, metadata (`CITATION.cff`, `LICENSE`, `README.md`), and internal cross-references were also checked.

Method: full read; independent digest computation and manifest check; label-completeness enumeration; targeted verification of the four mandated technical properties (unauthorized matching-`sub` neutrality, lifecycle/`RelevantAdmissionπ` fail-closed invalidation, M15/M19 tuple content, prior-art boundary); and cross-reference consistency sweep.

---

## 3. Findings

**3.1 Formal core (§2.1–§2.2).** Definitions of `NonemptyCompatibleπ`, `Determinateπ`, `Underdeterminedπ`, `ProfileAdmissible`, and `FormallyUnderdeterminationCapable` are internally consistent. `FormallyUnderdeterminationCapable(π,c) → ProfileAdmissible(π,c)` holds (both require an `eᵈ` with `Determinateπ`). The preflight rule correctly distinguishes `HALT` (no witness/proof term, absent commitment) from `REJECT` and from an epistemic verdict. The infinite-`Wπ` treatment (concrete witness pair + decidable `Compatibleπ`/`Evalπ`; universal `Determinateπ` via accepted Lean proof term, else `HALT`) is coherent. The disclaimer that `UnfalsifiableAsStated` is not derived from profile failure is present (§2.2) and reinforced by M9.

**3.2 Precommitment and subject binding (§2.3).** All frozen-before-evidence items are enumerated (§2.2 "Frozen and digested" list; §2.3 commitment field list). `instance_subject := SubjectDeriveV0(issuer_id, request_id)`; `instance_owner_iss = issuer_id`; owner-signature requirement present. Uniqueness is checked within committed `L` by the tuple `(instance_owner_iss, request_id, instance_subject)`. Zero commitments → `HALT`; two or more / conflicting digests → `REJECT`. Consistent.

**3.3 Log identity, leaf encoding, full-prefix replay (§2.4).** `LogIdentityV0` and `LeafEncodeV0` are frozen and digest-bound. `FullPrefixReplay` reconstructs the `RFC9162_SHA256` VDS root over `[0, size(S_R))` and requires `reconstructed_root = root(S_R)` plus checkpoint signature verification. Selected inclusion/consistency proofs are explicitly stated to be insufficient for absence (line 160), consistent with M18. Cross-log entries → `REJECT`; missing prefix/payload → `HALT`. The Registration Policy is correctly demoted to defense-in-depth, not a soundness premise.

**3.4 Closure, coverage, and `ClosureTranscriptViewπ` (§2.6).** `SubjectView`, `ClosureTranscriptViewπ`, `RelevantAdmissionπ`, `EvidenceClosure`, and `CoverageProofπ` are mutually consistent. Coverage requires exactly one valid `InstanceCommitment`, exactly one owner-signed `EvidenceClosure`, strictly ascending, duplicate-free `ordered_admission_refs`, every pre-closure `RelevantAdmissionπ` present exactly once, none after closure through `S_R`, and `e = Bundleπ(...) ∈ Eπ` with `receipt.evidence_digest = digest(e)`. The within-batch ordering role of the transparency service is disclosed as an explicit trust assumption (§2.6 line 231; §3 "Within-batch order" row) whenever `Bundleπ` is order-sensitive.

**3.5 Unauthorized-entry neutrality vs. valid-entry fail-closed (mandated check — PASS).** §2.6 line 230 states that entries for other subjects and **unauthorized matching-`sub` entries do not invalidate closure**, while a **valid owner-signed lifecycle entry or `RelevantAdmissionπ`** landing between transcript preparation and closure registration renders the closure candidate invalid (fail-closed → replay/rebuild/retry). This is structurally enforced because `ClosureTranscriptViewπ` (line 196–200) admits only valid owner-signed lifecycle entries or `RelevantAdmissionπ` entries; unauthorized matching-`sub` entries are outside the view by construction. Reinforced by §2.3 line 126, §2.5 line 185, and M20/M28/M29. The required property holds exactly.

**3.6 Canonicalization and witness binding (§2.7).** JCS (RFC 8785) with a unique normal form (`decode ∘ encode = id`), noncanonical-witness rejection, SHA-256 over JCS bytes for structured digests, and raw-bytes-plus-media-type for binary artifacts. Semantic distinctness of `w₀`/`w₁` follows from `Evalπ(c,w₀) ≠ Evalπ(c,w₁)` and canonical uniqueness (§2.1 note). Consistent.

**3.7 Envelope and field separation (§4).** A single v0 envelope (SCITT `COSE_Sign1` → in-toto Statement v1 → Transparent Statement after Receipt). Issuer-signed fields and post-registration fields (`S_R`, receipt ref, replay/coverage result) are separated to avoid a post-registration hash cycle; the SCITT Receipt stays in COSE unprotected label `394`. Consistent with §2.6 line 233 and enforced by M30.

**3.8 Trust boundaries and mandatory limitations (§3).** The oracle/limitation table is complete and honest about what Lean does and does not check. Both the AP1 limitation and the coverage/instance limitation are provided verbatim and marked mandatory must-understand receipt content, with a verifier obligation to reject a predicate lacking `limitations` (enforced by M17). AP1 is correctly framed as a profile-adequacy concern outside the mathematical core.

**3.9 Mutation-label completeness (mandated check — PASS).** The §7.1 table contains exactly M1, M2, …, M30 in sequence: **no gap and no duplicate.** Outcomes are `REJECT`/`HALT`/scoped-outcome as appropriate and fail closed.

**3.10 M15 / M19 tuple content after renumbering (mandated check — PASS).**
- **M15** (line 369): "Within committed L, another `profile_digest` or `claim_digest` exists under **`(instance_owner_iss, request_id, instance_subject)`**" → REJECT.
- **M19** (line 373): "Within committed L, another valid commitment or conflicting profile/claim exists for **`(instance_owner_iss, request_id, instance_subject)`**" → REJECT.

Both carry the explicit tuple `(instance_owner_iss, request_id, instance_subject)` and are consistent with the §2.3 uniqueness rule.

**3.11 AP1 (§7.2).** Correctly classified as a profile-adequacy issue, not a soundness hole: the receipt still proves the true proposition `Underdeterminedπ(e,c)` relative to the profile, and the AP1 limitation travels in the receipt. Mandatory profile-adequacy review is externalized (first: Sandia EFC).

**3.12 Prior art and non-claims (§5, §6, §8).** The prior-art table cleanly separates paper-reported claims from inspected-artifact facts (notably the Koomullil `MCR.lean` mismatch, with the non-attribution stated). Non-claims are explicit and cover reality-faithfulness, actual-world identification, registration-vs-issuance order, cross-log/other-`request_id` scope, and market/commercial priority. Source boundaries and "not independently executed" items are disclosed.

**3.13 BCP 14, metadata, cross-references.** The RFC 2119/RFC 8174 invocation (line 10) is correct and all-caps usage is consistent with normative intent. `CITATION.cff` (v0.1.0, MIT, author Ivan Nestorov, 2026-09-26) is consistent with `LICENSE` and `README.md`. Section cross-references (§§2.3–2.7, §1(1), AP1) resolve to existing targets.

---

## 4. Blockers

**None.** No substantive technical contradiction, missing mandatory element, mislabeled or missing mutation, broken precommitment/coverage invariant, hash-cycle exposure, or misbound digest was found. The artifact digest matches the bound value.

---

## 5. Non-blocking Findings

1. **Field-name variance for the pre-closure transcript digest.** `EvidenceClosure` binds `checkpoint_preclosure_transcript_digest` (§2.6, line 214), while the issuer-signed payload enumerates `preclosure_transcript_digest` (§4, line 285) with an annotation tying it to §2.6. Intent is unambiguous, but the two identifiers are not lexically identical; a future editorial pass could unify the spelling.
2. **`S_C` referenced without a dedicated defining line.** The closure checkpoint `S_C` appears in §2.6 (line 233) and is implied in §4, but lacks a standalone definition analogous to those given for `S₁` and `S_R`. No semantic ambiguity results.
3. **Typography.** The publication-candidate/hard-deadline dates (lines 5–6) and part of line 10 use U+2011 non-breaking hyphens rather than ASCII hyphens. Purely cosmetic; no effect on digest interpretation or meaning.
4. **Self-reported external identifiers.** The arXiv identifiers, GitHub commit `8e5b718…`, and Lean blob hashes are primary-source self-reports per §8 and `SOURCE_SNAPSHOT.md`; they were not re-fetched in this gate. The document already discloses this boundary ("not independently executed"), so it is a disclosed limitation rather than a defect.

None of these alter any normative requirement, mutation outcome, or verification invariant.

---

## 6. Prior-Art Boundary Answer

**Question (§7.3):** Do Pramāṇa or ClaimReceipt already require pre-evidence commitment of the model class / compatibility semantics *and* carry a concrete divergent witness pair in the receipt?

**Answer: No.**

- **Pramāṇa (arXiv 2605.20312v1):** its commitment is the `source_digest` of retrieved bytes consumed by `verify(claim, source)`; it does not freeze a pre-evidence world class or executable compatibility semantics, and its `UNVERIFIABLE` outcome carries no concrete divergent witness pair.
- **ClaimReceipt (arXiv 2609.01992v1):** it does provide pre-ingress manifest/specification and coverage precommitment and execution-level sufficiency, and it remains the closest prior art for that prospective-ingress / terminal-reconciliation pattern (P10's generic coverage is not novel). However, it does not freeze an explicit world class `Wπ` with an executable `Compatibleπ`, and its `INCONCLUSIVE` outcome does not carry a concrete divergent witness pair kernel-checked and registration-order-bound to the profile/instance.

Consequently the P10 publication claim **survives without expansion**, correctly scoped as a narrower **profile-and-binding contribution**, not a new mathematical theorem. This is consistent with the artifact's own §7.3 answer and its §6 non-claims.

---

## 7. Verdict

**PASS — survives independent publication review.**

This verdict is bound exclusively to profile SHA-256 `415b976580fc58b0557ae3705aac219e2dd722fb474d6e6bb80d83953d9909b8` and applies to no other byte sequence. There are no blockers; the non-blocking findings in §5 are editorial and do not gate publication.

This is a technical review only. Human ratification and publication authorization remain separate acts to be performed after this `PASS`, per the artifact's §9 and the review record's closing note.
