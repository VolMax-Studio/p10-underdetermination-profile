# P10 Underdetermination Profile v0.1.1 — Independent Publication Gate Report

**Gatekeeper:** Claude (Anthropic), read-only independent gate. No candidate byte was modified.
**Review date:** 2026-09-27
**Artifact under review:** `P10_Underdetermination_Profile_v0.1.1.md`
**SHA-256:** `1679620659bf4b56f6a688a490210e6840c9ca49be9c4f651339de287ca93370`

## 1. Verified input hashes and diff result

- `sha256sum -c P10_V0_1_1_GATE_SHA256SUMS` returns OK for all five entries. The manifest itself hashes to `a3d5b4ff03cc5622e456932f9ebebaf7b6dce436eb808b3f265c42ba2974e574`; the gate request hashes to `48a0fd9a88c118a3f7039b0873a825f3bdbafc0b842c05f17e3f1e88dd0bbae7`; the ZIP hashes to `0f7a35ff7f8a6c42d01a6782365aff2149ef9d4529e7794a58dc7e89dd30a158`.
- Loose uploaded copies of the profile, diff, source snapshot, and gate manifest are byte-identical to the copies inside the ZIP.
- v0.1.0 input: `415b976580fc58b0557ae3705aac219e2dd722fb474d6e6bb80d83953d9909b8` (confirmed).
- Applying `P10_v0.1.0_to_v0.1.1.diff` (`425f7b6ad60cd577bcc8575a931bcc76e3f453522559fbac76af50c3d94eabf2`) to v0.1.0 yields a file byte-identical to v0.1.1.
- Unchanged-block hashes, computed independently by the stated rules, match in both versions:
  - §2.1 definitions: `885cbc641f5bf673219d36e1ae4161d81aa658451080ceb2e90bd563e0397119`
  - §2.6 evidence closure: `a9f9a9523800371c40f53d739cf7c0a68d5dbbf74b4c7eec87d16af66422d241`
  - M1–M30 rows (30 rows): `766be4bcc01346134b43fdb3638426a7a6518efd1d543904c56cb45cfb86cde5`
  - §7.2 AP1: `18d7f086038aa54f664289742fe3c6d618d89a4ec14cb38f1721ca6ae59082ad`
- Repository `SHA256SUMS` matches the supplied `CITATION.cff`, `LICENSE`, `README.md`, `SOURCE_SNAPSHOT.md`, and the profile.
- **Diff scope.** Every changed line falls within the permitted areas: header/version/date, §2.2, §3, §4, §5, §6, §7.1, §7.3, §8, and the new §10 change log. The only lines attributed to §9 are the `---` separator and blank line preceding §10. No other byte changed.
- **Out of scope:** the v0.1.0 PASS itself, the `development/v0.2.0` Lean branch, and repository/branch state. This gate binds bytes, not branches.

## 2. Findings for tasks A–F

### A. Wadkins — accurate

Opened: `draft-wadkins-agentproto-action-determinability-00` (complete Datatracker text) and IPR disclosure 7599.

- Candidates in DET-2 are governing-condition sets and policy revisions, not possible worlds assigning different values to an evidential claim. Accurate.
- DET-2 requires the governing conditions to have actually governed the transition at decision time; the draft lists prior signing or registration, and availability among several candidate condition sets, as insufficient by themselves. Accurate.
- The abstract states that the draft defines no evidence format, token, action identifier, delegation protocol, audit system, registry, or transparency service. Accurate.
- Individual Internet-Draft, intended status Informational, no formal IETF standing; the acknowledgments state the requirements were sharpened on the agentproto list. Accurate. Dated 10 September 2026; Datatracker last updated 2026-09-11. Accurate.
- DET-4's omission rule (detect omission, or return an explicit result that completeness cannot be established) is correctly described.
- IPR 7599: submitted 2026-09-11 by the author; names U.S. Provisional Application 64/147,765, pending and unpublished; the holder makes no licensing declaration at this time under RFC 8179 §5.5(B). The profile reports this factually and draws no legal conclusion. Accurate. (The disclosure also covers the author's agentproto mailing-list contributions; mentioning this is optional.)

### B. Krausz — accurate, one date to verify

Opened: `draft-krausz-verification-state-02` (complete Datatracker HTML).

- JWS-signed receipt binding claim (`v_claim`), ruleset (`v_gate_mapping` + mandatory `v_gate_mapping_hash`), and an optional content-addressed `evidence_set`. Accurate.
- Four states `verified` / `contradicted` / `indeterminate` / `not_evaluated`, with reason codes. Accurate.
- Local recomputation under a hash-bound mapping, fail-closed on any mismatch. Accurate.
- SCITT-compatible transport (§9.1). Accurate.
- §5.3.4 states that an evidence set cannot establish completeness of disclosure and that nothing in the receipt can detect an omission. Accurate.
- **Date:** the draft text states "Published: 22 September 2026". The profile (§8) and `SOURCE_SNAPSHOT.md` state 2026-09-23. See non-blocking correction N3.

### C. Active profile and verifier binding — no substitution gap in the stated chain

`ActiveProfileBindingV0` requires every element listed in the gate request:

- exactly one valid `InstanceCommitment` for the committed tuple, via `FullPrefixReplay`;
- profile bytes resolved from `R.profile_commitment_ref` whose digest equals `InstanceCommitment.profile_digest`;
- transitive binding: `profile_digest` covers `verifier_manifest_ref` and `verifier_manifest_digest`; the resolved manifest must hash to that digest; the manifest binds toolchain identifier and artifact, checker source tree, dependency lock, build manifest, `.olean` set, axiom policy, and acceptance command;
- `R.verifier_digest = profile.verifier_manifest_digest`;
- exclusive use of the resolved profile's `Wπ`, `Eπ`, `Compatibleπ`, `Evalπ`, codecs, and checker;
- certificate type-checking under exactly that combination.

Outcome split is correct: missing artifact → `HALT`, no epistemic verdict; mismatch, substitution, or any other profile/checker/build/axiom policy/toolchain → `REJECT`. §4 states that registration order is not by itself evidence of use; §3 and §6 limit P10's claim to verifier-time recomputation and expressly disclaim downstream-action governance in the DET-2 sense.

Two precision points (non-blocking, N1 and N2): the binding does not say which proposition the certificate must type-check against, and §4 uses the unqualified word "use".

### D. Cross-instance selection boundary — correct

- The mandatory limitation now states that uniqueness holds only for the identified instance tuple within committed `L` through `S_R`, and that P10 does not exclude sibling instances for the same `claim_digest` under other `request_id` values, binding them to different profiles or world classes, or selecting among them after observing evidence or outcomes.
- Sibling counting is a `SHOULD` report, conditioned on payload accessibility, with no acceptance or rejection semantics in v0.1.1, and the text expressly does not expand the `FullPrefixReplay` payload-availability rule.
- Context: this is precisely the selection attack described in Wadkins §7 and DET-2. P10 discloses that it does not prevent it across instances. The disclosure is necessary and correctly placed in the mandatory limitation, §6, and M31.

### E. Novelty contraction — correct

§5 ("Narrow differentiation"), §6, §7.3, and README claim no novelty for independent determinability, decision-time or pre-evidence binding as a general idea, `indeterminate` receipts, claim/ruleset/evidence binding, content-addressed evidence, local recomputation, SCITT transport, or the general need for coverage or omission controls.

Neither reviewed draft requires the remaining P10 combination (answer in section 5 below). Individual components are anticipated, and the profile concedes them. The closest single analog is Krausz's resolve-and-digest-check of an immutable, content-addressed mapping before use with fail-closed halt, which anticipates the *mechanism* of the profile-resolution step in `ActiveProfileBindingV0` (see N4).

### F. Regression and mutation checks — pass

- The four custody hashes establish that §2.1 definitions, §2.6 evidence closure, M1–M30, and AP1 are unchanged.
- M31 rejects omission of the cross-instance limitation; M32 rejects profile substitution even when the substitute was registered before evidence admission; M33 rejects checker/`.olean`/dependency/toolchain/axiom-policy/acceptance-command/build-manifest substitution and halts on an unavailable artifact.

## 3. Blockers

None.

## 4. Non-blocking corrections

- **N1 — Statement binding for the certificate.** `ActiveProfileBindingV0` says the certificate "type-checks under exactly those resolved … artifacts" but not *against which proposition*. A certificate proving an unrelated proposition would type-check under the correct toolchain. Claim (4) and the §2.2 issuance conditions already require the verifier to establish the specific compatibility and divergence facts, so this is not a soundness gap in the profile; it is a missing explicit clause. Suggested: the target proposition is constructed by the resolved checker from the committed profile, the closed `e`, the committed `c`, and the receipt's canonical `w₀`, `w₁`, and is never supplied by the certificate; add a mutation test "certificate proves a different or weaker statement → REJECT". This gap predates v0.1.1.
- **N2 — "P10 establishes use" (§4).** Wadkins's acknowledgments record precisely that recomputation is separable from actual decision-time use. Replace with "P10 establishes verifier-time use" so §4 matches §3 and §6 word for word.
- **N3 — Krausz date.** The draft states "Published: 22 September 2026"; §8 and `SOURCE_SNAPSHOT.md` say 2026-09-23. Use the draft's date, or state that 2026-09-23 is the Datatracker posting date if that was verified.
- **N4 — Krausz row precision.** Add that Krausz already resolves an immutable, content-addressed mapping and verifies its digest before use, fail-closed. This makes explicit that P10's residual in this area is instance-unique resolution plus transitive toolchain/build binding, not digest-checked ruleset resolution as such.
- **N5 — M31 testability.** "Represents instance-tuple uniqueness as uniqueness across sibling instances" is a semantic judgment, not a mechanical check. Phrase M31 as a verbatim-limitation mismatch against `limitations_digest`.
- **N6 — Mutation for `verifier_digest`.** Add an explicit test "receipt `verifier_digest` ≠ `profile.verifier_manifest_digest` → REJECT"; today it is covered only by the binding text.
- **N7 — Sweep coverage.** The inspected drafts cite adjacent work not covered by this sweep, notably `draft-sirkkavaara-vaara-receipt-11` (a recomputable receipt format for decisions about autonomous actions), plus `draft-lee-orprg-permit-receipts`, `draft-abak-agent-control-delivery-evidence`, `draft-sokolov-rats-aep-composition`, and `draft-mih-sato-agent-accountability-composition`. The profile's conclusion is correctly scoped to inspected sources, but README's "claimed distinction" sentence is unscoped. Either scope README the same way, or sweep these before the I-D.
- **N8 — `CITATION.cff`.** `date-released: 2026-09-27` asserts a release that has not been authorized. Set it at actual release. Consider adding the author's ORCID.

## 5. Prior-art boundary answer

**No.** Neither `draft-wadkins-agentproto-action-determinability-00` nor `draft-krausz-verification-state-02` requires a pre-evidence committed model class with executable compatibility and evaluation semantics, nor carries a concrete divergent-world witness pair checked against the same closed evidence set.

- Wadkins's compatible candidates are governing-condition sets; it deliberately defines no evidence format or transparency service and specifies no witness pair or proof checking.
- Krausz binds claim, ruleset, and evidence and has an `indeterminate` state, but defines no world class, carries no witness pair, involves no Lean checking, and expressly cannot detect omitted evidence.

This answer is limited to the profile-and-binding combination stated in §5 and to the sources inspected in this gate. It is not a finding of broad novelty.

Combined with the prior answers for Pramāṇa and ClaimReceipt (unchanged; not reopened in this round), PIVOT is not triggered.

## 6. Verdict

**PASS** — bound exclusively to `P10_Underdetermination_Profile_v0.1.1.md`, SHA-256 `1679620659bf4b56f6a688a490210e6840c9ca49be9c4f651339de287ca93370`.

PASS means the artifact survived this publication gate. It is not ratification, release authorization, or approval to change repository visibility. Those remain Ivan Nestorov's decisions. Any change to the profile bytes, including N1–N8, produces a new hash that requires a new gate.
