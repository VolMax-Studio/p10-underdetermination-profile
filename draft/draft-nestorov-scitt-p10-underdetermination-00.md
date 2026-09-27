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

## Issuance Conditions {#issuance-conditions}

In the formal core, `e` denotes a canonically closed evidence bundle. An individual admission object is denoted by `a`; the frozen `Bundleπ` function derives `e` from ordered valid admissions, and the closure proof establishes `e ∈ Eπ`.

~~~ text
InstanceCommittedBeforeEvidence(ι, π, c)
ProfileRegisteredBeforeEvidence(π, ι)
  -- via replay transcript
ActiveProfileBindingV0(ι, R)
  -- exact profile/verifier resolution below
CoverageClosedThroughCheckpoint(ι, e, S_R)
FormallyUnderdeterminationCapable(π, c)
  -- preflight
e ∈ Eπ
w₀, w₁ ∈ Wπ  (canonical form)
Compatibleπ(e, w₀)
Compatibleπ(e, w₁)
Evalπ(c, w₀) ≠ Evalπ(c, w₁)
~~~

The prerequisites in this summary are detailed in {{instance-commitment-and-subject}} for instance commitment, {{full-prefix-replay}} for profile registration and replay, {{evidence-closure-and-checkpoint-bounded-coverage}} for coverage closure, and {{canonical-encoding}} for canonical world encoding.

**Frozen and digested before evidence admission:**

* `Wπ`, `Compatibleπ`, `Evalπ`, and claim semantics
* `Eπ` (the space of permitted closed evidence bundles), `AdmissibleItemπ`, `Bundleπ`, and admission rules
* evidence scope, coverage rules, and the rule for forming the closed evidence set
* `LogIdentityV0`, `LeafEncodeV0`, checkpoint key/VDS algorithm, and lifecycle/admitter authorization
* evidence canonicalization and the canonical world codec ({{canonical-encoding}})
* `eᵈ` and `eᵘ`, with membership proofs for `Eπ` and proofs of `Determinateπ(eᵈ, c)` and `Underdeterminedπ(eᵘ, c)`
* `VerifierManifestV0` and its digest, including the exact checker and Lean toolchain artifacts defined below

~~~ text
VerifierManifestV0 binds:
  lean_toolchain_identifier
  lean_toolchain_artifact_digest
  checker_source_tree_digest
  dependency_lock_digest
  build_manifest_digest
  checker_olean_digest_set
  axiom_policy_digest
  acceptance_command_digest

profile.verifier_manifest_ref resolves VerifierManifestV0
profile.verifier_manifest_digest :=
  digest(canonical VerifierManifestV0)

profile_digest binds profile.verifier_manifest_ref and
  profile.verifier_manifest_digest

CertificateTargetV0(π, e, c, w₀, w₁) :=
  e ∈ Eπ                                      ∧
  w₀ ∈ Wπ                                     ∧
  w₁ ∈ Wπ                                     ∧
  Compatibleπ(e, w₀)                          ∧
  Compatibleπ(e, w₁)                          ∧
  Evalπ(c, w₀) ≠ Evalπ(c, w₁)

ActiveProfileBindingV0(ι, R) holds only if:
  FullPrefixReplay finds exactly one valid InstanceCommitment for the
    committed instance tuple                                      ∧
  digest(
    resolve(R.profile_commitment_ref)
      .canonical_profile_bytes)
    = InstanceCommitment.profile_digest                           ∧
  digest(
    resolve(profile.verifier_manifest_ref)
      .canonical_manifest_bytes)
    = profile.verifier_manifest_digest                            ∧
  R.verifier_digest = profile.verifier_manifest_digest            ∧
  R.claim_digest = InstanceCommitment.claim_digest                ∧
  every checker source, dependency lock, build manifest, `.olean`
    artifact, axiom policy, acceptance command, and Lean toolchain
    artifact used during verification matches VerifierManifestV0 ∧
  Wπ, Eπ, Compatibleπ, Evalπ, the codecs, and the checker are
    obtained exclusively from that resolved profile               ∧
  certificate.type = CertificateTargetV0(π, e, c, w₀, w₁)         ∧
  the submitted certificate type-checks under exactly those
    resolved profile, verifier, and toolchain artifacts.
~~~

The resolved checker MUST construct `CertificateTargetV0` exclusively from the committed profile, closed evidence set, committed claim, and canonical receipt witnesses. The certificate MUST NOT supply or select its own target proposition.

Every artifact digest above binds both the exact bytes and its frozen artifact identifier or path and format. An unavailable required profile, manifest, checker, build, dependency, `.olean`, axiom-policy, acceptance-command, or toolchain artifact yields `HALT`, with no epistemic verdict. A digest mismatch, substitution, or certificate checked under any other profile, checker, build, axiom policy, or toolchain yields `REJECT`.

**Preflight rule:**

~~~ text
¬ProfileAdmissible(π, c) →
  preflight HALT, no verdict
¬FormallyUnderdeterminationCapable(π, c) →
  profile MUST NOT issue an underdetermination receipt
~~~

For infinite `Wπ`, `Underdeterminedπ` is still checked with a concrete witness pair and decidable `Compatibleπ` and `Evalπ`. `Determinateπ(eᵈ, c)` is a universal claim: the verifier accepts a Lean proof term, but generation of such a proof is not guaranteed. If no proof term is available, preflight MUST return `HALT`, not an epistemic verdict.

`UnfalsifiableAsStated` is not derived from profile failure. It requires a separate semantic obligation over the claim wording, relativized to the declared world class and evidence language. That obligation is outside this profile.

# Instance Commitment and Subject {#instance-commitment-and-subject}
<!-- SOURCE: §2.3. Traceability: N04–N07. -->

The identified adjudication instance is a subject derived from the issuer/request pair, not a freely chosen `instance_id`:

~~~ text
instance_subject := SubjectDeriveV0(issuer_id, request_id)
~~~

`SubjectDeriveV0` uses frozen, domain-separated canonical encoding and returns a text string (`tstr`) for the CWT `sub` claim ({{RFC8392}}). Its digest is bound by the commitment. Before the first evidence admission, the following MUST be registered:

~~~ text
InstanceCommitment(ι) binds:
  request_id
  issuer_id
  instance_subject
  instance_owner_iss
  log_identity_digest
  leaf_encoding_profile_digest
  claim_digest
  profile_digest
  evidence_scope_digest
  admission_rule_digest
  coverage_rule_digest
  authorized_admitter_set_digest
  subject_derivation_digest
~~~

- `instance_owner_iss = issuer_id` in the same frozen canonical representation, and the commitment MUST carry a valid owner signature with that protected `iss`.
- Uniqueness is checked **within committed L** by `(instance_owner_iss, request_id, instance_subject)`, where `instance_subject` MUST be the result of `SubjectDeriveV0(issuer_id, request_id)`.
- Full replay MUST find exactly one valid `InstanceCommitment` for that tuple, containing exactly one `profile_digest` and `claim_digest`. Zero commitments yields `HALT`; two or more, or conflicting digests, yield `REJECT`.
- `authorized_admitter_set_digest` binds the exact frozen set of permitted CWT `iss` values.
- All lifecycle statements — profile, commitment, admission, closure, and final P10 adjudication Signed Statement — carry the same **protected CWT `sub`** ({{RFC9597}}), equal to `instance_subject`.
- The profile-selection commitment, `InstanceCommitment`, `EvidenceClosure`, and final P10 Signed Statement are valid only with an `instance_owner_iss` signature. Evidence admissions use the separate frozen admitter set. A matching-`sub` lifecycle entry from another `iss` is not valid and is excluded from counts.
- A semantically equivalent natural-language request opened under another `request_id` remains outside the proven completeness scope.

# Full-Prefix Replay and Registration Order {#full-prefix-replay}
<!-- SOURCE: §2.4. Traceability: N08–N10, L02, L03. -->

**Registration order** and checkpoint-bounded coverage are proven by replaying the append-only log, not by timestamps or selected inclusion proofs alone.

~~~ text
LogIdentityV0(L) := CanonicalDigest(
  ts_iss,
  checkpoint_verification_key_fingerprint,
  vds_algorithm,
  leaf_encoding_profile_digest)

LeafEncodeV0(x) :=
  frozen mapping from the exact registered Signed Statement
  bytes and their format/media-type identifier to
  RFC9162 leaf input
~~~

“The same L” means the same `LogIdentityV0`: the same TS `iss`, checkpoint verification key, VDS algorithm, and leaf-encoding profile. The commitment's `log_identity_digest` MUST match the L identified by the outer receipt; a mismatch yields `REJECT`.

~~~ text
FullPrefixReplay(L, S_R) :=
  fetch every leaf's exact registered bytes and protected header
    at indices [0, size(S_R))                                ∧
  decode protected sub for SubjectView candidates            ∧
  fetch payload bytes for every SubjectView candidate needed
    to classify lifecycle/admission validity                  ∧
  reconstruct the RFC9162_SHA256 VDS root using LeafEncodeV0 ∧
  reconstructed_root = root(S_R)                            ∧
  verify signed_checkpoint(S_R)
~~~

The verifier MUST have authorized read access to the leaf bytes and protected headers of the entire Statement Sequence through `S_R`, as well as all payload bytes of subject-view candidates needed for classification under the frozen rules. Payloads for unrelated subjects are not required. Trust in the commitment-bound checkpoint key, VDS algorithm, and `LeafEncodeV0` is an explicit premise. If the complete prefix or a required subject payload is unavailable, the result is `HALT`, with no epistemic verdict.

Replay verifies that the profile and unique commitment were registered before the first relevant admission, that exactly one valid owner-signed closure precedes the final receipt, and that all those entries are in committed L. An entry or proof from another log identity yields `REJECT`; a separate parallel log is outside the claim and MUST be disclosed by the limitation. P10 v0 uses `RFC9162_SHA256` (VDS alg `1`, {{RFC9162}}). Inclusion and consistency proofs may accompany the transcript, but do not by themselves prove the absence of other entries.

An RFC 9943 Registration Policy can change, and its rejection of new entries is only defense in depth; it is not a soundness premise of P10 coverage.

# Evidence Admission {#evidence-admission}
<!-- SOURCE: §2.5. -->

~~~ text
AuthorizedAdmitters(ι) := exact CWT iss set committed by
  authorized_admitter_set_digest

AuthorizedLifecycleIssuer(ι) := instance_owner_iss = issuer_id

EvidenceAdmission(a) :=
  registration in L of an authenticated statement binding the
  canonical form of a and proof AdmissibleItemπ(a) under the
  frozen admission rules:
  a SCITT Signed Statement whose payload is an in-toto Statement v1
  containing the P10 evidence-admission predicate, with
    protected sub = instance_subject                         ∧
    protected iss ∈ AuthorizedAdmitters(ι)                  ∧
    a valid signature for that iss                          ∧
    accessible payload bytes satisfying the frozen rules.
~~~

A matching `sub` from an unauthorized `iss` is not an admission. If the closure nevertheless cites it, the result is `REJECT`.

For a non-admission lifecycle predicate, a matching-`sub` entry is valid only if it has a valid `AuthorizedLifecycleIssuer(ι)` signature and the expected predicate type. An unauthorized lifecycle entry is excluded from uniqueness counts; if a valid object cites it as a commitment, profile, or closure, the result is `REJECT`.

**Definition-level limitation:** admission is a protocol registration event. Registration order proves that the profile was locked before protocol registration of the evidence; it does not prove when the evidence was created or issued, or that the profile author had not previously seen public data.

# Evidence Closure and Checkpoint-Bounded Coverage {#evidence-closure-and-checkpoint-bounded-coverage}
<!-- SOURCE: §2.6. Traceability: N11, L04. -->

~~~ text
SubjectView(L, S_R, instance_subject) :=
  every replayed statement at leaf_index < size(S_R)
  whose protected CWT sub = instance_subject

ClosureTranscriptViewπ(L, S_R, ι) :=
  the subsequence of SubjectView containing only:
    valid owner-signed lifecycle entries for ι, or
    RelevantAdmissionπ entries for ι

RelevantAdmissionπ(x, ι) :=
  x ∈ SubjectView(L, S_R, instance_subject)                 ∧
  x is a valid EvidenceAdmission predicate                  ∧
  x.protected_iss ∈ AuthorizedAdmitters(ι)                  ∧
  signature_valid(x)                                       ∧
  payload_accessible(x)                                    ∧
  AdmissibleItemπ(x.payload)

EvidenceClosure(ι) binds:
  instance_subject
  terminal = true
  ordered_admission_refs
  closed_evidence_set_digest
  checkpoint_preclosure_transcript_digest

CoverageProofπ(ι, S_R) verifies:
  FullPrefixReplay(L, S_R)                                  ∧
  exactly one valid InstanceCommitment for the instance tuple ∧
  exactly one valid owner-signed EvidenceClosure
    for instance_subject                                    ∧
  ordered_admission_refs are in strictly ascending leaf order ∧
  ordered_admission_refs contain no duplicates              ∧
  each ref identifies a RelevantAdmissionπ                  ∧
  every RelevantAdmissionπ before the closure appears exactly once ∧
  no RelevantAdmissionπ occurs after closure and before size(S_R) ∧
  e = Bundleπ(ordered_admission_refs) ∈ Eπ                  ∧
  receipt.evidence_digest = digest(e)
~~~

- No closure, replay, or required payload bytes → `HALT`, with no epistemic verdict. A conflicting commitment/closure, or an omitted, duplicated, misordered, unauthorized, or post-closure relevant admission → `REJECT`.
- `checkpoint_preclosure_transcript_digest` MUST describe the uninterrupted `ClosureTranscriptViewπ` subsequence immediately before the closure leaf. Entries for other subjects and unauthorized matching-`sub` entries do not invalidate closure. If a valid owner-signed lifecycle entry or `RelevantAdmissionπ` lands between transcript preparation and closure registration, that closure candidate is invalid (fail-closed). The issuer MUST replay the subject view, rebuild the references, and register a new closure; the invalid attempt is not counted as a valid closure.
- The leaf index assigned by committed L is the authoritative total registration order, including entries received in the same batch. `Bundleπ` uses that strictly increasing order; the TS cannot present a different order for the same checkpoint without violating VDS integrity.
- The receipt is computed over closed `e`, not an arbitrarily selected admission. The claim holds only through signed checkpoint `S_R`; a later entry does not retroactively change the historical claim and supports no claim of future absence.
- To avoid a post-registration hash cycle, the issuer-signed P10 payload binds `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`. The outer SCITT Receipt ({{RFC9942}}) supplies `S_R`; `S_R`, the final replay transcript, and the coverage-verification result are not fields in the issuer-signed payload. Full-prefix replay occurs after receipt acquisition.

# Canonical Encoding {#canonical-encoding}
<!-- SOURCE: §2.7. -->

- P10 v0 uses UTF-8 JSON Canonicalization Scheme (JCS, {{RFC8785}}) for claims, structured evidence objects, worlds, and the P10 predicate. The codec digest is part of the profile ({{introduction}}, item (1)) and receipt.
- Integers outside the safely interoperable JCS/JSON range, rational numbers, and exact decimal values are encoded as canonical strings under the frozen exact-number schema; they are not emitted as JSON numbers.
- A **unique normal form** applies: `decode ∘ encode = id` on `Wπ`, with exactly one JCS form per decoded world. `Compatibleπ` and `Evalπ` operate on decoded semantic objects; the verifier rejects noncanonical witnesses.
- A structured P10 `*_digest` uses SHA-256 over the corresponding JCS bytes. Binary artifacts are digested over raw bytes together with the frozen format/media-type identifier, not over a JCS reinterpretation. Noncryptographic or merely immutable identifiers are insufficient.

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
