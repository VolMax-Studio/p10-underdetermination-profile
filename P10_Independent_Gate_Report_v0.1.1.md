# P10 Underdetermination Profile v0.1.1 — Independent Publication Gate Report (Final Patch)

**Gatekeeper:** Claude (Anthropic), read-only independent gate. No candidate byte was modified.
**Review date:** 2026-09-27
**Artifact under review:** `P10_Underdetermination_Profile_v0.1.1.md`
**SHA-256:** `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`

**Gate history for v0.1.1.**
1. Full publication gate: PASS for `1679620659bf4b56f6a688a490210e6840c9ca49be9c4f651339de287ca93370`. Report SHA-256 `98c7d9474a848b1ca8db0ef8f4e2ec926d20da89d72c0aad6205ab2b82928480`. It raised non-blocking corrections N1–N8.
2. This limited final-patch gate reviews only the diff that applies N1–N8. That prior PASS does not transfer to the new candidate. The findings of the full gate on tasks A–F and the prior-art boundary are carried forward unchanged, except where this diff touches them.

## 1. Verified input

- `sha256sum -c P10_V0_1_1_FINAL_PATCH_GATE_SHA256SUMS` returns OK for all 8 entries. Manifest SHA-256 `3c143f2c3d5dd2ec18471dcaaafa1c987f4f2a4e6e1994cea9dd224c1d5d51d6`; ZIP SHA-256 `1756e0a8f982a2b26b96d49682412ff9b141bbe853982a7acb322c5eca910a2f`. The loose gate request is byte-identical to the one in the ZIP.
- `P10_Underdetermination_Profile_v0.1.1_PASS_INPUT.md` is byte-identical to the artifact previously gated (`1679…3370`).
- **Forward:** applying `P10_v0.1.1_PASS_to_final.diff` (`d7d6a9610800777712ff7adb6ea63c1b3d6da4d34b04c1ee330f9b6d1c79dd12`) to the PASS input reproduces the new candidate byte-for-byte.
- **Reverse:** reversing the same diff from the new candidate reproduces the PASS input byte-for-byte.
- **Protected blocks** in the new candidate, computed independently:
  - §2.1: `885cbc641f5bf673219d36e1ae4161d81aa658451080ceb2e90bd563e0397119` — match
  - §2.6: `a9f9a9523800371c40f53d739cf7c0a68d5dbbf74b4c7eec87d16af66422d241` — match
  - M1–M30 (30 rows): `766be4bcc01346134b43fdb3638426a7a6518efd1d543904c56cb45cfb86cde5` — match
  - §7.2 AP1: `18d7f086038aa54f664289742fe3c6d618d89a4ec14cb38f1721ca6ae59082ad` — match
- **Publication manifest.** `SHA256SUMS` (`f4e86ad3fc7b95ca619251f321fc31aac6508f19230e659abb1778c6d9154a72`) matches the supplied profile, README, CITATION, and source snapshot. LICENSE is listed at `e5d6d5eb…1906`, identical to the previously inspected LICENSE.
- **Derived-file changes** against the previously supplied copies:
  - README: one sentence, now scoped "Among the sources inspected for this release".
  - CITATION: `date-released` line removed, nothing else changed.
  - SOURCE_SNAPSHOT: profile hash updated, Krausz date changed to 2026-09-22, Krausz mapping description added.

## 2. Diff scope

The profile diff contains exactly these changes, all permitted:

- **N1:** the `CertificateTargetV0` definition, the `certificate.type = CertificateTargetV0(π, e, c, w₀, w₁)` conjunct in `ActiveProfileBindingV0`, and the checker-constructed-target rule; M34.
- **N2:** "verifier-time use" in §4, and the target-construction step in the same sentence.
- **N3:** Krausz date 2026-09-22 in §8.
- **N4:** Krausz mapping resolution and the narrower-remainder sentence in §5.
- **N5:** M31 restated mechanically.
- **N6:** M35.
- **Change log:** the single §10 line, now M31–M35 plus the target requirement.

No other byte changed. The mandatory limitations, evidence-closure semantics, M1–M30, and AP1 are untouched.

## 3. Substantive checks

- **Target construction.** `CertificateTargetV0(π, e, c, w₀, w₁)` is exactly the conjunction required by the §2.2 issuance conditions: `e ∈ Eπ`, `w₀, w₁ ∈ Wπ`, both `Compatibleπ` facts, and `Evalπ(c, w₀) ≠ Evalπ(c, w₁)`. The new normative sentence requires the resolved checker to construct it exclusively from the committed profile, the closed evidence set, the committed claim, and the canonical receipt witnesses. **Confirmed.**
- **No self-selected target.** The certificate MUST NOT supply or select its own target proposition, and the binding requires type equality with the checker-constructed target. **Confirmed.**
- **Wrong proposition → REJECT.** M34 rejects a different, weaker, or certificate-supplied proposition. **Confirmed.**
- **Verifier-time use only.** §4 now reads "verifier-time use", consistent with §3 and §6. The downstream-action non-claim and the Wadkins DET-2 distinction in §5 and §7.3 are unchanged. **Confirmed.**
- **Krausz.** The draft states it was published on 22 September 2026, and it requires resolving an immutable mapping, verifying its SHA-256 against the receipt before use, and halting on mismatch. The new text matches the source inspected in the full gate. The added "narrower remainder" sentence is accurate and narrows, rather than expands, the distinction. **Confirmed.**
- **M31.** Now tied to the mandatory limitation bytes and `limitations_digest` (absent, altered, or mismatched → REJECT). Mechanically checkable. **Confirmed.**
- **M35.** `receipt.verifier_digest ≠ profile.verifier_manifest_digest` → REJECT. **Confirmed.**
- **README.** The distinction is scoped to sources inspected for this release. **Confirmed.**
- **CITATION.** `date-released` has been removed; the file no longer asserts a release. **Confirmed.**
- **Regression.** No new soundness hole. No mandatory limitation is weakened. The prior-art boundary answer is unchanged ("No"). PIVOT is not triggered. **Confirmed.**

## 4. Blockers

None.

## 5. Non-blocking notes

- **"certificate.type =".** In Lean terms this should be read as a kernel check that the submitted proof term has the checker-elaborated target type, up to definitional equality. It should not be read as comparing a type declared by the certificate. The accompanying MUST / MUST NOT sentence already implies this reading. A one-line clarification in the Lean kernel specification (post-release) would remove any implementer ambiguity. This does not require changing this artifact.
- **Archive both reports.** Keep the full-gate report (`98c7d947…8480`, bound to `1679…3370`) alongside this report. That full report is the substantive basis for tasks A–F.

## 6. Prior-art boundary answer

**No. Unchanged** from the full v0.1.1 gate. The patch narrows the Krausz differentiation and adds no new novelty claim.

## 7. Verdict

**PASS** — bound exclusively to `P10_Underdetermination_Profile_v0.1.1.md`, SHA-256 `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`.

This is an independent technical gate result only. It is not ratification, release authorization, tag authorization, or approval to change repository visibility. Those remain Ivan Nestorov's decisions.
