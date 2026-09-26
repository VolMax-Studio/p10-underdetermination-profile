# P10 v0.1.0 Source Snapshot

**Inspection date:** 2026-09-23  
**Snapshot date:** 2026-09-26  
**Scope:** sources and verification boundaries supporting the P10 Underdetermination Profile v0.1.0 publication candidate.

## Publication artifact

- File: `P10_Underdetermination_Profile_v0.1.0.md`
- SHA-256: `415b976580fc58b0557ae3705aac219e2dd722fb474d6e6bb80d83953d9909b8`

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
- SCITT Agent Action Capsule, `draft-mih-scitt-agent-action-capsule-02`.
- IETF Datatracker important dates for IETF 127.

## Observed boundaries

- SCITT receipts establish registration in a transparency service; semantic verification of the P10 predicate remains a separate verifier responsibility.
- RFC 9943 registration order is not evidence-creation or issuance order, and selective registration is possible.
- Complete-prefix replay can establish checkpoint-bounded completeness only for an actor with access to the required VDS content and subject payloads.
- ClaimReceipt covers prospective ingress commitment, terminal reconciliation, and execution-level sufficiency, but does not define the P10 combination of a frozen executable world model and a concrete divergent witness pair carried by the receipt.
- Pramāṇa provides typed attestations and an `UNVERIFIABLE` outcome, but does not require the P10 pre-evidence world-class commitment or divergent witness pair.
- The inspected `MCR.lean` file contains neither a paper-level maximality theorem nor an evidence anti-monotonicity theorem. Paper-level claims are not attributed to the inspected Lean artifact.

## Not independently executed

- Koomullil `lake build`.
- Pilot experiments.
- The ClaimReceipt reference verifier.
- A complete P10 reference implementation, which is not part of this publication candidate.

Build and test statements for unexecuted artifacts remain primary-source self-reports. This snapshot establishes only the content and boundaries of the cited sources at the stated versions.
