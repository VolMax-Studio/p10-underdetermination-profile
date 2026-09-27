# Draft Brief — draft-nestorov-scitt-p10-underdetermination-00

## 1. Source pin

| Item | Value |
|---|---|
| Source of record | `P10_Underdetermination_Profile_v0.1.1.md` |
| SHA-256 | `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558` |
| Tag / commit | `v0.1.1` (tag object `caa53b854367cf1253e431246e725dcd88570e9b`) → `e2a02a73df9e50f624512043dcb007fc337ba587` |
| Zenodo | version DOI `10.5281/zenodo.22994744`, concept DOI `10.5281/zenodo.22994743` |
| Errata applied | E01 (v0.1.1 line 284 receipt-binding fields: obsolete notation `S_C` replaced with actual fields) |
| I-D cutoff | 2026-11-02 23:59 UTC (IETF 127) |

The draft is a transcription. It MUST NOT change the obligations of v0.1.1. Anything the draft needs that v0.1.1 lacks is either a listed decision (D-series) or flagged `NEW-PROSE` in `TRACEABILITY.md`.

## 2. Transcription rules

1. Every BCP 14 keyword in the draft traces to a Table 1 row (17 rows; boilerplate exempted as X01) with the same keyword. Unmatched keyword = gate finding.
2. Every Table 2 word stays lowercase (16 rows, including compounds such as "must-understand").
3. The two mandatory limitation blocks (AP1; coverage/instance) are receipt content bound by `limitations_digest`. Copy them byte-for-byte.
4. Descriptions of other people's work (prior-art table, §7.3) are copied from v0.1.1, not re-paraphrased.
5. Only allowed rewrites: Markdown → kramdown syntax, section cross-references (`§2.4` → `{{full-prefix-replay}}`), and reference anchors. Each rewritten cross-reference is checked to point at the transcribed counterpart of the original target.
6. Section omissions are exactly those in Table 4: §7.4 and §9 (process), plus the "Hard deadline" header line.
7. No Lean implementation source, JSON fixture, or executable repository code is copied into the draft (D9). Formal definitions stay as specification notation; implementation artifacts are referenced by DOI, commit and SHA256SUMS.
8. Every sentence without a v0.1.1 source is registered in Table 5 (NEW-PROSE) and carries no BCP 14 keyword.

## 3. Decisions

| ID | Status | Record |
|---|---|---|
| D1 | RATIFIED by Ivan, 2026-09-27 (session message) | NO — To the best of the author's current knowledge, no filed patent or patent application controlled by the author or VolMax covers implementation of this contribution. BCP 79 / RFC 8179 concerns IPR the contributor reasonably and personally knows of; no new patent search is required. Planned-but-unfiled applications are a separate patent-strategy question, not a BCP 79 disclosure. |
| D2 | RATIFIED by Ivan, 2026-09-27 (session message) | Informational |
| D3 | RATIFIED by Ivan, 2026-09-27 (session message) | "This document has no IANA actions." |
| D4 | RATIFIED by Ivan, 2026-09-27 (session message) | Short informative Privacy Considerations, registered as NEW-PROSE (Table 5), no BCP 14 keywords |
| D5 | RATIFIED by Ivan, 2026-09-27 (session message) | Ivan Nestorov; VolMax Studio Lab d.o.o.; volmax.core@gmail.com; ORCID 0009-0006-7940-9539. Organization "VolMax Studio Lab d.o.o." explicitly confirmed. |
| D6 | RATIFIED by Ivan, 2026-09-27 (session message) | SCITT primary venue; notify agentproto after submission |
| D7 | RATIFIED by Ivan, 2026-09-27 (session message) | Cite exactly the reviewed versions (Wadkins -00, Krausz -02, AAC -02) as frozen manual references; do not attribute AAC -04 to v0.1.1 without a separate review |
| D8 | RATIFIED by Ivan, 2026-09-27 (session message) | Brief acknowledgment of human reviewers and AI-assisted tooling; no AI named as author |
| D9 | RATIFIED by Ivan, 2026-09-27 (session message) | Statement: "No Lean implementation source, JSON fixture, or executable repository code is copied into the draft. Formal definitions are specification notation. Reference implementation artifacts remain externally referenced." |
| D10 | RATIFIED by Ivan, 2026-09-27 (session message) | §2.1 mathematical definitions retained byte-identical with unicode symbols in sourcecode block; idnits non-ASCII warning accepted as known for -00. Terminology only names symbols and points to sections. |
| D11 | RATIFIED by Ivan, 2026-09-27 (session message) | §2.2 formal blocks line-broken using whitespace changes for RFC width margin (<= 72 columns); non-trivial token sequence preserved. |
| D12 | RATIFIED by Ivan, 2026-09-27 (session message) | Internal section references removed from sourcecode blocks; dynamic anchors provided via a single sentence (P13) following the summary block. |

## 3.1 Errata against v0.1.1

| ID | Status | Location | Original text | Corrected text | Rationale |
|---|---|---|---|---|---|
| E01 | RATIFIED by Ivan, 2026-09-27 (session message) | §2.6, line 284 | "To avoid a post-registration hash cycle, the issuer-signed payload binds `S_C`, ordered references, and the pre-closure transcript. The outer SCITT Receipt supplies `S_R`; `S_R`, the final replay transcript, and the coverage-verification result are not fields in the issuer-signed payload. Full-prefix replay occurs after receipt acquisition." | "To avoid a post-registration hash cycle, the issuer-signed P10 payload binds `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`. The outer SCITT Receipt ({{RFC9942}}) supplies `S_R`; `S_R`, the final replay transcript, and the coverage-verification result are not fields in the issuer-signed payload. Full-prefix replay occurs after receipt acquisition." | Obsolete r2.3 notation `S_C` was removed from the final profile architecture and replaced with `evidence_closure_ref`, `evidence_admission_refs`, and `preclosure_transcript_digest`. The sentence in §2.6 was an unupdated editorial leftover in v0.1.1. Corrected in draft-00 without changing formal Lean verification or FourWorld proof. Binds normative reference {{RFC9942}}. |

## 4. Reference checks

| ID | Status | Check |
|---|---|---|
| R1 | CLOSED | RFC 9942 registers COSE header parameter 394 (`receipts`). |
| R2 | OPEN (list for gate) | RFC 8392 added as a reference; v0.1.1 reaches `iss`/`sub` via RFC 9943 Figure 3. |
| R2a | ADDED (list for gate) | RFC 9597 (CWT Claims in COSE headers) added as normative: RFC 8392 defines the claims, RFC 9597 their carriage in the protected header. |
| R3 | CLOSED | in-toto Statement v1 spec pinned to commit 06eafe3635bf8a425ad52cc82c6c90861e94a471 (2024-05-06, spec/v1/statement.md). |
| R4 | CLOSED | Internet-Drafts are frozen manual references with ietf.org/archive URLs: Wadkins -00 (2026-09-10, D. Wadkins, Strakewright), Krausz -02 (2026-09-22, J. Krausz, TK Collective LLC), Mih AAC -02 (2026-07-06, S. Mih, Action State Group, Inc.). No `I-D.<name>` auto-references remain. |
| R5 | CLOSED | "Pramana: A Protocol-Layer Treatment of Claim Verification in Autonomous Agent Networks", Ravi Kiran Kadaboina, arXiv:2605.20312v1 (submitted 2026-05-19). |
| R6 | CLOSED | Leonardo de Moura and Sebastian Ullrich, "The Lean 4 Theorem Prover and Programming Language", In: Automated Deduction – CADE 28, LNCS 12699, pp. 625–635, Springer, Cham, 2021, DOI 10.1007/978-3-030-79876-5_37. |
| R7 | OPEN (list for gate) | Gate verifies every identity field in manual references (full names, arXiv dates/identifiers, in-toto commit date) against upstream records. |

## 5. Pipeline

1. Transcribe section by section; update `TRACEABILITY.md` status to `TRANSCRIBED` with draft location.
2. `kdrfc` → XML → `xml2rfc` → `idnits` with zero errors.
3. Independent gate over the exact draft SHA-256 and the filled matrix. Gate checks: every Table 1/3 row matched, Table 2 lowercase preserved, limitation blocks byte-identical, omissions only as in Table 4, all NEW-PROSE listed in Table 5, no `I-D.<name>` auto-reference in the source.
4. Ivan ratifies.
5. Upload via Datatracker; announcement per D6.

Target: submission by 2026-10-25, one week before cutoff.

### Skeleton-build toolchain

The reproducible skeleton build uses `kramdown-rfc2629` 1.7.43 (`kdrfc`),
`xml2rfc` 3.34.1, `idnits` 2.17.1, and Ruby 3.2.3. The checked-in
`scripts/build_draft.sh` prints the actual versions before every build.

## 6. Observation (no action proposed)

The `README.md` at tag `v0.1.1` still says "Version 0.1.1 is a release candidate … Release status remains a separate human decision." The Zenodo record now exists. The tagged file cannot change; if it matters, a later release can update the README. The draft does not quote the README's status line.
