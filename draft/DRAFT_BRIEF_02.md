# Draft Brief — `draft-nestorov-scitt-p10-underdetermination-02`

**Status:** LOCAL CANDIDATE PREPARATION ONLY. Not ratified, not pushed, not submitted to the IETF.

**Prepared:** 2026-10-30

## 1. Purpose

`-02` is a bounded pre-IETF-127 prior-art and scope-boundary revision of the submitted `-01` draft. It does **not** amend the P10 underdetermination profile semantics.

The revision has three goals:

1. update cited IETF work to current revisions where the `-01` reference is stale;
2. add newly published SCITT work that materially narrows the surrounding prior-art boundary; and
3. make explicit that separate P10 package-level formal-binding and rule-re-execution work is outside this underdetermination profile.

## 2. Submission timing

- Current public revision: `draft-nestorov-scitt-p10-underdetermination-01`, published 2026-10-11.
- IETF-127 Internet-Draft submission cutoff: **2026-11-02 23:59 UTC**.
- This candidate MUST NOT be submitted before a final semantic/citation review and explicit human publication authorization.

## 3. Exact baseline

- Repository: `VolMax-Studio/p10-underdetermination-profile`
- Baseline commit: `ceda29c4fdd268b58f1842905ca52ca0324bd3f7`
- Baseline tree: `6a6f455659324090b9b792420210a56fcadb5c39`
- Baseline file: `draft/draft-nestorov-scitt-p10-underdetermination-01.md`
- Candidate branch: `draft/p10-underdetermination-02-candidate`

## 4. Allowed delta

Allowed changes are informative/editorial only:

- document revision identifier `-01` -> `-02`;
- current `verification.*` reference `-02` -> `-03`;
- current Agent Action Capsule reference `-02` -> `-05`;
- add `draft-mih-scitt-checkpointed-local-log-02`;
- add `draft-lemonnier-scitt-decision-provenance-00`;
- add `draft-moore-scitt-ciris-ceg-00`;
- update the informative prior-art rows and source snapshot;
- add one explicit non-claim separating this profile from later P10 package-layer formal-binding/rule-re-execution work;
- add the `-02` document-history record.

Any change to the Formal Core, wire fields, evidence closure, S1/S2a/S2b/S3 acceptance conditions, security/conformance semantics, or M1-M35/AP1 is a STOP condition.

## 5. Normative-preservation guard

Direct source comparison between `-01` and the `-02` candidate established:

- `# Formal Core` through `# Implementation Status`: **BYTE_IDENTICAL**;
- `# Security Considerations` through `# Executed P10-over-SCITT Instance`: **BYTE_IDENTICAL**;
- `# Executed P10-over-SCITT Instance` through `# Relationship to Prior Work`: **BYTE_IDENTICAL**.

Therefore the candidate does not alter the profile core, wire/verification semantics, conformance tests, or retained execution/reproduction evidence.

## 6. Post-`-01` IETF sources

Inspected on 2026-10-30:

- `draft-krausz-verification-state-03` — current `verification.*` revision;
- `draft-mih-scitt-agent-action-capsule-05` — current Agent Action Capsule revision;
- `draft-mih-scitt-checkpointed-local-log-02` — ordered/completeness commitments over a producer-operated local log with SCITT-registered checkpoints;
- `draft-lemonnier-scitt-decision-provenance-00` — decision records and action-binding provenance;
- `draft-moore-scitt-ciris-ceg-00` — signed canonical claim rows and admission semantics with an explicit SCITT relationship.

These sources strengthen adjacent SCITT capabilities but do not, in the inspected revisions, require the concrete P10 divergent-world pair under a pre-evidence committed executable model class.

Gate precision review on the first `-02` candidate additionally required two editorial clarifications: the `verification.*` row now names its `indeterminate` / `divergence` reason-code boundary explicitly, and the Decision Provenance row now distinguishes issuer-asserted authority/presented-material fields from independently verified facts. Neither change alters the P10 profile semantics.

## 7. Package-layer boundary

Separate P10 research has since developed package-level formal-binding and rule-re-execution contracts. Those mechanisms are deliberately **not imported** into this Internet-Draft revision.

The `-02` candidate adds only a non-claim clarifying that `ActiveProfileBindingV0` in this profile is the verifier-time binding of the underdetermination profile, verifier manifest, and certificate target. It is not the separate package-level `formal_binding` axis and carries no package-level rule-re-execution semantics.

## 8. Build and lint

Executed locally on the candidate:

```text
kdrfc -x draft-nestorov-scitt-p10-underdetermination-02.md
xml2rfc draft-nestorov-scitt-p10-underdetermination-02.xml --text
idnits draft-nestorov-scitt-p10-underdetermination-02.txt
```

Result:

```text
xml2rfc: generated TXT successfully
idnits: 0 errors, 0 flaws, 1 warning, 11 comments
```

The warning is the existing non-ASCII-character warning for mathematical/profile notation. Local `idnits` could not retrieve online draft/RFC state during its run; the new Internet-Draft names were separately verified against the IETF Datatracker.

## 9. Publication gate

Before submission:

- [ ] independent cold read of the exact `-02` Markdown/TXT;
- [ ] confirm all five post-`-01` IETF source characterizations against exact cited revisions;
- [ ] rerun render and idnits from a clean checkout;
- [ ] verify SHA-256 manifest;
- [ ] human review/ratification of the exact candidate bytes;
- [ ] explicit human authorization to submit `-02` through the IETF submission tool.

No submission authority is created by this brief or by the candidate commit.
