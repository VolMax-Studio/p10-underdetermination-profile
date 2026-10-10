# Receipt Occurrence Reconciliation — draft-01

**Status:** CANDIDATE / MACHINE-RECONCILED, TERMINOLOGY GATE COMPLETE.

- Source: `P10_Underdetermination_Profile_v0.1.1.md`
- Source SHA-256: `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`
- Raw occurrence inventory: `draft/RECEIPT_OCCURRENCES_01.tsv`
- Raw occurrence TSV SHA-256: `354b3d7856028e894ed39c7c3391cd3355de72c3e79b78cd59f907fcb479eac4`
- Exact case-insensitive substring occurrences: **56**
- Ambiguous classifications in this candidate: **0**

## Reconciliation finding

The initial hand-built R01–R45 matrix did not enumerate every raw `receipt` substring occurrence separately. The machine scan found 56. The 11 additional raw occurrences are external/prior-art terminology or proper-name occurrences and do not create additional P10 terminology edits.

Previously non-enumerated raw occurrences:

`M22`, `M23`, `M31`, `M36`, `M49`, `M50`, `M51`, `M52`, `M53`, `M54`, `M56`

Former R40 corresponds to machine occurrence `M44`. It is classified as `SCITT_RECEIPT_OR_REPLAY_INPUT`: the mutation checks the transparency-log identity used by the SCITT Receipt/replay path, not the P10 adjudication object. It therefore MUST NOT be renamed to `P10 Adjudication Statement`.

## Classification counts

- `EXTERNAL_OR_PRIOR_ART`: 20
- `IDENTIFIER_OR_FIELD`: 3
- `P10_OBJECT`: 21
- `SCITT_RECEIPT`: 10
- `SCITT_RECEIPT_OR_IDENTIFIER`: 1
- `SCITT_RECEIPT_OR_REPLAY_INPUT`: 1

## Treatment counts

- `CLARIFY_AS_SCITT_RECEIPT_REFERENCE`: 1
- `CLARIFY_ONLY_NO_P10_RENAME`: 1
- `PRESERVE_FROZEN_V0_1_LITERAL`: 2
- `PRESERVE_EXTERNAL_TERM`: 20
- `PRESERVE_IDENTIFIER`: 3
- `PRESERVE_SCITT_RECEIPT`: 10
- `RENAME_TO_P10_ADJUDICATION_TERM`: 19

## Frozen limitation-byte compatibility decision — RESOLVED

M13 and M14 are P10-object terminology occurrences, but both occur inside the mandatory `COVERAGE_INSTANCE` limitation value whose exact bytes are frozen by `StatementPayloadSchemaV0` r9.

Compatibility pins:

- S2b public implementation pin: commit `8e89f9a4192bdd0ab280556701dc595eb55539d2`
- frozen schema SHA-256: `7fc847ea66114f87b22e79b5c93f55d80d3e92923b613a9ad8efee17df92a455`
- canonical `limitations` length: **5718 bytes**
- `SHA-256(JCS(limitations))`: `7c9252664b112621087d0a74b3f8fd5ec50f9ed912cc0d1a611bc227d3d15214`
- the S2b implementation requires byte-exact `JCS(limitations) == LIMITATIONS_JCS` and exact `limitations_digest` equality.

Decision for draft `-01`:

- preserve the literal word `receipt` at M13 and M14 inside the frozen P10 v0.1 limitation value;
- classify both treatments as `PRESERVE_FROZEN_V0_1_LITERAL`;
- use `P10 Adjudication Statement` in descriptive prose outside that frozen constant;
- the retained legacy word `receipt` in these two strings denotes the P10 adjudication object, not a SCITT Receipt;
- `Changed semantics? = NO`.

This resolves the byte-compatibility HOLD without changing frozen wire bytes, the limitations digest, or profile semantics.

## Exact occurrence matrix

| ID | Source | Match | Classification | Candidate treatment |
|---|---:|---|---|---|
| M01 | L17:C11 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M02 | L128:C151 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M03 | L136:C91 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M04 | L193:C216 | `receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M05 | L209:C172 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M06 | L275:C3 | `receipt` | `IDENTIFIER_OR_FIELD` | `PRESERVE_IDENTIFIER` |
| M07 | L281:C7 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M08 | L282:C151 | `Receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M09 | L282:C325 | `receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M10 | L286:C190 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M11 | L312:C46 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M12 | L316:C60 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M13 | L318:C8 | `receipt` | `P10_OBJECT` | `PRESERVE_FROZEN_V0_1_LITERAL` |
| M14 | L318:C713 | `receipt` | `P10_OBJECT` | `PRESERVE_FROZEN_V0_1_LITERAL` |
| M15 | L324:C44 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M16 | L355:C1 | `receipt` | `IDENTIFIER_OR_FIELD` | `PRESERVE_IDENTIFIER` |
| M17 | L355:C49 | `Receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M18 | L356:C72 | `receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M19 | L361:C246 | `Receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M20 | L365:C177 | `Receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M21 | L365:C509 | `Receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M22 | L378:C10 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M23 | L378:C748 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M24 | L379:C866 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M25 | L380:C158 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M26 | L381:C55 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M27 | L382:C141 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M28 | L383:C124 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M29 | L387:C183 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M30 | L394:C12 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M31 | L405:C91 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M32 | L406:C27 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M33 | L407:C64 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M34 | L408:C44 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M35 | L409:C43 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M36 | L410:C92 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M37 | L411:C50 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M38 | L423:C254 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M39 | L426:C8 | `Receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M40 | L432:C109 | `Receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M41 | L433:C9 | `Receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M42 | L437:C32 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M43 | L447:C67 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M44 | L448:C9 | `Receipt` | `SCITT_RECEIPT_OR_REPLAY_INPUT` | `CLARIFY_ONLY_NO_P10_RENAME` |
| M45 | L451:C51 | `receipt` | `SCITT_RECEIPT_OR_IDENTIFIER` | `CLARIFY_AS_SCITT_RECEIPT_REFERENCE` |
| M46 | L456:C10 | `receipt` | `IDENTIFIER_OR_FIELD` | `PRESERVE_IDENTIFIER` |
| M47 | L462:C245 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M48 | L462:C390 | `receipt` | `P10_OBJECT` | `RENAME_TO_P10_ADJUDICATION_TERM` |
| M49 | L468:C20 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M50 | L472:C10 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M51 | L472:C170 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M52 | L474:C114 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M53 | L474:C206 | `receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M54 | L490:C8 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |
| M55 | L495:C86 | `Receipt` | `SCITT_RECEIPT` | `PRESERVE_SCITT_RECEIPT` |
| M56 | L499:C93 | `Receipt` | `EXTERNAL_OR_PRIOR_ART` | `PRESERVE_EXTERNAL_TERM` |

## Gate state

- Machine source scan complete: **YES**
- Exact 56/56 occurrence classification present: **YES**
- `AMBIGUOUS` occurrence classification: **0**
- Former R40 semantic ambiguity resolved: **YES, candidate review**
- Identifier renames authorized: **NO — preserve by default**
- Mandatory limitation-byte wording resolved: **YES — M13/M14 preserve the frozen P10 v0.1 literal**
- Occurrence-level terminology treatment complete: **YES — 56/56, 0 ambiguous, 0 unresolved terminology occurrences**
- Terminology edits to `-01` authorized by this file alone: **NO**
