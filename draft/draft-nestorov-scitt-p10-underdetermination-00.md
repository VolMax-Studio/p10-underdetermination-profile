---
# SKELETON — no body text yet. Every section below names its v0.1.1 source.
# Source of record: P10_Underdetermination_Profile_v0.1.1.md
#   SHA-256 b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558
#   tag v0.1.1 -> commit e2a02a73df9e50f624512043dcb007fc337ba587
#   Zenodo version DOI 10.5281/zenodo.22994744
# Draft decisions are ratified and recorded in DRAFT_BRIEF.md.

title: "P10 Underdetermination Profile: Witness-Carrying Underdetermination Receipts for SCITT"
abbrev: "P10 Underdetermination Profile"
docname: draft-nestorov-scitt-p10-underdetermination-00
category: info
submissiontype: IETF
ipr: trust200902
area: Security
keyword:
  - SCITT
  - in-toto
  - underdetermination
  - receipt
  - Lean
venue:
  mail: scitt@ietf.org
  github: VolMax-Studio/p10-underdetermination-profile

author:
  - fullname: Ivan Nestorov
    organization: VolMax Studio Lab d.o.o.
    email: volmax.core@gmail.com
    uri: https://orcid.org/0009-0006-7940-9539

normative:
  RFC2119:
  RFC8174:
  RFC9943:   # SCITT architecture
  RFC9942:   # COSE Receipts; registers COSE header parameter 394 "receipts" (R1 closed)
  RFC9052:   # COSE_Sign1
  RFC8392:   # CWT claims iss/sub (R2: added reference, not cited by name in v0.1.1)
  RFC9597:   # CWT Claims in COSE headers (protected-header carriage of iss/sub; required with RFC 8392 by RFC 9943)
  RFC8785:   # JCS
  RFC9162:   # RFC9162_SHA256 VDS
  IN-TOTO-STATEMENT:
    title: "in-toto Attestation Framework: Statement layer specification, v1"
    author:
      - org: in-toto Project
    date: 2024-05-06
    seriesinfo:
      Commit: 06eafe3635bf8a425ad52cc82c6c90861e94a471
    # Exact content URL for spec/v1/statement.md at the reviewed commit.
    target: https://raw.githubusercontent.com/in-toto/attestation/06eafe3635bf8a425ad52cc82c6c90861e94a471/spec/v1/statement.md

informative:
  P10-V011:
    title: "P10 Underdetermination Profile, version 0.1.1"
    author:
      - ins: I. Nestorov
        name: Ivan Nestorov
        org: VolMax Studio Lab d.o.o.
    seriesinfo:
      DOI: 10.5281/zenodo.22994744
    date: 2026-09-27
  # Internet-Drafts are FROZEN manual references to the exact versions inspected for v0.1.1.
  # Do NOT use I-D.<name> auto-references: they resolve to the latest revision at build time.
  WADKINS-00:
    title: "Independent Determinability of Agent Actions"
    author:
      - ins: D. Wadkins
        name: Douglas Wadkins
        org: Strakewright
    date: 2026-09-10
    seriesinfo:
      Internet-Draft: draft-wadkins-agentproto-action-determinability-00
    target: https://www.ietf.org/archive/id/draft-wadkins-agentproto-action-determinability-00.txt
  KRAUSZ-02:
    title: "The verification.* Constraint Family: Pre-Action Fail-Closed Gates for AI Agent Decisions"
    author:
      - ins: J. Krausz
        name: Joe Krausz
        org: TK Collective LLC
    date: 2026-09-22
    seriesinfo:
      Internet-Draft: draft-krausz-verification-state-02
    target: https://www.ietf.org/archive/id/draft-krausz-verification-state-02.txt
  MIH-AAC-02:
    title: "An Agent Action Capsule Profile for SCITT"
    author:
      - ins: S. Mih
        name: Steven Mih
        org: Action State Group, Inc.
    date: 2026-07-06
    seriesinfo:
      Internet-Draft: draft-mih-scitt-agent-action-capsule-02
    target: https://www.ietf.org/archive/id/draft-mih-scitt-agent-action-capsule-02.txt
    # D7: -04 (2026-08-28) exists; not reviewed for v0.1.1 and not attributed.
  PRAMANA:
    title: "Pramana: A Protocol-Layer Treatment of Claim Verification in Autonomous Agent Networks"
    author:
      - ins: R. K. Kadaboina
        name: Ravi Kiran Kadaboina
    date: 2026-05-19
    seriesinfo:
      arXiv: "2605.20312"
  CLAIMRECEIPT:
    title: "ClaimReceipt: Verifying Evidence Sufficiency and Coverage in Agent Evaluations"
    author:
      - ins: P. Zhu
        name: Peiying Zhu
      - ins: S. Chang
        name: Sidi Chang
    date: 2026-09-02
    seriesinfo:
      arXiv: "2609.01992"
    target: https://arxiv.org/abs/2609.01992v1
  KOOMULLIL:
    title: "Proof-Carrying Certificates for LLM Pipelines: A Trust-Boundary Architecture"
    author:
      - ins: G. Koomullil
        name: George Koomullil
    date: 2026-05-13
    seriesinfo:
      arXiv: "2605.16407"
    target: https://arxiv.org/abs/2605.16407v1
  LEAN4:
    title: "The Lean 4 Theorem Prover and Programming Language"
    author:
      - ins: L. de Moura
        name: Leonardo de Moura
      - ins: S. Ullrich
        name: Sebastian Ullrich
    date: 2021
    seriesinfo:
      DOI: "10.1007/978-3-030-79876-5_37"

--- abstract

P10 defines a third-party-verifiable binding for NotDemonstrated(reason=underdetermined). A conforming receipt carries two canonical witness worlds that are compatible with the same closed evidence set and produce different values for the same frozen claim. The witness result is checked against committed profile semantics and bound into a SCITT Transparent Statement containing an in-toto Statement v1 predicate. The result establishes underdetermination only relative to the declared profile and does not identify the actual world or establish either claim value as true.

<!-- SOURCE: README.md §1 paragraph + profile §1 last sentence. Abstract is summary prose:
     no BCP 14 keywords allowed here. -->

--- middle

# Introduction
<!-- SOURCE: §1 Claim of record (verbatim block) + "Nature of the contribution".
     Keep claim of record byte-faithful except Markdown→kramdown syntax. -->

## Scope and Relationship to SCITT
<!-- SOURCE: §4 "The only v0 envelope" paragraph; README "Scope". No new text. -->

## Non-Claims
<!-- SOURCE: §6, all 20 bullets, order preserved. Section refs rewritten to draft refs only. -->

# Conventions and Terminology

{::boilerplate bcp14-tagged}

<!-- SOURCE: §2.1/§2.2/§2.3 symbol names. Terminology list may only name symbols
     already defined in v0.1.1: Wπ, Eπ, Compatibleπ, Evalπ, InstanceCommitment, L, S_R,
     SubjectView, RelevantAdmissionπ, EvidenceClosure, CoverageProof, VerifierManifestV0.
     Definitions stay in their own sections; the list points to them. -->

# Formal Core
<!-- SOURCE: §2 heading -->

## Definitions
<!-- SOURCE: §2.1 code block + Notes. Traceability: no BCP 14 rows. -->

## Issuance Conditions
<!-- SOURCE: §2.2 incl. VerifierManifestV0, CertificateTargetV0, ActiveProfileBindingV0,
     preflight rule. Traceability: N01–N03, L01. -->

# Instance Commitment and Subject
<!-- SOURCE: §2.3. Traceability: N04–N07. -->

# Full-Prefix Replay and Registration Order
<!-- SOURCE: §2.4. Traceability: N08–N10, L02, L03. -->

# Evidence Admission
<!-- SOURCE: §2.5. -->

# Evidence Closure and Checkpoint-Bounded Coverage
<!-- SOURCE: §2.6. Traceability: N11, L04. -->

# Canonical Encoding
<!-- SOURCE: §2.7. -->

# Statement and Predicate Structure
<!-- SOURCE: §4 (issuer-signed fields, post-registration output, ActiveProfileBindingV0
     paragraph, envelope). Traceability: N14, L08–L11. -->

# Security Considerations
<!-- SOURCE: §3 table, AP1 limitation (verbatim, mandatory), coverage/instance limitation
     (verbatim, mandatory), sibling-count SHOULD, must-understand rule.
     Traceability: N12, N13, L05–L07.
     The two limitation blocks are receipt content bound by limitations_digest:
     copy byte-for-byte, including backticks. -->

# Privacy Considerations
<!-- D4 ratified: short informative section, NEW-PROSE, zero BCP 14 keywords.
     Every sentence listed in TRACEABILITY.md Table 5 (NEW-PROSE) for the gate. -->

# IANA Considerations
This document has no IANA actions.

--- back

# Conformance Tests
{:numbered="true"}
<!-- SOURCE: §7 heading. -->

## Mutation Tests
<!-- SOURCE: §7.1 table M1–M35. N15 = §7.1 heading (line 418, "MUST yield REJECT or the
     stated outcome"); keep it as the normative lead-in sentence. N16 = M30 row.
     Table 3 in matrix; L14–L16. -->

## Adversarial-Profile Test
<!-- SOURCE: §7.2 AP1 row + profile-adequacy review paragraph. -->

# Relationship to Prior Work
{:numbered="false"}
<!-- SOURCE: §5 table + provenance paragraph + narrow differentiation; §7.3 boundary question.
     Descriptions of others' work copied as in v0.1.1; do not re-paraphrase (gate Check 4).
     Traceability: L12, L13. Cite frozen anchors WADKINS-00, KRAUSZ-02, MIH-AAC-02 only. -->

# Source Snapshot
{:numbered="false"}
<!-- SOURCE: §8. Includes IPR disclosure 7599 note on the Wadkins draft, as stated. -->

# Document History
{:numbered="false"}
<!-- SOURCE: §10 v0.1.1 entry, plus one line: "-00: transcription of v0.1.1
     (DOI 10.5281/zenodo.22994744) into Internet-Draft format; no semantic change." -->

# Acknowledgments
{:numbered="false"}
<!-- D8 ratified: brief thanks to human reviewers and AI-assisted tooling; no AI named
     as author. NEW-PROSE. -->
