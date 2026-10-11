---

title: "P10 Underdetermination Profile: Adjudication Statements over SCITT"
abbrev: "P10 Underdetermination Profile"
docname: draft-nestorov-scitt-p10-underdetermination-01
category: info
submissiontype: IETF
ipr: trust200902
area: Security
keyword:
  - SCITT
  - in-toto
  - underdetermination
  - adjudication
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
  RFC9943:
  RFC9942:
  RFC9052:
  RFC8392:
  RFC9597:
  RFC8785:
  RFC9162:
  IN-TOTO-STATEMENT:
    title: "in-toto Attestation Framework: Statement layer specification, v1"
    author:
      - org: in-toto Project
    date: 2024-05-06
    seriesinfo:
      Commit: 06eafe3635bf8a425ad52cc82c6c90861e94a471
    target: https://raw.githubusercontent.com/in-toto/attestation/06eafe3635bf8a425ad52cc82c6c90861e94a471/spec/v1/statement.md
  IN-TOTO-V1:
    title: "Specification for in-toto attestation layers, Version v1.1"
    author:
      - org: in-toto Project
    date: 2024-05-06
    seriesinfo:
      Commit: 06eafe3635bf8a425ad52cc82c6c90861e94a471
    target: https://raw.githubusercontent.com/in-toto/attestation/06eafe3635bf8a425ad52cc82c6c90861e94a471/spec/v1/README.md

informative:
  RFC7942:
  RFC2606:
  SCRAPI-11:
    title: "Supply Chain Integrity, Transparency, and Trust (SCITT) Reference APIs"
    author:
      - ins: H. Birkholz
        name: Henk Birkholz
        org: Fraunhofer SIT
      - ins: J. Geater
        name: Jon Geater
        org: Bowball Technologies Ltd
      - ins: A. Delignat-Lavaud
        name: Antoine Delignat-Lavaud
        org: Microsoft Research
    date: 2026-06-26
    seriesinfo:
      Internet-Draft: draft-ietf-scitt-scrapi-11
    target: https://datatracker.ietf.org/doc/draft-ietf-scitt-scrapi/11/
  P10-V011:
    title: "P10 Underdetermination Profile, version 0.1.1"
    author:
      - ins: I. Nestorov
        name: Ivan Nestorov
    seriesinfo:
      DOI: 10.5281/zenodo.22994744
    date: 2026-09-27
    target: https://doi.org/10.5281/zenodo.22994744
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
  PRAMANA:
    title: "Pramana: A Protocol-Layer Treatment of Claim Verification in Autonomous Agent Networks"
    author:
      - ins: R. K. Kadaboina
        name: Ravi Kiran Kadaboina
    date: 2026-05-19
    seriesinfo:
      arXiv: "2605.20312"
    target: https://arxiv.org/abs/2605.20312v1
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
      "Lecture Notes in Computer Science": "12699, pp. 625–635"
      DOI: "10.1007/978-3-030-79876-5_37"
    target: https://doi.org/10.1007/978-3-030-79876-5_37

--- abstract

P10 defines a third-party-verifiable binding for NotDemonstrated(reason=underdetermined). A conforming P10 Adjudication Statement carries two canonical witness worlds that are compatible with the same closed evidence set and produce different values for the same frozen claim. The witness result is checked against committed profile semantics and bound into a SCITT Transparent Statement containing an in-toto Statement v1 predicate. The result establishes underdetermination only relative to the declared profile and does not identify the actual world or establish either claim value as true.

--- middle

# Introduction {#introduction}

> The proposed P10 Underdetermination Profile defines a third-party-verifiable binding for `NotDemonstrated(reason=underdetermined)`. Issuance is permitted only when:
> (1) the world class, admissible-evidence-bundle space and item-admission rules, frozen bundle constructor, compatibility relation, claim interpretation, evidence scope and coverage rules, canonicalization, world codec, committed log identity, leaf encoding, lifecycle/admitter authorization, and verifier were committed in a profile and an identified `InstanceCommitment` before the first evidence admission for that instance;
> (2) within the committed transparency log `L`, exactly one profile and claim are bound to the `(issuer_id, request_id)` subject, and an `EvidenceClosure` plus checkpoint-bounded `CoverageProof` binds every valid, registered, in-scope admission made by a frozen authorized admitter through `S_R`;
> (3) the P10 Adjudication Statement carries two semantically distinct worlds from that frozen world class, represented in the profile's frozen canonical serialization;
> (4) the frozen verifier establishes that both witnesses are compatible with that same closed evidence set and assign different values to the same frozen claim; and
> (5) the instance commitment, profile, claim, closed evidence set, witnesses, proof, verifier and mandatory limitations are SHA-256-bound in a SCITT Transparent Statement whose payload is an in-toto Statement v1 containing the P10 predicate, with complete VDS-prefix replay and registration/coverage verification satisfying {{full-prefix-replay}} through {{evidence-closure-and-checkpoint-bounded-coverage}}.
> The result establishes underdetermination only relative to the declared profile and does not identify the actual world or establish either claim value as true.

**Nature of the contribution:** profile-and-binding contribution. It is not a new mathematical theorem.

## Scope and Relationship to SCITT {#scope-and-relationship-to-scitt}

The profile defines a third-party-verifiable underdetermination binding for SCITT ({{RFC9943}}) using an in-toto Statement v1 ({{IN-TOTO-STATEMENT}}) predicate; the envelope structure is specified in {{statement-and-predicate-structure}}.

## Profile, Instance, and Deployment {#profile-instance-deployment}

This document distinguishes three layers.

The *profile* is the abstract P10 Underdetermination Profile specified in
{{formal-core}} through {{statement-and-predicate-structure}}. It defines what
must be committed before the first evidence admission, what a verifier must
check, and when a P10 Adjudication Statement may be issued. Conformance
statements in this document refer only to the profile.

An *instance* is one identified `InstanceCommitment` together with the concrete
values that fill the profile's committed slots: for example the world class
and claim semantics, the statement payload schema, the specific byte mapping
selected for `LeafEncodeV0`, the VDS and `LogIdentityV0`, the key-resolution
material, and the authorized admitter set. These values are chosen by the
instance owner. A value selected for one instance is not thereby a requirement
of the profile.

A *deployment* is the operational environment in which an instance is
executed, such as a particular Transparency Service implementation, its
registration and bootstrap configuration, and the hosts and toolchains used
for replay. Deployment properties are outside the profile.

{{executed-instance}} and {{reproduction-pins}} are informative. They describe
one executed instance and its deployment, and they neither add profile
requirements nor establish properties of other instances, other world
classes, or other SCITT Transparency Services. In particular, a Transparency
Service may satisfy {{RFC9943}} without supporting the exact,
checkpoint-bounded statement-byte replay used by the executed instance; that
replay capability is a property of the P10-over-SCITT composition, not a
SCITT conformance criterion.

## Non-Claims {#non-claims}

- That “two compatible models ⇒ underdetermination” is novel.
- That the P10 Adjudication Statement identifies the actual world or establishes either claim value as true.
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
- That any downstream action was governed by the P10 Adjudication Statement's verdict. P10 establishes only that the certificate verifies under the uniquely committed profile and its transitively bound verifier artifacts.
- Anything about market or commercial priority.

# Conventions and Terminology {#conventions-and-terminology}

{::boilerplate bcp14-tagged}

The following notation and symbols are defined in the referenced sections:

* `Wπ`, `Compatibleπ`, and `Evalπ` are defined in {{definitions}}.
* `Eπ` and `VerifierManifestV0` are defined in {{issuance-conditions}}.
* `InstanceCommitment` is defined in {{instance-commitment-and-subject}}.
* `L` is defined in {{full-prefix-replay}}; `S_R` denotes the verified checkpoint obtained from the SCITT Receipt, as shown in {{statement-and-predicate-structure}}.
* `SubjectView`, `RelevantAdmissionπ`, `EvidenceClosure`, and `CoverageProof` are defined in {{evidence-closure-and-checkpoint-bounded-coverage}}.

# Formal Core {#formal-core}

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

The resolved checker MUST construct `CertificateTargetV0` exclusively from the committed profile, closed evidence set, committed claim, and canonical witnesses carried by the P10 Adjudication Statement. The certificate MUST NOT supply or select its own target proposition.

Every artifact digest above binds both the exact bytes and its frozen artifact identifier or path and format. An unavailable required profile, manifest, checker, build, dependency, `.olean`, axiom-policy, acceptance-command, or toolchain artifact yields `HALT`, with no epistemic verdict. A digest mismatch, substitution, or certificate checked under any other profile, checker, build, axiom policy, or toolchain yields `REJECT`.

**Preflight rule:**

~~~ text
¬ProfileAdmissible(π, c) →
  preflight HALT, no verdict
¬FormallyUnderdeterminationCapable(π, c) →
  profile MUST NOT issue a P10 Adjudication Statement with an underdetermination outcome
~~~

For infinite `Wπ`, `Underdeterminedπ` is still checked with a concrete witness pair and decidable `Compatibleπ` and `Evalπ`. `Determinateπ(eᵈ, c)` is a universal claim: the verifier accepts a Lean proof term, but generation of such a proof is not guaranteed. If no proof term is available, preflight MUST return `HALT`, not an epistemic verdict.

`UnfalsifiableAsStated` is not derived from profile failure. It requires a separate semantic obligation over the claim wording, relativized to the declared world class and evidence language. That obligation is outside this profile.

# Instance Commitment and Subject {#instance-commitment-and-subject}

The identified adjudication instance is a subject derived from the issuer/request pair, not a freely chosen `instance_id`:

~~~ text
instance_subject := SubjectDeriveV0(issuer_id, request_id)
~~~

`SubjectDeriveV0` uses frozen, domain-separated canonical encoding and returns a text string (`tstr`) for CWT `sub` ({{RFC8392}}). Its digest is bound by the commitment. Before the first evidence admission, the following MUST be registered:

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

“The same L” means the same `LogIdentityV0`: the same TS `iss`, checkpoint verification key, VDS algorithm, and leaf-encoding profile. The commitment's `log_identity_digest` MUST match the L identified by the outer SCITT Receipt; a mismatch yields `REJECT`.

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

Replay verifies that the profile and unique commitment were registered before the first relevant admission, that exactly one valid owner-signed closure precedes the final P10 Adjudication Statement, and that all those entries are in committed L. An entry or proof from another log identity yields `REJECT`; a separate parallel log is outside the claim and MUST be disclosed by the limitation. P10 v0 uses `RFC9162_SHA256` (VDS alg `1`, {{RFC9942}}; tree structure, {{RFC9162}}). Inclusion and consistency proofs may accompany the transcript, but do not by themselves prove the absence of other entries.

An RFC 9943 Registration Policy can change, and its rejection of new entries is only defense in depth; it is not a soundness premise of P10 coverage.

# Evidence Admission {#evidence-admission}

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
- The P10 Adjudication Statement is computed over closed `e`, not an arbitrarily selected admission. The claim holds only through signed checkpoint `S_R`; a later entry does not retroactively change the historical claim and supports no claim of future absence.
- To avoid a post-registration hash cycle, the issuer-signed P10 payload binds `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`. The outer SCITT Receipt ({{RFC9942}}) supplies `S_R`; `S_R`, the final replay transcript, and the coverage-verification result are not fields in the issuer-signed payload. Full-prefix replay occurs after SCITT Receipt acquisition.

# Canonical Encoding {#canonical-encoding}

- P10 v0 uses UTF-8 JSON Canonicalization Scheme (JCS, {{RFC8785}}) for claims, structured evidence objects, worlds, and the P10 predicate. The codec digest is part of the profile ({{introduction}}, item (1)) and the P10 Adjudication Statement.
- Integers outside the safely interoperable JCS/JSON range, rational numbers, and exact decimal values are encoded as canonical strings under the frozen exact-number schema; they are not emitted as JSON numbers.
- A **unique normal form** applies: `decode ∘ encode = id` on `Wπ`, with exactly one JCS form per decoded world. `Compatibleπ` and `Evalπ` operate on decoded semantic objects; the verifier rejects noncanonical witnesses.
- A structured P10 `*_digest` uses SHA-256 over the corresponding JCS bytes. Binary artifacts are digested over raw bytes together with the frozen format/media-type identifier, not over a JCS reinterpretation. Noncryptographic or merely immutable identifiers are insufficient.

# Statement and Predicate Structure

**Inside the issuer-signed P10 payload:**

~~~ text
instance_commitment_ref       -- before the first admission
profile_commitment_ref
  -- profile registration in L
evidence_admission_refs
  -- all instance admissions covered by the closure
evidence_closure_ref
preclosure_transcript_digest  -- independent of S_R
instance_subject              -- protected CWT sub
log_identity_digest           -- committed L
claim_digest
evidence_digest               -- over the JCS form of the closed set
codec_digest
witness_0_digest, witness_1_digest   -- canonical form
capability_proof_digest       -- eᵈ, eᵘ, and proofs
proof_digest                  -- Lean object + axiom audit
verifier_digest
  -- equals profile.verifier_manifest_digest
limitations_digest
  -- includes verbatim AP1 and coverage/instance text
limitations                   -- mandatory must-understand P10 field
outcome = NotDemonstrated(reason=underdetermined)
~~~

In the issuer-signed field list above, `instance_commitment_ref` is specified in {{instance-commitment-and-subject}}; `evidence_closure_ref` and `preclosure_transcript_digest` in {{evidence-closure-and-checkpoint-bounded-coverage}}; `log_identity_digest` in {{full-prefix-replay}}; `codec_digest` in {{canonical-encoding}}; and the proofs bound by `capability_proof_digest` in {{issuance-conditions}}.

Profile v0.1.1 used `S₁` as editorial outline notation. It introduces no additional wire field, VDS checkpoint, or acceptance condition. Profile v0.1.1 §2.6 also used undefined editorial shorthand `S_C`; it introduces no additional wire field, VDS checkpoint, digest, or acceptance condition. In context, the issuer-signed closure-related bindings are the already defined `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`.

**Outside the issuer-signed payload, obtained only after registration:**

~~~ text
receipt_checkpoint_ref
  -- SCITT Receipt in COSE unprotected label 394
S_R
  -- verified checkpoint from the SCITT Receipt
order_and_coverage_transcript_digest
  -- FullPrefixReplay through S_R
coverage_verification_result
  -- ACCEPT / REJECT / HALT + diagnostics
~~~

These post-registration values are P10 verifier output over the Transparent Statement. They may be serialized in a separate verification report, but are not part of the issuer-signed P10 predicate and do not enter its digest. The standard SCITT Receipt ({{RFC9942}}) remains in COSE unprotected-header label `394`, avoiding a hash cycle.

Before accepting the epistemic outcome, the verifier MUST establish `ActiveProfileBindingV0`. Registration order proves when the committed object entered `L`; it is not by itself evidence that the object was used. P10 establishes verifier-time use by independently resolving the unique instance-bound profile and its `VerifierManifestV0`, matching every required artifact, constructing `CertificateTargetV0` from the committed inputs, and type-checking the submitted certificate against that target under exactly that resolved combination.

**The only v0 envelope:** a SCITT Signed Statement ({{RFC9943}}) (`COSE_Sign1`, {{RFC9052}}) whose payload is an in-toto Statement v1 ({{IN-TOTO-STATEMENT}}) with the P10 predicate. After registration and attachment of a SCITT Receipt ({{RFC9942}}), it becomes a Transparent Statement. Profile commitment, instance commitment, evidence admissions, evidence closure, and final P10 adjudication statement use the same pattern, the same L, and the same protected CWT `sub`. A bare in-toto predicate, standalone signed in-toto envelope, or SCITT Statement without the required SCITT Receipt is insufficient. No new wire format is introduced.

# Implementation Status {#implementation-status}

This section records implementation status in the format recommended by {{RFC7942}}. It is intended to be removed before publication as an RFC.

## Implementation {#implementation}

A research prototype of the P10 verification chain has been implemented by VolMax Studio Lab d.o.o. The implementation comprises a Lean-checked S1 underdetermination component, the S2b replay verifier, the S2a coverage checker, post-S2a binding checks, and an S3 registration/capture path with replay tooling.

The executed SCITT-facing instance used Tessera v1.0.4 as a transparency-log engine behind an S3-owned facade. Tessera itself was not treated as an off-the-shelf RFC 9943 Transparency Service, and the implementation claims neither general RFC 9943 conformance nor conformance with the SCITT Reference APIs (SCRAPI) {{SCRAPI-11}} for that facade.

The Transparency Service registration path and the P10 verification path have distinct trust roles. A Transparency Service may verify a Signed Statement signature while processing registration as required by its registration procedure. P10 acceptance does not treat that operator-side check as verification evidence. During replay, S2b independently verifies the relevant Signed Statement signatures against the key-resolution material frozen for the instance.

## Organization and Contact {#implementation-contact}

The implementation is maintained by VolMax Studio Lab d.o.o.

Contact: Ivan Nestorov, `volmax.core@gmail.com`

## Maturity {#implementation-maturity}

The implementation is a research prototype that has been exercised through an end-to-end P10-over-SCITT demonstration.

It is not a production Transparency Service, a general-purpose SCITT implementation, or evidence of conformance for arbitrary P10 profiles or arbitrary SCITT deployments.

## Implemented Functionality {#implemented-functionality}

The implemented chain includes:

* a Lean-checked S1 underdetermination certificate over the frozen demonstration profile, together with an instance-binding record subsequently checked against the target instance;
* checkpoint-bounded replay over the authenticated ordered prefix committed by the executed instance;
* verification of SCITT Receipt and checkpoint material against committed instance parameters;
* independent verification of relevant Signed Statement signatures under frozen key-resolution material;
* enforcement of the frozen `LogIdentityV0` and `LeafEncodeV0` parameters;
* construction of the exact replay transcript `tB` consumed by S2a;
* formally checked S2a coverage semantics over that transcript;
* post-S2a validation of the target P10 Adjudication Statement, including consistency of the S1 certificate linkage, instance binding, evidence set, witnesses, profile, and accepted status; and
* reproduction tooling for the executed demonstration.

The execution order is S2b replay, followed by S2a coverage checking, followed by post-S2a binding. `ReplayResult::Verified` from S2b establishes only that replay reconstructed the exact `tB` required by S2a; it is not by itself an S2a acceptance result or a P10 epistemic verdict.

For the executed instance, Tessera v1.0.4 supplied the transparency-log engine. A purpose-built S3 facade performed the P10-specific registration, SCITT Receipt construction, capture, and export functions required by that instance.

## Demonstrated Execution {#demonstrated-execution}

The prototype has been exercised against a captured P10-over-SCITT lifecycle and produced `BINDING_MATCH` for the accepted demonstration instance.

In that execution, the target P10 Adjudication Statement was already a registered Signed Statement with a SCITT Receipt proving its inclusion in the selected VDS. It was an input to verification, not an output synthesized by the replay chain. S2b first reconstructed the replay transcript, S2a then checked coverage over that transcript, and post-S2a binding checked that the registered target statement matched the accepted S1 and S2a results.

The accepted result was subsequently reproduced from retained artifacts through the offline replay path and through the Replay Workbench on a second host under the same operator. These reproductions establish reproducibility of the recorded demonstration under the pinned artifacts and implementation configuration. They do not constitute independent third-party attestation or general interoperability certification.

## Implementation Experience {#implementation-experience}

Two implementation findings are recorded here because they arose from executed verification paths rather than only from design analysis.

First, the initially selected `serde_jcs` version 0.1.0 did not reproduce the RFC 8785 Section 3.2.3 property-ordering example in the executed probe. The observed implementation ordered object members using serialized key bytes rather than the UTF-16 code-unit ordering required by RFC 8785. The frozen dependency selection therefore failed its acceptance expectation and was replaced rather than compensated for inside the P10 logic.

This finding is specific to `serde_jcs` 0.1.0. It is not a claim about later versions. Source review of version 0.2.0 shows UTF-16 key ordering, but that release requires a Rust toolchain newer than the Rust 1.82.0 toolchain frozen for the executed verifier. The implementation therefore selected `serde_json_canonicalizer` 0.3.2 and retained the frozen verifier semantics unchanged.

Second, an early S3 integration dry run supplied RFC 9162 inclusion-proof material in a representation that did not satisfy the RFC 9942 Receipt encoding expected by the frozen replay decoder. The request was rejected with `ProofEntryNotBstr`. The facade-side representation was corrected so that the CBOR inclusion-proof content was wrapped in the required byte string, after which the subsequent dry run proceeded through that check.

This second observation is an internal integration result, not an external validation result and not a finding against Tessera. Tessera supplied native transparency-log proof material; adapting that material into the RFC 9942 Receipt representation was the responsibility of the S3 facade. The observation illustrates an interoperability detail that implementations performing such adaptation need to handle explicitly.

## Known Limitations and Non-Claims {#implementation-limitations}

The demonstrated implementation has the following limitations and non-claims:

* The demonstration instance uses deliberately minimal two-bit fixture semantics. It demonstrates execution and binding of the protocol chain, not adequacy of P10 over a realistic evidence domain.
* The ratified S2a implementation has a liveness restriction that is stricter than the abstract profile. For an entry already present in the subject view, S2a attempts to obtain the payload before it can complete later semantic and authorization classification. An unavailable required payload therefore causes `HALT`, including when the entry might later have been classified as unauthorized. Where an attacker can cause such a same-subject entry to be registered and its required payload to remain unavailable, this can deny progress. It is an availability limitation, not a soundness failure: `HALT` produces no accepted epistemic verdict.
* The S3 facade is not claimed to be generally conformant with RFC 9943 or SCRAPI.
* The executed instance fixes `LeafEncodeV0` and its VDS identity. The demonstration therefore does not establish interoperability with arbitrary RFC 9162 or SCITT services that use a different leaf mapping.
* The presence of a Registration Policy or other policy statement in the authenticated prefix proves only that those bytes were registered. P10 does not infer that the Transparency Service enforced the policy described by those bytes.
* The demonstration does not establish independence of the implementation author, operator, evidence producer, or reproduction environment.
* The demonstration does not establish unclean-crash consistency, multi-writer behavior, key rotation, or witness operation for the transparency-log configuration.
* It does not establish absence of evidence outside the scope committed by the P10 instance.
* It does not establish that registration order represents statement creation, issuance, or first-observation order.
* It does not establish correctness of arbitrary P10 profiles beyond the profile and artifacts exercised by the recorded demonstration.

## Code and Artifact Availability {#code-and-artifact-availability}

The implementation is split across separately pinned repositories and does not have one common licensing status.

* `VolMax-Studio/p10-underdetermination-profile` is public and is distributed under the MIT License.
* `VolMax-Studio/p10-underdetermination-lean-s1` is public. At the ratified S1 tag used by the demonstration, the repository has no root license file; this document therefore infers no license grant from source availability.
* `VolMax-Studio/p10-coverage-lean-s2` is public. At the ratified S2a tag, the repository states that no license has been selected, that rights are reserved, and that no license grant is provided.
* `VolMax-Studio/p10-replay-verifier` has a public S2b export under the MIT OR Apache-2.0 licensing terms stated by that repository.
* `VolMax-Studio/p10-scitt-transparency-s3`, including the demonstration facade and Replay Workbench evidence, is private. At the accepted S3 tag it has no root license file; no public license grant is claimed.

Exact source commits, frozen specifications, manifests, capture artifacts, and reproduction pins for the executed instance are recorded separately in the reproduction material for this revision.

# Security Considerations

Lean ({{LEAN4}}) checks only the result of executing frozen, executable relations and functions over canonical objects. It checks nothing about the real world.

Each item in the following list is one row of the semantic-bridges table.

* **Bridge:** `Compatibleπ`
  * **What Lean checks:** The frozen relation returns `true` for (e, w₀) and (e, w₁)
  * **What remains an oracle / limitation:** Whether the relation faithfully represents real-world compatibility
* **Bridge:** `Evalπ`
  * **What Lean checks:** The frozen function returns different values on w₀ and w₁
  * **What remains an oracle / limitation:** Whether `Evalπ` faithfully translates the natural-language claim; this is P10 `R_sem` unless the claim is already formal
* **Bridge:** `Eπ` and admission
  * **What Lean checks:** `e ∈ Eπ` under the frozen rules
  * **What remains an oracle / limitation:** Whether `Eπ` realistically covers obtainable evidence
* **Bridge:** Profile adequacy (AP1)
  * **What Lean checks:** `FormallyUnderdeterminationCapable(π, c)`
  * **What remains an oracle / limitation:** Whether the determining evidence fixture is practically obtainable and representative (limitation below)
* **Bridge:** Canonicalization / codec
  * **What Lean checks:** SHA-256 digest and JCS canonical form match
  * **What remains an oracle / limitation:** Whether canonicalization loses claim-relevant information
* **Bridge:** Replay/order
  * **What Lean checks:** The complete VDS prefix of committed L reconstructs `S_R` and registration order ({{full-prefix-replay}})
  * **What remains an oracle / limitation:** Authorized access to all leaf/protected-header data and required subject payloads; registration order is not issuance order; other logs are outside the claim
* **Bridge:** Within-batch order
  * **What Lean checks:** Committed leaf indices define one total registration order
  * **What remains an oracle / limitation:** The TS chooses within-batch leaf order; an order-sensitive `Bundleπ` therefore treats that TS choice as an explicit trust assumption
* **Bridge:** Pre-evidence commitment
  * **What Lean checks:** Profile and instance were registered before protocol admission ({{instance-commitment-and-subject}} through {{evidence-admission}})
  * **What remains an oracle / limitation:** Does not prove author ignorance of public data or absence of other instances
* **Bridge:** Active profile/verifier
  * **What Lean checks:** `ActiveProfileBindingV0` resolves the unique instance-bound profile and verifies the certificate using only the checker, build, axiom policy, codecs, dependencies, `.olean` files, and Lean toolchain transitively bound by that profile
  * **What remains an oracle / limitation:** Establishes verifier-time recomputation under the committed adjudication profile; it does not establish that a downstream action was governed by the verdict
* **Bridge:** Coverage
  * **What Lean checks:** `EvidenceClosure` and `CoverageProof` close all valid, registered, in-scope admissions by authorized admitters through `S_R` ({{evidence-closure-and-checkpoint-bounded-coverage}})
  * **What remains an oracle / limitation:** Does not prove absence of unregistered/out-of-scope evidence, another `request_id`, or future entries
* **Bridge:** Cryptography
  * **What Lean checks:** Digests and signatures match
  * **What remains an oracle / limitation:** Digest collision resistance, signature unforgeability, and log non-equivocation/integrity
* **Bridge:** Verifier
  * **What Lean checks:** Kernel type-check plus `#print axioms` audit; the permitted axiom set is explicit in the profile
  * **What remains an oracle / limitation:** Trust in the Lean kernel and declared axioms; `sorryAx`, `Lean.ofReduceBool`, and `native_decide` are forbidden

**AP1 limitation (verbatim, mandatory in the P10 Adjudication Statement):**

> `FormallyUnderdeterminationCapable` does not establish that the determining evidence fixture is practically obtainable, representative, or likely to occur under the deployed acquisition process. A formally valid profile may remain operationally abstention-biased.

**Coverage/instance limitation (verbatim, mandatory in the P10 Adjudication Statement):**

> This receipt establishes completeness only within the committed transparency log `L`, for valid, registered, in-scope admissions made by the frozen authorized admitters for the identified `(issuer, request)` subject through the signed checkpoint `S_R`. It does not establish that no commitment or admission for the same `request_id` exists in another transparency log, that no unregistered or out-of-scope evidence exists, that no semantically equivalent request was opened under a different `request_id`, or that no later statement was registered after `S_R`. Verification requires complete VDS-prefix replay of committed `L` and access to all subject payload bytes needed by the frozen admission rules. This receipt establishes uniqueness only for the identified instance tuple within committed `L` through `S_R`. It does not establish that the issuer did not create other instances for the same `claim_digest` under different `request_id` values, bind those instances to different profiles or world classes, or select the presented instance after observing evidence or outcomes.

Where sibling `InstanceCommitment` payloads are accessible, a verifier SHOULD report the number visible through `S_R` for the same `(instance_owner_iss, claim_digest)`. Version 0.1.1 assigns no acceptance or rejection semantics to that count. This recommendation does not expand the payload-availability requirement of `FullPrefixReplay`; mandatory sibling counting requires a future profile with an additional availability or indexing rule.

Introducing a `Reachableπ(e)` predicate does not solve AP1. Lean would check frozen `Reachableπ(eᵈ)`, but not whether that relation faithfully represents physical or practical availability. It would merely move the oracle boundary.

Every row of this table is included in the P10 Adjudication Statement's `limitations` field. The P10 predicate specification marks `limitations` as a mandatory **must-understand** field: a P10 verifier MUST reject a predicate without it, even though generic in-toto v1 rules ({{IN-TOTO-V1}}) otherwise require unknown fields to be ignored.

# Privacy Considerations

A P10 Adjudication Statement contains or references claim, profile, evidence-admission, evidence-closure, witness, certificate, and verifier identifiers or digests. Cryptographic digests provide integrity binding but do not provide confidentiality, particularly for low-entropy or guessable inputs. Registration with a transparency service can create persistent and linkable metadata across P10 Adjudication Statements or instances. This profile does not define confidentiality, anonymization, unlinkability, access control, or retention policy.

# IANA Considerations
This document has no IANA actions.

--- back

# Conformance Tests
{:numbered="true"}

## Mutation Tests (MUST yield REJECT or the stated outcome)

- **#:** M1

  **Mutation:** Change `W`, `Compatible`, `Eval`, `Eπ`, `AdmissibleItemπ`, `Bundleπ`, evidence scope, admission/coverage rules, codec, or canonicalization after instance commitment

  **Expected:** REJECT

- **#:** M2

  **Mutation:** `Compatible := fun _ _ => true`

  **Expected:** Fails `FormallyUnderdeterminationCapable`: constant `Evalπ` gives no `eᵘ`; nonconstant `Evalπ` gives no `eᵈ`. Empty `Wπ` makes `Determinateπ` false via `NonemptyCompatibleπ`. No case yields a P10 Adjudication Statement with an underdetermination outcome.

- **#:** M3

  **Mutation:** Witness outside frozen `Wπ`

  **Expected:** REJECT

- **#:** M4

  **Mutation:** Two witnesses with the same claim value

  **Expected:** REJECT

- **#:** M5

  **Mutation:** P10 Adjudication Statement without an earlier profile-registration entry

  **Expected:** REJECT

- **#:** M6

  **Mutation:** Change `limitations` or witness bytes without changing the digest

  **Expected:** REJECT

- **#:** M7

  **Mutation:** Profile/instance and admission are in different logs, or replay shows admission before commitment

  **Expected:** REJECT

- **#:** M8

  **Mutation:** Same world in two serializations; noncanonical witness

  **Expected:** REJECT

- **#:** M9

  **Mutation:** Profile without a determinability witness

  **Expected:** Preflight HALT, no adjudication verdict. **Not** `UnfalsifiableAsStated`.

- **#:** M10

  **Mutation:** `eᵈ` or `eᵘ` added or replaced after admission

  **Expected:** REJECT

- **#:** M11

  **Mutation:** Bare in-toto predicate, standalone signed in-toto envelope, or SCITT Statement without the required SCITT Receipt

  **Expected:** REJECT

- **#:** M12

  **Mutation:** P10 Adjudication Statement derived from self-reported timestamps instead of {{full-prefix-replay}}

  **Expected:** REJECT

- **#:** M13

  **Mutation:** Claim `c` was not bound by `InstanceCommitment` before first admission, or was replaced afterward

  **Expected:** REJECT

- **#:** M14

  **Mutation:** No pre-evidence `InstanceCommitment`

  **Expected:** Preflight HALT, no adjudication verdict

- **#:** M15

  **Mutation:** Within committed L, another `profile_digest` or `claim_digest` exists under `(instance_owner_iss, request_id, instance_subject)`

  **Expected:** REJECT

- **#:** M16

  **Mutation:** Missing closure/proof, P10 Adjudication Statement not after closure or not over exactly the closed set, or relevant admission after closure and before `S_R`

  **Expected:** Missing closure/proof → HALT; wrong order or omitted, duplicated, injected, or post-closure evidence through `S_R` → REJECT

- **#:** M17

  **Mutation:** P10 predicate lacks `limitations`, or verifier ignores it as unknown

  **Expected:** REJECT

- **#:** M18

  **Mutation:** Selected inclusion/consistency proofs supplied without the complete VDS prefix through `S_R`

  **Expected:** HALT, no epistemic verdict

- **#:** M19

  **Mutation:** Within committed L, another valid commitment or conflicting profile/claim exists for `(instance_owner_iss, request_id, instance_subject)`

  **Expected:** REJECT

- **#:** M20

  **Mutation:** Statement has matching `sub`, but `iss` is outside the frozen authorized-admitter set

  **Expected:** Not an admission; if cited by closure → REJECT

- **#:** M21

  **Mutation:** A replayed `RelevantAdmissionπ` is omitted from `ordered_admission_refs`

  **Expected:** REJECT

- **#:** M22

  **Mutation:** `RelevantAdmissionπ` occurs after closure but before `size(S_R)`

  **Expected:** REJECT

- **#:** M23

  **Mutation:** Admission reference is duplicated or references are not in strictly increasing leaf order

  **Expected:** REJECT

- **#:** M24

  **Mutation:** A detached/encrypted payload required by frozen admission rules is unavailable

  **Expected:** HALT, no epistemic verdict

- **#:** M25

  **Mutation:** A new relevant entry is registered only after `S_R`

  **Expected:** Historical claim remains scoped to `S_R`; no claim of future absence

- **#:** M26

  **Mutation:** Same `(issuer_id, request_id)` exists in L1 and L2

  **Expected:** Each P10 Adjudication Statement claims completeness only within its committed L; no global uniqueness claim

- **#:** M27

  **Mutation:** SCITT Receipt or replay input uses a different TS `iss`, checkpoint key, VDS algorithm, or leaf encoding from committed `LogIdentityV0`

  **Expected:** REJECT

- **#:** M28

  **Mutation:** Matching-`sub` profile/commitment/closure signed by an `iss` other than `instance_owner_iss`

  **Expected:** Not a valid lifecycle entry; if cited by a valid object → REJECT

- **#:** M29

  **Mutation:** Admission registered after the pre-closure transcript but before the closure leaf

  **Expected:** Closure candidate invalid; replay/rebuild/retry, with no epistemic verdict until a valid closure

- **#:** M30

  **Mutation:** Issuer-signed P10 payload contains `S_R`, SCITT Receipt reference, or final replay/coverage result

  **Expected:** REJECT; post-registration values MUST remain outside the payload

- **#:** M31

  **Mutation:** Mandatory cross-instance limitation bytes are absent, altered, or do not match `limitations_digest`

  **Expected:** REJECT

- **#:** M32

  **Mutation:** The verifier loads, checks, or executes a profile whose digest differs from `InstanceCommitment.profile_digest`, even if that profile was registered before evidence admission

  **Expected:** REJECT

- **#:** M33

  **Mutation:** Checker source, `.olean` artifact, dependency lock, Lean toolchain, axiom policy, acceptance command, or build manifest differs from `VerifierManifestV0`

  **Expected:** REJECT; unavailable required artifact → HALT, with no epistemic verdict

- **#:** M34

  **Mutation:** Certificate proves a different, weaker, or certificate-supplied proposition instead of checker-constructed `CertificateTargetV0(π, e, c, w₀, w₁)`

  **Expected:** REJECT

- **#:** M35

  **Mutation:** `receipt.verifier_digest ≠ profile.verifier_manifest_digest`

  **Expected:** REJECT

## Adversarial-Profile Test

- **#:** **AP1**

  **Test:** `Compatibleπ` is strict only for frozen `eᵈ` and trivially `true` for all other evidence in `Eπ`

  **Expected:** Formally passes `FormallyUnderdeterminationCapable`. **Not** a soundness hole in the Lean core or a claim counterexample: the issued P10 Adjudication Statement proves the true proposition `Underdeterminedπ(e, c)` relative to the profile. An independent profile-adequacy review catches it, and the P10 Adjudication Statement carries the AP1 limitation ({{security-considerations}}). Not part of the mathematical core.

**Profile-adequacy review** is mandatory for every concrete profile before first use, beginning with the Sandia EFC profile. It is a separate gate outside this document.

# Executed P10-over-SCITT Instance {#executed-instance}

This appendix is informative. It describes one executed P10-over-SCITT instance and does not add conformance requirements beyond the body of this document. Exact reproduction and artifact pins are recorded in {{reproduction-pins}}.

## Instance Boundary {#executed-instance-boundary}

The executed instance was bounded by three repository states. Commit `7c3b2d4b919c356a566f8f5d3628d4f546e41afa`, referenced by the signed `v0.1.0-s3a-frozen` tag, froze the S3-A deployment definition. Commit `149953c29780e566b0b23f7a1b975dc93349daf2` recorded the normative S3-B capture and its operator-generated anchor before verification. Commit `5acc277a13dc122e39fcb5f9f3e646b06cc95009`, referenced by the signed `v0.1.0-s3-accepted` tag, recorded the accepted verification result.

The capture commit is a direct descendant of the frozen deployment definition, and the result commit is the next repository state after the capture commit. This ordering is repository provenance for capture-before-verification. The anchor was generated and recorded by the same operator; it is not an independent timestamp, external notarization, or third-party anchor.

Later offline packaging, second-host replay, and Replay Workbench evidence were produced after the accepted result. They are reproduction evidence and are not part of the executed-instance boundary defined above.

## Statement and Encoding Parameters {#executed-statement-parameters}

The executed instance used `RFC9162_SHA256` as its VDS algorithm and the frozen `LeafEncodeV0` mapping for the exact pre-Receipt Signed Statement bytes. Its committed `LogIdentityV0` digest was `6a510bcf3a122ae9af2714939d60a6a4e997ff9751836024dd480ebd60cd37c9`. The checkpoint origin was `volmax-s3/ts`.

The Receipt issuer identifier was `https://ts.example/volmax-s3`. The `.example` namespace is reserved for documentation and examples ({{RFC2606}}); the Transparency Service used for this demonstration was not publicly reachable and is not offered as a public service.

The deployment used detached-payload ES256 Receipts with low-S signatures and one committed Receipt key for the complete capture. The RFC 9679 thumbprint of that key was `6bc5b0ae47f8726379ffbfb0e0858fe10ef74ba5b8801edeba0b3d3b89944056`. The retained checks verified each of the eight returned Receipts under that same committed key. This does not mean that the thumbprint was carried as a field in every Receipt.

## Transparency-Service Access Requirements {#executed-ts-access}

P10 replay for this instance consumed the exact, complete, checkpoint-bounded `[0,8)` sequence of registered Signed Statement bytes as deterministic replay input. The retained capture also included the retained Receipts, signed checkpoints, response material, required payloads, and the public log export needed to reconstruct and check that prefix.

This is an operational requirement of the executed P10-over-SCITT instance. It does not change the abstract P10 profile and does not prescribe the storage architecture of a SCITT deployment.

The S3 facade used a leaf-input cap of 65535 bytes, corresponding to a maximum Signed Statement size of 65474 bytes under the selected `LeafEncodeV0` wrapper. Detached payloads used for signature verification were handled separately, with a 1 MiB limit. These are deployment limits of the executed facade, not general P10 limits.

The capture digest was recorded by the operator in the capture commit before the verification-result commit. That record establishes the repository ordering described in {{executed-instance-boundary}}; it does not establish an external observation time.

## Registration Path {#executed-registration-path}

The executed bootstrap used an issuer table supplied to the facade out of band. Two declaration statements were then registered as leaves 0 and 1. The logged declarations were not the source of registration authority: the facade used its preconfigured issuer table, and the declarations were published bytes.

For registration, the facade authenticated submitted Signed Statements with ES256 against the preconfigured issuer table before append. This was an operator-side registration check only. The P10 replay path did not accept that check as verifier evidence; S2b independently verified relevant Signed Statement signatures against the key-resolution material frozen for the instance.

The actual eight-leaf layout was as follows. `S` denotes the instance subject `p10s2sub:0fe1be115beb770330930911e69e4f2026c80809c64ada16e87fe63e7f9150d2`.

| Index | Role | `iss` | `sub` |
|---:|---|---|---|
| 0 | policy declaration | `volmax-s3-operator` | `urn:volmax:s3:policy-declaration` |
| 1 | verification-material declaration | `volmax-s3-operator` | `urn:volmax:s3:verification-material-declaration` |
| 2 | profile commitment | `volmax-owner` | `S` |
| 3 | operator note | `volmax-s3-operator` | `urn:volmax:s3:operator-note` |
| 4 | instance commitment | `volmax-owner` | `S` |
| 5 | evidence admission | `admitter-one` | `S` |
| 6 | evidence closure | `volmax-owner` | `S` |
| 7 | P10 Adjudication Statement | `volmax-owner` | `S` |

Registration was serialized for this deployment. Each registration was fresh, each returned index equaled the retained log position, and the public checkpoint retained after each registration had size `index + 1`. These observations describe this execution; they are not a general claim that SCITT registration order represents issuance or creation order.

The declarations at leaves 0 and 1 did not establish key authority or prove policy enforcement. Registration authentication was rooted in the out-of-band issuer table, while P10 replay authorization and signature interpretation were rooted in the frozen profile and its `key_resolution`.

## Executed Lifecycle {#executed-lifecycle}

The target P10 Adjudication Statement was registered at leaf 7 before the verification chain ran. Its selected SCITT Receipt established inclusion in the selected VDS at checkpoint size 8. It did not substitute for issuer signature verification by P10.

The executed verification flow was:

    registered target P10 Adjudication Statement at leaf 7
            +
    SCITT Receipt / checkpoint
            +
    exact retained Signed Statement bytes [0,8)
            |
            v
    S2b replay verifier
            |
            +-- independently verifies relevant statement signatures
            +-- verifies Receipt/checkpoint against committed parameters
            +-- reconstructs the exact replay transcript tB
            |
            v
    S2a coverage checker
            |
            v
    S2a ACCEPT
            |
            v
    post-S2a binding
      TargetAdjudicationValidV0 T1-T6
      closureAt
      AdjudicationBindingV0 A1-A15
            |
            v
    BINDING_MATCH

The accepted run executed in an ephemeral Linux x86_64 cloud container. CPython 3.13.16 was recorded for that run but was not a pinned acceptance input. Rust 1.82.0 and the selected Lean 4.33.0 executable identities were checked by the frozen runner path.

The accepted capture was later replayed on an operator-controlled workstation as a second host and produced the same accepted verdict. That later replay used CPython 3.12.3. The two observed interpreter versions with the same verdict are reproduction evidence; they are not a claim of Python-version independence.

## Demonstration Boundary {#executed-demonstration-boundary}

This appendix describes only the executed demonstration instance. The limitations and non-claims in {{implementation-limitations}} remain in force. In particular:

* the P10 semantics exercised by the instance were the deliberately minimal two-bit fixture semantics, not a realistic evidence domain;
* the S3-owned facade is not claimed to be a generally conformant RFC 9943 Transparency Service or SCRAPI implementation;
* fixing `LeafEncodeV0` and the VDS identity for this instance does not demonstrate interoperability with arbitrary SCITT Transparency Services;
* the same operator controlled the demonstration infrastructure and the later workstation replay, so the second-host result is not independent third-party attestation;
* the operator-generated capture anchor is not an external timestamp or independent observation; and
* the Receipt issuer identifier uses the reserved `.example` namespace and does not identify a publicly reachable service.

The executed result therefore demonstrates one pinned P10-over-SCITT composition through `BINDING_MATCH`; it does not enlarge the claims stated in the body of this document.

# Reproduction and Artifact Pins {#reproduction-pins}

This appendix is informative. It records the retained source, capture, execution, and reproduction identifiers for the executed demonstration. The status column has three meanings:

* `PINNED`: a frozen input or executable identity that was checked as part of the recorded execution path;
* `RECORDED`: a value retained in the evidence but not used as a frozen acceptance input; and
* `OPEN`: the retained evidence does not contain the artifact or value needed to make the stronger statement.

No `OPEN` field is inferred from an identical downstream verdict. To keep the RFC text rendering within the available page width, each matrix uses short identifier labels in the `Value` column. The complete identifier values follow each matrix verbatim.

## Upstream Source and Manifest Pins {#reproduction-upstream}

| Item | Value | Source | Status |
|---|---|---|---|
| P10 v0.1.1 | `A01/A02/A03` | `v0.1.1` | PINNED |
| S1 source | `A04/A05` | `v0.1.0-s1-ratified` | PINNED |
| S1 manifest | `A06` | `manifest/VerifierManifestS1.json @ e4db3747` | PINNED |
| S2a source | `A07/A08` | `v0.1.0-s2a-ratified` | PINNED |
| S2a verifier manifest | `A09` | `manifest/VerifierManifestS2aV0.json @ 741d56d3` | PINNED |
| S2a vector manifest | `A10` | `manifest/VectorManifestS2aV0.json @ 741d56d3` | PINNED |
| LeafEncode spec | `A11` | `profile/LeafEncodeV0_SPEC.md @ 741d56d3` | PINNED |
| LeafEncode digest | `A12` | `LeafEncodeSpecArtifactDigestV0` | PINNED |
| S2b source | `A13/A14` | `v0.1.0-s2b-complete` | PINNED |
| S2b exec manifest | `A15` | `manifest/S2bExecutionManifestV0.json @ 8eaa91ca` | PINNED |
| S2b vector manifest | `A16` | `manifest/VectorManifestS2bV0.json @ 8eaa91ca` | PINNED |
| S2b Cargo.lock | `A17` | `Cargo.lock @ 8eaa91ca` | PINNED |
| S2b toolchain file | `A18` | `rust-toolchain.toml @ 8eaa91ca` | PINNED |
| S2b public export | `A19/A20` | `v0.1.1-s2b-public` | RECORDED |

The exact identifiers used above are:

    A01 profile commit
      e2a02a73df9e50f624512043dcb007fc337ba587
    A02 profile tag object
      caa53b854367cf1253e431246e725dcd88570e9b
    A03 profile SHA-256
      b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558
    A04 S1 commit
      e4db3747eaeeb1a07227bb9029f9a9c3b566cdb1
    A05 S1 tag object
      7c3df437de454466b932a5d0dc889b3287c64e05
    A06 S1 verifier-manifest SHA-256
      06bf9129bf480c79ed5281ec2e944ac5613d1c340552ce5a415f5bf4c8965907
    A07 S2a commit
      741d56d36d7b2bfe2e9e0080a1cba4393e4a47da
    A08 S2a tag object
      c356cde5295dc82860b70305e3048db8f2717db3
    A09 S2a verifier-manifest SHA-256
      f8380b19b43334925e7f7621e1f7d7912f36c789199d3f8d069b87f5ea176d46
    A10 S2a vector-manifest SHA-256
      dd2d567e04fae52244feec988a56df26e4721f833f072dd7073959d9170e39ec
    A11 LeafEncodeV0 specification SHA-256
      d142e636a9a92fdc57bbc49e77e077607ff12e96c19b79ad539b2f6b17b16008
    A12 LeafEncodeSpecArtifactDigestV0
      571765530870e4a6c028a54ec48aab8153411a15cfe30c44611c11c02925f9d5
    A13 S2b ratified commit
      8eaa91cad1ffa963158b365c6d0d7316f4965e89
    A14 S2b complete tag object
      83fad0063443aa5d43620d82550dff9cbf3dd3a8
    A15 S2b execution-manifest SHA-256
      b027765dcc1d330886f0ab4a4daf29ced273fdb3a35dec859b752a63ae689495
    A16 S2b vector-manifest SHA-256
      2582c560abe2e7e0b5af63f0ba0428e3a4d2f625f36f6da430ef5b015bf27762
    A17 S2b Cargo.lock SHA-256
      e2214ae0e751a61d8480c6894d2868d1eb09e62d9d180c30fd743270494f995f
    A18 S2b rust-toolchain.toml SHA-256
      8e0c5bd6d955bff9fcb7d2028bc78d6cd5c66c74ea8586a9a56afe4c03939af4
    A19 S2b public-export commit
      8e89f9a4192bdd0ab280556701dc595eb55539d2
    A20 S2b public-export tag object
      d98179fb060ddf94f138bd5bb9720afdcb58ddcf

The public S2b distribution changes licensing, notice, README, security, and integration-documentation files relative to the ratified source. The manifest-covered implementation files listed above are identical at the ratified and public commits.

## Accepted S3 Capture and Identity Pins {#reproduction-s3-identity}

The capture-relative paths in this subsection are rooted at `ts-prototype/evidence/s3b-capture/capture/`.

| Item | Value | Source | Status |
|---|---|---|---|
| Frozen S3-A | `B01/B02` | `v0.1.0-s3a-frozen` | PINNED |
| Capture commit | `B03` | S3-B capture state | RECORDED |
| Accepted result | `B04/B05` | `v0.1.0-s3-accepted` | RECORDED |
| Capture index | `B06` | `capture.json @ 149953c` | PINNED |
| Replay request | `B07` | `request.cbor @ 149953c` | PINNED |
| Target Receipt | `B08` | `receipts/000007.receipt.cbor @ 149953c` | PINNED |
| Final checkpoint | `B09` | `provenance/public-checkpoints/000007.checkpoint @ 149953c` | PINNED |
| Log identity | `B10` | frozen `pB.json` | PINNED |
| Receipt key | `B11` | `public-keys/ts.public.cose_key.cbor @ 149953c` | PINNED |
| Owner key | `B12` | `public-keys/volmax-owner.public.cose_key.cbor @ 149953c` | PINNED |
| Admitter-one key | `B13` | `public-keys/admitter-one.public.cose_key.cbor @ 149953c` | PINNED |
| Admitter-two key | `B14` | `public-keys/admitter-two.public.cose_key.cbor @ 149953c` | PINNED |
| Operator key | `B15` | `public-keys/operator.public.cose_key.cbor @ 149953c` | PINNED |
| Non-target subjects | `B16` | prefix leaves 0, 1, 3 | PINNED |

The exact identifiers used above are:

    B01 S3-A commit
      7c3b2d4b919c356a566f8f5d3628d4f546e41afa
    B02 S3-A tag object
      8f0c97f3745131f79936dec71ebe09316332f5ab
    B03 normative capture commit
      149953c29780e566b0b23f7a1b975dc93349daf2
    B04 accepted-result commit
      5acc277a13dc122e39fcb5f9f3e646b06cc95009
    B05 accepted-result tag object
      4148a7403e8d5ed0a30ca878d617323bb3a75b3a
    B06 capture-index SHA-256
      2662c2daf912d2ce4796a26b13464d7bc2df6ba8825fa399fed3a87185d700a7
    B07 request.cbor SHA-256
      f577f382607c6956e4c724ff37e19f55581bd4c3a06e075ebb3cb0baed569c83
    B08 target Receipt SHA-256
      b1a0868ea05ceea2b9b9e5478ccc859e2117068b01b910844480872da13e9957
    B09 final checkpoint SHA-256
      81b3e19484e6e1f1b6dc5d4a553c35f8bcef7e3976ac09fbdec48f127d9aeaad
    B10 LogIdentityV0 digest
      6a510bcf3a122ae9af2714939d60a6a4e997ff9751836024dd480ebd60cd37c9
    B11 Receipt-key RFC 9679 thumbprint
      6bc5b0ae47f8726379ffbfb0e0858fe10ef74ba5b8801edeba0b3d3b89944056
    B12 volmax-owner key thumbprint
      63759d03f57a34801b4405f54c6dd9a2ab6bf47e120fa8660f548e202dbce512
    B13 admitter-one key thumbprint
      d670cdd06104880626929398bb2bfad40103801a7ba156393ef9d1cac6172f62
    B14 admitter-two key thumbprint
      43e39148af008041703b0ab2f5cd86071e94b3bc1364d319bfff9a4ea8bd9ac1
    B15 volmax-s3-operator key thumbprint
      f7cae36222deeaccc01ed6cf2508d7d5f9e7d8e323c17ab2f3a70a264620a45e
    B16 non-target subjects
      urn:volmax:s3:policy-declaration
      urn:volmax:s3:verification-material-declaration
      urn:volmax:s3:operator-note

The `intruder-x` public key was retained in the profile material but was not configured as a facade registration issuer for this execution.

## Captured Prefix and Transparency Export {#reproduction-capture}

The paths in this subsection are relative to the same accepted capture root.

| Item | Value | Source | Status |
|---|---|---|---|
| Capture index | `C01` | `capture.json @ 149953c` | PINNED |
| Prefix `[0]` | `C02` | `prefix/000000.cose @ 149953c` | PINNED |
| Prefix `[1]` | `C03` | `prefix/000001.cose @ 149953c` | PINNED |
| Prefix `[2]` | `C04` | `prefix/000002.cose @ 149953c` | PINNED |
| Prefix `[3]` | `C05` | `prefix/000003.cose @ 149953c` | PINNED |
| Prefix `[4]` | `C06` | `prefix/000004.cose @ 149953c` | PINNED |
| Prefix `[5]` | `C07` | `prefix/000005.cose @ 149953c` | PINNED |
| Prefix `[6]` | `C08` | `prefix/000006.cose @ 149953c` | PINNED |
| Prefix `[7]` | `C09` | `prefix/000007.cose @ 149953c` | PINNED |
| Tessera bundle | `C10` | `provenance/public-http-responses/tile/entries/000.p/8 @ 149953c` | RECORDED |

The exact SHA-256 values are:

    C01 capture index
      2662c2daf912d2ce4796a26b13464d7bc2df6ba8825fa399fed3a87185d700a7
    C02 prefix statement 0
      0fdf53c19413959063ad9a2a7afc6f906ff6f7aa3c65a1200c25eb6307fb0af1
    C03 prefix statement 1
      b9c37da56d55da6a68f99cc621edc396c2e50bdcd5cfbef6d6b9100c03a4edb9
    C04 prefix statement 2
      9bc7ef1d0960efaf68ce771dfce254c78f26a0ac7b390c383451821770cb2a4f
    C05 prefix statement 3
      7cd73a51bb2baaa7773cd2eaed2c99869598500f641c5d2905b316ec949979cb
    C06 prefix statement 4
      4d36d91f29883d605fe486c1e4e2e5cf1d548c9a8154d69db944510c5d8eb6a2
    C07 prefix statement 5
      75abeea5728102a286327505dba979b38e8383d95056ac1d0c72cea63daf7119
    C08 prefix statement 6
      5406abf0d14906c2b986556acb060e92af11e0d4812be42239ba99892283f491
    C09 prefix statement 7
      73273d96f81aebfa35ff2298f99198328664a1ab6bec442ba5f4ce0003f8a16e
    C10 Tessera public entry-bundle export
      555c1820a210c7cfeacbb77d0dc60a0c93fe1cb132855115a4fb834951a48e50

The Tessera entry-bundle digest is the digest of the retained transparency-log export. It is not a digest of a newly defined aggregate P10 prefix object. No additional aggregate prefix digest is introduced here.

## Accepted Replay Execution {#reproduction-accepted-run}

The accepted runner records in this subsection are under `ts-prototype/evidence/s3b-capture/runner/` at commit `5acc277`.

| Item | Value | Source | Status |
|---|---|---|---|
| Pinned inputs | `D01` | `PINNED_INPUTS.json` | PINNED |
| Entry executable | `D02` | pinned inputs / run-info | PINNED |
| G5 executable | `D03` | pinned inputs / run-info | PINNED |
| Rust toolchain | `1.82.0` | pinned inputs / preflight | PINNED |
| Lean executable | `D04` | manifests / preflight | PINNED |
| Lake executable | `D05` | S1 manifest / preflight | PINNED |
| Lean shared lib | `D06` | S1 manifest / preflight | PINNED |
| Leanchecker | `D07` | manifest / preflight; not used on chain | PINNED |
| Run-info | `D08` | `run-info.json` | RECORDED |
| Preflight | `D09` | `preflight.json` | RECORDED |
| Platform | `D10` | run-info | RECORDED |
| Python | `3.13.16` | run-info; not pinned | RECORDED |
| Network isolation | `true/{lo}` | run-info | RECORDED |
| Replay `tB` digest | `D11` | verdict | RECORDED |
| Accepted verdict | `D12` | `verdict.json`; `BINDING_MATCH` | RECORDED |

The exact identifiers used above are:

    D01 PINNED_INPUTS.json SHA-256
      3a1550f8230a70431ca8c7d4905db9d486b2ca7fc6cde1bbc66265ced7ec9912
    D02 entry executable SHA-256
      53ba44408b1de7322010681f45bb4aa576931f0974c448d9e6b7a662683ca863
    D03 G5 executable SHA-256
      a2b4b1efeda26302ec5f0710905c46f7c180ad862035959d47ba1e33305ee0bd
    D04 Lean executable SHA-256
      9842f89b9a1874db969cc58933e4117c397338f795eb8febffeb79edd5272847
    D05 Lake executable SHA-256
      8c57ee92ed8547a8508b61bce38fc14da56e2856a4ed5a574d73e8f62647d7d2
    D06 Lean shared-library SHA-256
      0df64f2384d4152ccb675b2e6b9ad4769d71c8ce168f6e2c24324df0db897c4d
    D07 Leanchecker executable SHA-256
      612915adfd75d37c27ade001eb287eebf24268b720f597f4f8ea16e9a5c55f33
    D08 accepted run-info SHA-256
      9eee4e60cf634087934c78c997139c4507d3d12aac51a91fb7e1535668aa71c1
    D09 accepted preflight SHA-256
      14ddf44f342d8fed8330619b4cb52f86dc33046ff8486be0e99a9cdc35f875d1
    D10 accepted platform
      Linux-6.18.44-fc-v80-x86_64-with-glibc2.39
    D11 replay transcript tB SHA-256
      8711346a69c601b424da736bf890cc627170c1181616d08029f08c132129d14e
    D12 accepted verdict SHA-256
      6368022f06cc6ef6e4c9698cd45e71c44db505b4bf8b5812aaf0cbe26f41db22

## HP Second-Host Reproduction {#reproduction-hp}

The historical HP records are under `packaging/offline-package/evidence/hp-replay-20261008T214835Z/`. A new replay is not used to fill any field in this subsection.

| Item | Value | Source | Status |
|---|---|---|---|
| Evidence commit | `E01` | retained HP evidence | RECORDED |
| Run-info | `E02` | `run-info.json` | RECORDED |
| Preflight | `E03` | `preflight.json` | RECORDED |
| Verdict | `E04` | `verdict.json`; `BINDING_MATCH` | RECORDED |
| Platform | `E05` | run-info | RECORDED |
| Python | `3.12.3` | run-info; not pinned | RECORDED |
| Network isolation | `true/{lo}` | run-info | RECORDED |
| Entry executable | `E06` | verdict / run-info | PINNED |
| G5 executable | `E07` | verdict / run-info | PINNED |
| Rust toolchain | `1.82.0` | preflight | PINNED |
| Lean executable | `E08` | preflight / run-info | PINNED |
| Lake executable | `E09` | preflight | PINNED |
| Lean shared lib | `E10` | preflight | PINNED |
| Leanchecker | `E11` | preflight; not used on chain | PINNED |
| Pinned-input artifact | — | absent from retained HP evidence | OPEN |
| HP `tB` digest | `E12` | `verdict.json` | RECORDED |
| HP `tB` artifact | — | absent from retained HP evidence | OPEN |

The exact identifiers used above are:

    E01 HP evidence commit
      fe6edac4bb26784d55afc2b253846854607d2a5b
    E02 HP run-info SHA-256
      4c82c728e1b9bfeedbd1c66445e8c728fae3903c7893b945b29ac3227b1d8a3b
    E03 HP preflight SHA-256
      1c3ba055f0724a77eb03859fc8728376a9e30040702004c11a45fd96f398fd9f
    E04 HP verdict SHA-256
      6368022f06cc6ef6e4c9698cd45e71c44db505b4bf8b5812aaf0cbe26f41db22
    E05 HP platform
      Linux-7.0.0-34-generic-x86_64-with-glibc2.39
    E06 HP entry executable SHA-256
      53ba44408b1de7322010681f45bb4aa576931f0974c448d9e6b7a662683ca863
    E07 HP G5 executable SHA-256
      a2b4b1efeda26302ec5f0710905c46f7c180ad862035959d47ba1e33305ee0bd
    E08 HP Lean executable SHA-256
      9842f89b9a1874db969cc58933e4117c397338f795eb8febffeb79edd5272847
    E09 HP Lake executable SHA-256
      8c57ee92ed8547a8508b61bce38fc14da56e2856a4ed5a574d73e8f62647d7d2
    E10 HP Lean shared-library SHA-256
      0df64f2384d4152ccb675b2e6b9ad4769d71c8ce168f6e2c24324df0db897c4d
    E11 HP Leanchecker executable SHA-256
      612915adfd75d37c27ade001eb287eebf24268b720f597f4f8ea16e9a5c55f33
    E12 HP-recorded tB SHA-256
      8711346a69c601b424da736bf890cc627170c1181616d08029f08c132129d14e

The retained HP `verdict.json` itself records E12. The corresponding `tB`
artifact is not retained in the HP evidence, so the digest is `RECORDED` while
the artifact remains `OPEN`. No `PINNED_INPUTS.json` file or retained digest
for that artifact was found in the standalone HP evidence or its retained
evidence archive. A later run would be a separate reproduction and would not
retroactively alter this retained record.

## Replay Workbench Reproduction {#reproduction-workbench}

The retained successful report archive is `apps/replay-workbench/evidence/hp-20261009/replay-report-20261009T225843Z-56b012c1.tar.gz`. Paths beginning with `runner/` below are relative to the archive's `replay-report/` root.

| Item | Value | Source | Status |
|---|---|---|---|
| Workbench source | `F01` | exported report | RECORDED |
| Evidence commit | `F02` | retained HP evidence | RECORDED |
| Report archive | `F03` | retained export | RECORDED |
| Member integrity | `10/PASS` | `REPORT_SHA256SUMS` | RECORDED |
| Run-info | `F04` | `runner/run-info.json` | RECORDED |
| Preflight | `F05` | `runner/preflight.json` | RECORDED |
| Verdict | `F06` | `runner/verdict.json`; `BINDING_MATCH` | RECORDED |
| Platform | `F07` | run-info | RECORDED |
| Python | `3.12.3` | run-info; not pinned | RECORDED |
| Network isolation | `true/{lo}` | run-info | RECORDED |
| Entry executable | `F08` | verdict / run-info | PINNED |
| G5 executable | `F09` | verdict / run-info | PINNED |
| Rust toolchain | `1.82.0` | preflight required check | PINNED |
| Lean executable | `F10` | preflight required check | PINNED |
| Lake executable | `F11` | preflight required check | PINNED |
| Lean shared lib | `F12` | preflight required check | PINNED |
| Leanchecker | `F13` | preflight check; not used on chain | PINNED |
| Pinned-input artifact | — | absent from report archive | OPEN |
| `tB` digest | `F14` | verdict | RECORDED |
| `tB` artifact | — | absent from report archive | OPEN |

The exact identifiers used above are:

    F01 Workbench source commit
      b264bb956c413a35750f86ac9a1d785f5a853930
    F02 Workbench evidence commit
      7f9a85c7000b31cd2af5daa15af0e7246514d516
    F03 successful report archive SHA-256
      bb97a2e3825970ac1a55d13b2f7937e3131709062875ced0b4672cfdc59b2820
    F04 Workbench run-info SHA-256
      bf1fdff9cfbacd31f5675466a8ff0726dc0c3a0ddda347834020e9882d9286dd
    F05 Workbench preflight SHA-256
      1c3ba055f0724a77eb03859fc8728376a9e30040702004c11a45fd96f398fd9f
    F06 Workbench verdict SHA-256
      6368022f06cc6ef6e4c9698cd45e71c44db505b4bf8b5812aaf0cbe26f41db22
    F07 Workbench platform
      Linux-7.0.0-34-generic-x86_64-with-glibc2.39
    F08 Workbench entry executable SHA-256
      53ba44408b1de7322010681f45bb4aa576931f0974c448d9e6b7a662683ca863
    F09 Workbench G5 executable SHA-256
      a2b4b1efeda26302ec5f0710905c46f7c180ad862035959d47ba1e33305ee0bd
    F10 Workbench Lean executable SHA-256
      9842f89b9a1874db969cc58933e4117c397338f795eb8febffeb79edd5272847
    F11 Workbench Lake executable SHA-256
      8c57ee92ed8547a8508b61bce38fc14da56e2856a4ed5a574d73e8f62647d7d2
    F12 Workbench Lean shared-library SHA-256
      0df64f2384d4152ccb675b2e6b9ad4769d71c8ce168f6e2c24324df0db897c4d
    F13 Workbench Leanchecker executable SHA-256
      612915adfd75d37c27ade001eb287eebf24268b720f597f4f8ea16e9a5c55f33
    F14 Workbench-recorded tB SHA-256
      8711346a69c601b424da736bf890cc627170c1181616d08029f08c132129d14e

E03 and F05 are intentionally identical: the Workbench export retained the
same byte-identical second-host `preflight.json` record as the HP evidence.
That JSON record contains no timestamp field. D09 belongs to the earlier cloud
execution and has a different digest.

The Workbench report records the accepted `tB` digest in its verdict, but the report archive does not retain the `tB` artifact itself. The artifact field therefore remains `OPEN`.

## Remaining Open Fields {#reproduction-open}

| Item | Value | Source | Status |
|---|---|---|---|
| HP pinned inputs | — | no file/digest in retained HP evidence | OPEN |
| HP `tB` artifact | — | digest retained in verdict; artifact absent | OPEN |
| Workbench pinned inputs | — | file absent from successful report archive | OPEN |
| Workbench `tB` artifact | — | file absent; verdict records only digest | OPEN |

These fields are intentionally not inferred from the identical `BINDING_MATCH` verdict. A newly executed replay would constitute a new reproduction record rather than retroactive evidence for the retained HP or Workbench runs.

# Relationship to Prior Work
{:numbered="false"}

The following sources were inspected directly on 2026-09-23 unless otherwise stated. The two Internet-Drafts marked 2026-09-27 were added by the v0.1.1 pre-publication prior-art sweep.

Each item in the following list is one row of the prior-art table.

- **Work / system:** **Koomullil, arXiv 2605.16407 v1** ({{KOOMULLIL}})

  **Existing coverage:** **Paper-reported (per the source snapshot):** the paper defines Supported/Contradicted/Contested/Unknown; `Unknown` is computed using thresholds `θg, θc` (§5.2). The paper-reported Universal Assurance Card has Certified/Partial/Residue/Abstain verdicts; `Abstain` requires nonempty reasons and `residue_coverage = 0` (§§10.2–10.3). Paper-reported Thm 6.3(v) claims evidence anti-monotonicity of MCR under a monotone evidence-to-constraints map.

  **What it does not cover relative to {{introduction}}:** No concrete P10 world-witness pair bound to the same closed evidence set. The inspected `MCR.lean` contains neither paper-level maximality nor an evidence anti-monotonicity theorem; those claims are therefore not attributed to the verifiable Lean artifact.

- **Work / system:** Ascendr, Inc.

  **Existing coverage:** **Company-affiliated research actor confirmed; commercial product deployment not demonstrated.**

  **What it does not cover relative to {{introduction}}:** —

- **Work / system:** **Pramāṇa (arXiv 2605.20312 v1)** ({{PRAMANA}})

  **Existing coverage:** Typed `ClaimAttestation`; `verify(claim, source)` returns VERIFIED/REJECTED/UNVERIFIABLE; a deterministic theorem prover may be an oracle for `InferenceClaim`; A2A/MCP wire extension and source-byte digest.

  **What it does not cover relative to {{introduction}}:** Does not freeze a pre-evidence world class or compatibility semantics. UNVERIFIABLE is an outcome label without a concrete divergent witness pair.

- **Work / system:** **ClaimReceipt (arXiv 2609.01992 v1)** ({{CLAIMRECEIPT}})

  **Existing coverage:** Claim sufficiency is defined over executions: identical retained evidence must imply an identical claim value (§2.1, Eq. 1). It explicitly describes the identification boundary/divergent executions, distinguishes contract and evidential abstention (`I_C`, `I_E`, §5.1), freezes the specification before implementation (§4.1), and places a signed manifest and assignment matrix with an OpenTimestamps proof before prospective ingress (§3.3). Coverage is a set property and requires manifest/ingress commitment before outcome.

  **What it does not cover relative to {{introduction}}:** P10 closure/reconciliation follows the same broad prospective-ingress/terminal-reconciliation pattern; generic coverage is not novel to P10. The narrower remainder is that ClaimReceipt does not freeze an explicit world class with executable `Compatibleπ`, nor does INCONCLUSIVE carry a concrete divergent witness pair checked by the Lean kernel and registration-order-bound to the profile/instance.

- **Work / system:** **Independent Determinability of Agent Actions (`draft-wadkins-agentproto-action-determinability-00`)** ({{WADKINS-00}}) — inspected 2026-09-27

  **Existing coverage:** Defines mechanism-independent determinability requirements for agent transitions. DET-2 requires the specific governing-condition revision to have governed the transition at decision time; prior signing or registration, or availability among multiple compatible candidates, is insufficient. Its candidates are governing-condition sets or policy revisions, not possible worlds assigning different values to an evidential claim. It also requires omission detection or an explicit result that completeness cannot be established when completeness is material.

  **What it does not cover relative to {{introduction}}:** Defines no evidence format, token, audit system, registry, or transparency service. It does not specify a pre-evidence world class with executable `Compatibleπ` and `Evalπ`, a divergent-world pair carried by a P10 Adjudication Statement, Lean certificate checking, or P10-style checkpoint-bounded evidence closure. P10 does not equate its verifier-time recomputation with Wadkins's claim that governing conditions controlled a downstream transition at decision time.

- **Work / system:** **The `verification.*` Constraint Family (`draft-krausz-verification-state-02`)** ({{KRAUSZ-02}}) — inspected 2026-09-27

  **Existing coverage:** Defines signed claim/ruleset/evidence-bound JWS receipts; `verified`, `contradicted`, `indeterminate`, and `not_evaluated` states; content-addressed evidence sets; local recomputation; immutable content-addressed mapping resolution with digest verification before use and fail-closed mismatch handling; and SCITT-compatible transport. It explicitly states that a pinned evidence set records what the issuer listed but cannot prove disclosure completeness or detect an omission.

  **What it does not cover relative to {{introduction}}:** Does not establish checkpoint-complete evidence coverage and does not require a pre-evidence committed `Wπ` with executable `Compatibleπ` and `Evalπ`, a concrete divergent-world pair, or a Lean proof that both worlds remain compatible with the same closed evidence set while assigning different claim values. P10's narrower remainder is instance-unique profile resolution plus transitive verifier-toolchain/build binding, not digest-checked ruleset resolution as such.

- **Work / system:** SCITT Agent Action Capsule (draft-mih-…-02) ({{MIH-AAC-02}})

  **Existing coverage:** SCITT receipt with disposition vocabulary

  **What it does not cover relative to {{introduction}}:** Action disposition, not epistemic underdetermination

- **Work / system:** AWS Automated Reasoning checks

  **Existing coverage:** Formal verdicts (VALID/INVALID/SATISFIABLE/IMPOSSIBLE/TRANSLATION_AMBIGUOUS)

  **What it does not cover relative to {{introduction}}:** No third-party-verifiable receipt or witness pair

- **Work / system:** Supervaluationism, version spaces, partial identification

  **Existing coverage:** “True in all admissible models” and monotone narrowing

  **What it does not cover relative to {{introduction}}:** Not receipt/binding systems

**Provenance for the Koomullil row:** the complete arXiv HTML v1 was inspected through §§1–17 and the appendices; `gkoomullil/proof-carrying-certificates` was inspected read-only at full commit `8e5b718c4fc1a53678f1da9a94499df3b311d065` (commit timestamp `2026-05-12T18:19:05Z`). `README.txt`, `lean_artifact/EmbeddingSensitivity/MCR.lean` (blob `096f15d486f7190d7018317002a3ba2d137eadab`), and `lean_artifact/EmbeddingSensitivity/AxiomAudit.lean` (blob `83899399f1157d99f06bcc611466186bf26d77b9`) were opened directly. The paper reports threshold-based `Unknown`, Theorem 6.3(v), and the `Abstain` condition. However, the inspected `MCR.lean` has no `p_maximal_over_all` field, maximality theorem, or evidence anti-monotonicity theorem; the last of its three theorems merely repeats `p_residue_cert`. This is a mismatch between paper-level claims and the inspected artifact, not artifact confirmation of those claims. `lake build` was not independently run.

**Narrow differentiation after the v0.1.1 sweep:** P10 claims no novelty for independent determinability, decision-time or pre-evidence binding as a general idea, an `indeterminate` receipt, claim/ruleset/evidence binding, content-addressed evidence, local recomputation, SCITT transport, or the need for coverage and omission controls. The remaining claimed profile-level combination is a concrete divergent-world pair from a pre-evidence committed model class, checked under executable `Compatibleπ` and `Evalπ` semantics by Lean and bound to a unique, instance-specific pre-evidence commitment whose exact profile and verifier-manifest digests are independently resolved and used by the P10 certificate verifier, with registration-order and checkpoint-bounded coverage verification.

## Prior-Art Boundary Question
{:numbered="false"}

> Do Pramāṇa, ClaimReceipt, `draft-wadkins-agentproto-action-determinability-00`, or `draft-krausz-verification-state-02` already require a pre-evidence committed model class with executable compatibility and evaluation semantics and carry a concrete divergent-world witness pair checked against the same closed evidence set?

- **Review answer: No.**
- **Pramāṇa:** its commitment is the `source_digest` of retrieved bytes used by `verify(claim, source)`; it has no pre-evidence commitment of a world class/compatibility semantics. UNVERIFIABLE carries no witness pair.
- **ClaimReceipt:** it has pre-ingress manifest/specification and coverage commitments, but no explicitly frozen `Wπ` with executable `Compatibleπ`, nor an INCONCLUSIVE receipt carrying a concrete divergent witness pair.
- **Independent Determinability of Agent Actions:** its compatible candidates are governing-condition sets or policy revisions, not claim-worlds. It supplies the general compatible-candidate principle, decision-time binding, independent retrospective evaluation, and the requirement to detect omission or report that completeness is unavailable. It deliberately defines no evidence format or transparency service and carries no concrete divergent-world witness pair under frozen executable semantics.
- **The `verification.*` Constraint Family:** it supplies a signed and recomputable claim/ruleset/evidence-bound receipt, an `indeterminate` state, content-addressed evidence, and SCITT compatibility. Its receipt cannot establish disclosure completeness or detect an omitted source, and it carries no P10 divergent-world witness proof.
- The claim therefore survives only as the narrower **profile-and-binding combination** stated in {{relationship-to-prior-work}}: concrete divergent-world witnesses from a pre-evidence committed model class, executable `Compatibleπ` and `Evalπ` checks backed by Lean, a uniquely resolved instance-specific profile and transitively bound verifier manifest, checkpoint-complete evidence coverage, and transparency-log registration-order verification. P10 verifier-time use is not a claim that the verdict governed a downstream action in Wadkins's DET-2 sense.

# Source Snapshot
{:numbered="false"}

The following sources were inspected directly on 2026-09-23, with the two identified Internet-Drafts added on 2026-09-27. The verification statements below are limited to the cited source versions and inspected artifacts.

**Primary sources opened directly (Europe/Belgrade; inspection dates stated above):**

- Koomullil, arXiv `2605.16407v1` ({{KOOMULLIL}}), complete HTML; linked GitHub repository at commit `8e5b718c4fc1a53678f1da9a94499df3b311d065`, including `README.txt`, `MCR.lean`, and `AxiomAudit.lean`.
- Pramāṇa, arXiv `2605.20312v1` ({{PRAMANA}}), complete HTML.
- ClaimReceipt, arXiv `2609.01992v1` ({{CLAIMRECEIPT}}), complete HTML.
- `draft-wadkins-agentproto-action-determinability-00` ({{WADKINS-00}}), complete Datatracker HTML, dated 2026-09-10 and last updated 2026-09-11.
- IETF Datatracker IPR disclosure 7599, submitted 2026-09-11, naming unpublished pending U.S. provisional application `US64/147765`; the submitter made no licensing declaration at that time. This is a source-reported disclosure record, not a legal conclusion by P10.
- `draft-krausz-verification-state-02` ({{KRAUSZ-02}}), complete Datatracker HTML, published 2026-09-22.
- RFC 9943 ({{RFC9943}}): §§3, 5.1.3, 6, 7, 9.1, and 9.3. Protected `sub` groups Transparent Statements and supports subject completeness checks; VDS replayability permits checking every registered structure only for an actor with content access. Registration Policy can change and is not a soundness premise. §9.1 confirms that VDS registration order need not equal issuance order; §9.3 confirms selective registration.
- RFC 9943 ({{RFC9943}}) Figure 3 defines CWT `iss` and `sub` as `tstr`, places the standard SCITT Receipt in COSE unprotected-header label `394`, binds TS identity to a public key, and leaves concrete VDS structures/proofs dependent on the selected VDS profile. P10 therefore additionally freezes `LogIdentityV0` and `LeafEncodeV0`.
- in-toto Attestation v1 README ({{IN-TOTO-V1}}) and `statement.md` ({{IN-TOTO-STATEMENT}}): Envelope/Statement/Predicate layers and the rule that a consumer ignores unknown fields unless the predicate specification says otherwise.
- IETF Datatracker important dates: IETF 127 Internet-Draft cutoff `2026-11-02 23:59 UTC`, confirmed on 2026-09-23.

**Not independently executed:** Koomullil `lake build`, all pilot experiments, and the ClaimReceipt reference verifier. Their build/test results remain primary-source self-reports. Source inspection confirms only the content of inspected files at the stated commit; specifically, it found that `MCR.lean` contains neither paper-level maximality nor an evidence anti-monotonicity theorem.

**Excluded:** existence of an automation task and any market/commercial-priority claim.

# Document History
{:numbered="false"}

`-00`: Internet-Draft transcription of P10 Underdetermination Profile v0.1.1 ({{P10-V011}}), applying ratified Erratum E01 by replacing the profile's undefined editorial notation `S_C` in the evidence-closure section with the actual issuer-signed payload fields, plus citation repairs and informative IETF framing; no other normative change. The earlier characterization of `S_C` as “obsolete notation” is corrected in `-01`; human-ratified E03 records that it was undefined editorial shorthand and introduced no additional wire field, VDS checkpoint, digest, or acceptance condition.

## v0.1.1 — 2026-09-27
{:numbered="false"}

- Added `draft-wadkins-agentproto-action-determinability-00` and `draft-krausz-verification-state-02` to the prior-art boundary.
- Restricted the novelty narrative to the concrete P10 divergent-world, executable-semantics, Lean-proof, checkpoint-coverage, and registration-order combination.
- Added explicit non-claims for the concepts anticipated by those drafts.
- Added the mandatory cross-instance selection limitation and the downstream-action non-claim.
- Added `VerifierManifestV0`, `ActiveProfileBindingV0`, and M31–M35 to bind the exact active profile, checker, build, axiom policy, dependencies, `.olean` files, and Lean toolchain transitively into verification, and to require the checker-constructed `CertificateTargetV0` proposition.
- Made no change to the mathematical definitions of `Determinateπ`, `Underdeterminedπ`, or `FormallyUnderdeterminationCapable`, to evidence-closure semantics, or to existing tests M1–M30 and AP1.

# Acknowledgments
{:numbered="false"}

AI-assisted tools supported source comparison, transcription checks, build validation, and adversarial review.

The author reviewed and ratified the substantive decisions represented in this document and remains responsible for its content and errors.
