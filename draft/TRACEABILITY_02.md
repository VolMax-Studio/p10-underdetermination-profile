# Traceability Matrix — `draft-nestorov-scitt-p10-underdetermination-02`

**Status:** LOCAL CANDIDATE / NOT RATIFIED / NOT SUBMITTED.

**Baseline:** `-01` at repository commit `ceda29c4fdd268b58f1842905ca52ca0324bd3f7`.

## Global invariant

For every `-02` change:

> **Changed P10 profile semantics? NO**

A required `YES` is a STOP condition and must be handled as a separate profile revision, not silently absorbed into this Internet-Draft update.

## Delta matrix

| ID | `-01` state | `-02` candidate treatment | Class | Semantics changed? |
|---|---|---|---|---|
| D02-01 | `docname ...-01` | advance document revision to `...-02` | I-D REVISION | NO |
| D02-02 | `draft-krausz-verification-state-02` | cite and describe current `-03` revision | PRIOR-ART UPDATE | NO |
| D02-03 | Agent Action Capsule `-02` | cite current `-05` and replace the old terse comparison with a bounded current description | PRIOR-ART UPDATE | NO |
| D02-04 | no CLL row | add `draft-mih-scitt-checkpointed-local-log-02` and its payload-neutral order/completeness boundary | NEW INFORMATIVE PRIOR ART | NO |
| D02-05 | no Decision Provenance row | add `draft-lemonnier-scitt-decision-provenance-00` and distinguish decision provenance from claim underdetermination | NEW INFORMATIVE PRIOR ART | NO |
| D02-06 | no CIRIS CEG row | add `draft-moore-scitt-ciris-ceg-00` and distinguish signed claim grammar from P10 divergent-world proof | NEW INFORMATIVE PRIOR ART | NO |
| D02-07 | package-level work not explicitly separated | add one Non-Claims bullet separating package `formal_binding` / rule re-execution from `ActiveProfileBindingV0` | SCOPE CLARIFICATION | NO |
| D02-08 | source snapshot ends with 2026-09 sweep | record focused 2026-10-30 IETF sweep and exact revisions | SOURCE PROVENANCE | NO |
| D02-09 | history ends at `-01` | add `-02` history entry with explicit semantic ceiling | DOCUMENT HISTORY | NO |

## Normative-preservation evidence

Source-level byte comparisons returned:

```text
formal-core-through-statement: BYTE_IDENTICAL
security-through-conformance: BYTE_IDENTICAL
executed-and-reproduction: BYTE_IDENTICAL
```

The compared regions include the mathematical/profile core, issuance conditions, instance commitment, replay, evidence admission/closure, canonical encoding, statement structure, security/privacy/IANA sections, conformance tests M1-M35/AP1, executed-instance appendix, and reproduction/artifact pins.

## Source-version pins for this revision

| Source | Revision/date used |
|---|---|
| `verification.*` | `draft-krausz-verification-state-03`, 2026-10-01 |
| Agent Action Capsule | `draft-mih-scitt-agent-action-capsule-05`, 2026-09-26 |
| Checkpointed Local Log | `draft-mih-scitt-checkpointed-local-log-02`, 2026-10-13 |
| Decision Provenance for SCITT | `draft-lemonnier-scitt-decision-provenance-00`, 2026-10-26 |
| CIRIS CEG / SCITT | `draft-moore-scitt-ciris-ceg-00`, 2026-10-21 |

## Explicitly excluded from `-02`

- no import of `p10-adjudication-package` ContractV1/PackageViewV1 semantics;
- no new package axis or disposition rule;
- no rule-reexecution wire or result semantics;
- no OPEN-2 authentication changes;
- no OPEN-6B semantics;
- no change to the underdetermination witness theorem, Lean target, or profile acceptance predicates;
- no new claim of production SCITT conformance or independent third-party reproduction.
