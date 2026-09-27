# P10 v0.1.1 Source Snapshot

**Inspection dates:** 2026-09-23 and 2026-09-27
**Snapshot date:** 2026-09-27
**Scope:** sources and verification boundaries supporting the P10 Underdetermination Profile v0.1.1 publication candidate.

## Publication artifact

- File: `P10_Underdetermination_Profile_v0.1.1.md`
- SHA-256: `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`.

## Directly inspected sources

- RFC 9943, including Sections 3, 5.1.3, 6, 7, 9.1, and 9.3.
- RFC 2119 and RFC 8174, BCP 14 requirement-level terminology.
- RFC 9162 and the `RFC9162_SHA256` Merkle-tree construction referenced by the selected VDS profile.
- RFC 8785, JSON Canonicalization Scheme.
- in-toto Attestation Framework v1 README and `statement.md`.
- Koomullil, arXiv `2605.16407v1`, complete HTML.
- `gkoomullil/proof-carrying-certificates` at commit `8e5b718c4fc1a53678f1da9a94499df3b311d065`, including:
  - `lean_artifact/EmbeddingSensitivity/MCR.lean`, blob `096f15d486f7190d7018317002a3ba2d137eadab`;
  - `lean_artifact/EmbeddingSensitivity/AxiomAudit.lean`, blob `83899399f1157d99f06bcc611466186bf26d77b9`.
- Pramāṇa, arXiv `2605.20312v1`, complete HTML.
- ClaimReceipt, arXiv `2609.01992v1`, complete HTML.
- Douglas Wadkins, *Independent Determinability of Agent Actions*, `draft-wadkins-agentproto-action-determinability-00`, complete Datatracker HTML, dated 2026-09-10 and last updated 2026-09-11; inspected 2026-09-27: <https://datatracker.ietf.org/doc/draft-wadkins-agentproto-action-determinability/>.
- IETF Datatracker IPR disclosure 7599, submitted 2026-09-11 and related to `draft-wadkins-agentproto-action-determinability-00`: <https://datatracker.ietf.org/ipr/7599/>.
- T. Krausz, “The `verification.*` Constraint Family: Pre-Action Fail-Closed Gates for AI Agent Decisions,” `draft-krausz-verification-state-02`, complete Datatracker HTML, published 2026-09-22; inspected 2026-09-27: <https://datatracker.ietf.org/doc/html/draft-krausz-verification-state-02>.
- SCITT Agent Action Capsule, `draft-mih-scitt-agent-action-capsule-02`.
- IETF Datatracker important dates for IETF 127.

## Observed boundaries

- SCITT receipts establish registration in a transparency service; semantic verification of the P10 predicate remains a separate verifier responsibility.
- RFC 9943 registration order is not evidence-creation or issuance order, and selective registration is possible.
- Complete-prefix replay can establish checkpoint-bounded completeness only for an actor with access to the required VDS content and subject payloads.
- ClaimReceipt covers prospective ingress commitment, terminal reconciliation, and execution-level sufficiency, but does not define the P10 combination of a frozen executable world model and a concrete divergent witness pair carried by the receipt.
- Pramāṇa provides typed attestations and an `UNVERIFIABLE` outcome, but does not require the P10 pre-evidence world-class commitment or divergent witness pair.
- The inspected `MCR.lean` file contains neither a paper-level maximality theorem nor an evidence anti-monotonicity theorem. Paper-level claims are not attributed to the inspected Lean artifact.
- `draft-wadkins-agentproto-action-determinability-00` already states that selecting one of several governing-condition sets or policy revisions compatible with the evidence is not determination, requires actual decision-time governance rather than prior signing or registration alone, and requires omission detection or an explicit inability-to-establish-completeness result when completeness is material. Its candidates are not possible worlds assigning different values to an evidential claim. It defines no evidence format, registry, or transparency service.
- The draft is an individual Informational Internet-Draft with no formal IETF standing and records that its requirements were sharpened through discussion on the `agentproto` mailing list. Datatracker lists one IPR disclosure, ID 7599: the submitter identifies unpublished pending U.S. provisional application `US64/147765` and made no licensing declaration at the time of disclosure. This snapshot records the disclosure without drawing a legal conclusion.
- `draft-krausz-verification-state-02` already defines signed claim/ruleset/evidence-bound receipts, an `indeterminate` state, content-addressed evidence, local recomputation, immutable content-addressed mapping resolution with digest verification before use and fail-closed mismatch handling, and SCITT-compatible transport. It explicitly states that the receipt cannot prove completeness of disclosure or detect an omitted source.
- Neither draft requires the P10 combination of a pre-evidence committed `Wπ`, executable `Compatibleπ` and `Evalπ`, a concrete pair of compatible worlds with different claim values, a Lean-checked witness proof, a uniquely resolved instance-specific profile and transitively bound verifier manifest, checkpoint-complete evidence coverage, and transparency-log registration-order verification.

## Not independently executed

- Koomullil `lake build`.
- Pilot experiments.
- The ClaimReceipt reference verifier.
- A complete P10 reference implementation, which is not part of this publication candidate.

Build and test statements for unexecuted artifacts remain primary-source self-reports. This snapshot establishes only the content and boundaries of the cited sources at the stated versions.
