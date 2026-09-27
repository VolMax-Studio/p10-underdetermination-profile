---
# Document source under transcription. Every section below names its v0.1.1 source.
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

# Introduction {#introduction}

> The proposed P10 Underdetermination Profile defines a third-party-verifiable binding for `NotDemonstrated(reason=underdetermined)`. Issuance is permitted only when:
> (1) the world class, admissible-evidence-bundle space and item-admission rules, frozen bundle constructor, compatibility relation, claim interpretation, evidence scope and coverage rules, canonicalization, world codec, committed log identity, leaf encoding, lifecycle/admitter authorization, and verifier were committed in a profile and an identified `InstanceCommitment` before the first evidence admission for that instance;
> (2) within the committed transparency log `L`, exactly one profile and claim are bound to the `(issuer_id, request_id)` subject, and an `EvidenceClosure` plus checkpoint-bounded `CoverageProof` binds every valid, registered, in-scope admission made by a frozen authorized admitter through `S_R`;
> (3) the receipt carries two semantically distinct worlds from that frozen world class, represented in the profile's frozen canonical serialization;
> (4) the frozen verifier establishes that both witnesses are compatible with that same closed evidence set and assign different values to the same frozen claim; and
> (5) the instance commitment, profile, claim, closed evidence set, witnesses, proof, verifier and mandatory limitations are SHA-256-bound in a SCITT Transparent Statement whose payload is an in-toto Statement v1 containing the P10 predicate, with complete VDS-prefix replay and registration/coverage verification satisfying {{full-prefix-replay}} through {{evidence-closure-and-checkpoint-bounded-coverage}}.
> The result establishes underdetermination only relative to the declared profile and does not identify the actual world or establish either claim value as true.

**Nature of the contribution:** profile-and-binding contribution. It is not a new mathematical theorem.

## Scope and Relationship to SCITT {#scope-and-relationship-to-scitt}

The profile defines a third-party-verifiable underdetermination binding for SCITT ({{RFC9943}}) using an in-toto Statement v1 ({{IN-TOTO-STATEMENT}}) predicate; the envelope structure is specified in {{statement-and-predicate-structure}}.

## Non-Claims {#non-claims}

- That “two compatible models ⇒ underdetermination” is novel.
- That the receipt identifies the actual world or establishes either claim value as true.
- That `Compatibleπ`, `Evalπ`, or `Eπ` faithfully represents reality ({{security-considerations}}).
- That `FormallyUnderdeterminationCapable` means the profile is operationally adequate or unbiased toward abstention (AP1).
- That registration order represents issuance, creation, or first-observation order ({{full-prefix-replay}}, {{evidence-admission}}).
- That the issuer did not open a semantically equivalent request under another `request_id` ({{instance-commitment-and-subject}}).
- That the issuer did not create sibling instances for the same `claim_digest` under different `request_id` values, bind them to different profiles or world classes, or select the presented instance after observing evidence or outcomes ({{security-considerations}}).
- That no parallel commitment or admission for the same `request_id` exists in another transparency log; the claim is relative only to committed L ({{instance-commitment-and-subject}} through {{evidence-closure-and-checkpoint-bounded-coverage}}).
- That no unregistered or evidence-scope-excluded external evidence exists, or that no entry exists after `S_R`; coverage applies only to frozen admitters and the identified subject through `S_R` ({{evidence-closure-and-checkpoint-bounded-coverage}}).
- That profile failure says anything about claim falsifiability ({{issuance-conditions}}).
- That P10 is first to use Lean certificates, abstention, or a per-call card ({{KOOMULLIL}}, {{relationship-to-prior-work}}).
- That P10 originated independent determinability or the rule against selecting one of several evidence-compatible candidates ({{WADKINS-00}}, {{relationship-to-prior-work}}).
- That decision-time or pre-evidence binding is novel as a general idea ({{WADKINS-00}}, {{CLAIMRECEIPT}}, {{relationship-to-prior-work}}).
- That an `indeterminate` receipt or reason-coded indeterminate state is novel ({{KRAUSZ-02}}, {{relationship-to-prior-work}}).
- That binding a claim, ruleset, or evidence set into a signed receipt is novel ({{KRAUSZ-02}}, {{relationship-to-prior-work}}).
- That content-addressed evidence or local receipt recomputation is novel ({{KRAUSZ-02}}, {{relationship-to-prior-work}}).
- That SCITT transport for a verification receipt is novel ({{KRAUSZ-02}} and existing SCITT profiles, {{relationship-to-prior-work}}).
- That the general need for evidence-coverage or omission controls is novel ({{WADKINS-00}}, {{CLAIMRECEIPT}}, and {{KRAUSZ-02}}, {{relationship-to-prior-work}}).
- That any downstream action was governed by the receipt's verdict. P10 establishes only that the certificate verifies under the uniquely committed profile and its transitively bound verifier artifacts.
- Anything about market or commercial priority.

# Conventions and Terminology {#conventions-and-terminology}

{::boilerplate bcp14-tagged}

The following notation and symbols are defined in the referenced sections:

* `Wπ`, `Compatibleπ`, and `Evalπ` are defined in {{definitions}}.
* `Eπ` and `VerifierManifestV0` are defined in {{issuance-conditions}}.
* `InstanceCommitment` is defined in {{instance-commitment-and-subject}}.
* `L` and `S_R` are defined in {{full-prefix-replay}}.
* `SubjectView`, `RelevantAdmissionπ`, `EvidenceClosure`, and `CoverageProof` are defined in {{evidence-closure-and-checkpoint-bounded-coverage}}.

# Formal Core {#formal-core}
<!-- SOURCE: §2 heading -->

## Definitions {#definitions}

~~~ text
NonemptyCompatibleπ(e) :=
  ∃ w ∈ Wπ, Compatibleπ(e, w)

Determinateπ(e, c) :=
  NonemptyCompatibleπ(e) ∧
  ∀ w₀ w₁ ∈ Wπ,
    Compatibleπ(e, w₀) ∧ Compatibleπ(e, w₁)
    → Evalπ(c, w₀) = Evalπ(c, w₁)

Underdeterminedπ(e, c) :=
  ∃ w₀ w₁ ∈ Wπ,
    Compatibleπ(e, w₀) ∧ Compatibleπ(e, w₁) ∧
    Evalπ(c, w₀) ≠ Evalπ(c, w₁)

ProfileAdmissible(π, c) :=
  ∃ eᵈ ∈ Eπ, Determinateπ(eᵈ, c)

FormallyUnderdeterminationCapable(π, c) :=
  ∃ eᵘ eᵈ ∈ Eπ,
    Underdeterminedπ(eᵘ, c) ∧ Determinateπ(eᵈ, c)
~~~

Notes:

* `Evalπ(c, w₀) ≠ Evalπ(c, w₁)` entails the semantic distinctness of w₀ and w₁. Canonical serialization ({{canonical-encoding}}) prevents the same world from appearing twice.
* `FormallyUnderdeterminationCapable(π, c) → ProfileAdmissible(π, c)`. Both tests remain in preflight for clearer diagnostics.
* `FormallyUnderdeterminationCapable` is a formal property of the frozen profile. It says nothing about operational adequacy ({{security-considerations}}, AP1).

## Issuance Conditions
<!-- SOURCE: §2.2 incl. VerifierManifestV0, CertificateTargetV0, ActiveProfileBindingV0,
     preflight rule. Traceability: N01–N03, L01. -->

# Instance Commitment and Subject
<!-- SOURCE: §2.3. Traceability: N04–N07. -->

# Full-Prefix Replay and Registration Order {#full-prefix-replay}
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
