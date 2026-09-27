# P10 Lean v0.2.0 — Independent Execution and Axiom-Audit Gate Report

**Gatekeeper:** Claude (Anthropic), read-only independent gate. No candidate byte was modified; tamper tests ran only on disposable copies.
**Review date:** 2026-09-27
**Commit:** `864f069179726f75424eb58d7555a66fa07faa7d` · **Tree:** `a96ba6cc35867e410c0395c5f435fb4caf448dbb`
**VerifierManifestV0 SHA-256:** `892b4c25ef569e93f0404bcbf5a621748f2f5b5319bc70cce6138ba8298e0ec3`
**Target profile SHA-256:** `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`

## 1. Custody

| Check | Result |
|---|---|
| 1. `sha256sum -c P10_LEAN_EXECUTION_GATE_SHA256SUMS` | OK, 10/10. Manifest `8eb3a99f…6c16`; ZIP `b2fe37d1…7b80`; loose request identical to the one in the ZIP. |
| 2. Archive = commit | `git get-tar-commit-id` on the archive returns `864f069…faa7d`. **The git tree hash was recomputed independently from the extracted archive (`git add -A; git write-tree`) and equals `a96ba6cc…8dbb`.** All 24 entries of `P10_LEAN_SOURCE_SHA256SUMS` pass. |
| 3. Parent `8ff00a55…8649` | **Not independently verified.** The repository is private and no commit object was supplied; the parent appears only in `P10_LEAN_COMMIT_METADATA.txt`, which is custody evidence, not proof. |
| 4. GitHub signature / key `SHA256:5aVc…2TLw` | **Not independently verified**, for the same reason. Ivan can confirm with `git verify-commit 864f069` against his `allowed_signers`, checking the principal and fingerprint rather than only "Good signature". |
| 5. Diff scope 8ff00a55 → 864f069 | The 12 changed files are all under `lean/`, `scripts/`, and `tests/`: target binding, negative test, audit and acceptance strengthening, Lean README, and the derived source, `.olean`, and verifier manifests. No out-of-scope file changed. |
| 6. Profile and reports | Profile `b92c0d68…6558`, final-patch report `5cb7d535…cb8a`, and full report `98c7d947…8480` confirmed. Both reports are byte-identical to the files this gatekeeper issued. |

## 2. Environment and commands

- **Toolchain.** `release.lean-lang.org` was not reachable from the gate sandbox, so the toolchain was installed from the official GitHub release asset `lean-4.34.0-linux.tar.zst` (SHA-256 `caaa98356098c85dc0fcbbd28e1ec66f39eb6551829972b752ff20e1286b646b`) and linked in elan 4.2.4 as `leanprover/lean4:v4.34.0`.
- **Versions.**
  - Lean: `Lean (version 4.34.0, x86_64-unknown-linux-gnu, commit 293d5d0c0c3f3dded4688b3ccd6a33939ac5102b, Release)`
  - Lake: `Lake version 5.0.0-src+293d5d0 (Lean version 4.34.0)`
  - `lean-toolchain`: `leanprover/lean4:v4.34.0`
- **Lean executable** (`elan which lean`): SHA-256 `e8baaa71855a616dc351028f3ad2200051b0671f423a1696a100e809302d5550`. This equals the manifest's `lean_toolchain_artifact_digest`. The executable was obtained independently of the implementer's machine.

| Command (fresh extraction each time) | Exit |
|---|---|
| Run 1: `./scripts/check-lean.sh` (includes `lake build --wfail`) | **0** |
| Run 2 (second fresh extraction): `./scripts/check-lean.sh` | **0** |
| `lake env lean lean/P10/AxiomAudit.lean` | 0 |
| `lake env lean tests/negative/WeakerTarget.lean` | 1 (expected) |

## 3. Axiom audit (14/14)

All 14 `#print axioms` commands report "does not depend on any axioms". Counted independently: 14 of 14 output lines.

- `P10.underdetermined_of_witnesses`
- `P10.CertificateTargetV0`
- `P10.certificateTargetV0_of_witnesses`
- `P10.worlds_distinct_of_values_differ`
- `P10.encodings_distinct_of_values_differ`
- `P10.not_underdetermined_of_constant_eval`
- `P10.WitnessCertificate.sound`
- `P10.Fixtures.FourWorld.underdetermined`
- `P10.Fixtures.FourWorld.rejects_incompatible_world`
- `P10.Fixtures.FourWorld.rejects_duplicate_world`
- `P10.Fixtures.FourWorld.determining_compatible_eval_false`
- `P10.Fixtures.FourWorld.determining_evidence_not_underdetermined`
- `P10.Fixtures.FourWorld.no_certificate_for_determining_evidence`
- `P10.Fixtures.FourWorld.canonical_witnesses_distinct`

## 4. Forbidden scan

An independent whole-word scan of every `*.lean` file for `sorry`, `admit`, `sorryAx`, `native_decide`, `Lean.ofReduceBool`, `axiom`, `unsafe`, `implemented_by`, `extern`, `opaque`, and `decide` found **no hits**. Imports are internal `P10.*` only, with no Mathlib and no Track-A module.

## 5. `CertificateTargetV0` and fixtures

- **Target.** `CertificateTargetV0 profile evidence claim world₀ world₁ := Compatible profile evidence world₀ ∧ Compatible profile evidence world₁ ∧ Eval profile claim world₀ ≠ Eval profile claim world₁`. Membership in `Eπ` and `Wπ` is carried by the dependent types `profile.Evidence` and `profile.World`. **Confirmed.**
- **Certificate.** `WitnessCertificate (profile) (evidence) (claim)` is indexed by the resolved inputs. It carries `world₀`, `world₁`, and `proof : CertificateTargetV0 profile evidence claim world₀ world₁`. It has no field through which it could choose a proposition. **Confirmed.**
- **Fixture boundaries** (all compile under `--wfail` and are axiom-free):
  1. The positive divergent certificate (`w00`, `w01` under evidence `⟨false, none⟩`) yields `Underdetermined`.
  2. `rejects_incompatible_world`: `w10` violates the evidence.
  3. `rejects_duplicate_world`: a same-world pair cannot differ.
  4. `determining_evidence_not_underdetermined` and `no_certificate_for_determining_evidence`: issuance is impossible under determining evidence.
  5. `canonical_witnesses_distinct`: accepted witness encodings differ.
- **Negative mutation.** `WeakerTarget.lean` fails with **exactly two** errors, both `Type mismatch`:
  - line 12: `WeakerTarget` against the checker target;
  - line 13: `WitnessCertificate … evidence …` against `… determiningEvidence …`.

  No import, syntax, path, or toolchain error occurred.

## 6. VerifierManifestV0

- The script verifies every required field:
  - `lean_toolchain_identifier` and `lean_toolchain_artifact_digest`;
  - `checker_source_tree_digest`;
  - `dependency_lock_digest`;
  - `build_manifest_digest`;
  - every entry of `checker_olean_digest_set`;
  - `axiom_policy_digest` and `acceptance_command_digest`;
  - `profile_specification_digest = sha256:b92c0d68…6558`.
- **Fail-closed tamper tests** (disposable copies; every one exits 1 with the specific error):

| Tamper | Script error |
|---|---|
| `axiom_policy_digest` altered | `axiom_policy_digest mismatch` |
| `profile_specification_digest` altered | `final profile specification digest mismatch` |
| One `.olean` digest entry altered | `.olean digest set mismatch` |
| `lean_toolchain_artifact_digest` altered | `Lean toolchain artifact mismatch` |
| One byte appended to `Core.lean` | source manifest `FAILED` |
| One proof replaced by `sorry` | `placeholder proof found` |

- **Reproducibility.** Two independent clean builds in the gate sandbox produced identical `.olean` digests, and both equal the recorded manifest set. The build was therefore reproduced across machines, not only across checkouts.
  - `P10.olean` `0a451f50…`
  - `AxiomAudit.olean` `02554626…`
  - `Core.olean` `88aef0b4…`
  - `FourWorld.olean` `916d7c56…`
  - `Issuance.olean` `79aa10dc…`

## 7. Track-A boundary

- No Track-A module is imported.
- `lean/README.md` states the following explicitly:
  - this is a profile-level checker, not a Track-A Core v0.4 amendment;
  - Track-A `NOT_DEMONSTRATED` must not be reinterpreted as P10 underdetermination;
  - the checker is sound but not complete, so absence of a certificate does not establish determinacy;
  - future transport should reuse or extend the existing Track-A MCP adapter.
- No adapter is included. **Confirmed.**

## 8. Blockers

None.

## 9. Non-blocking findings

- **L1 — Negative-test acceptance logic.** `check-lean.sh` requires only that the file fail and that "type mismatch" appear at least once. If one of the two checks regressed, the script would still pass. Today this is mitigated because `WeakerTarget.lean` is hash-locked in the source manifest. The script should nevertheless assert exactly two `Type mismatch` errors at lines 12 and 13.
- **L2 — One-directional `.olean` set check.** The script confirms that each built `.olean` appears in the manifest, but not that the manifest lists no extra entries. Compare the sets for equality.
- **L3 — Manifest self-binding is external.** The script checks the fields inside `VerifierManifestV0.json`, but a consistent rewrite of the manifest together with its sums files would pass. The binding to `892b4c25…0ec3` is enforced only through `profile.verifier_manifest_digest` at the receipt layer, which is out of scope. An optional `--expect-manifest <sha256>` argument would close this locally.
- **L4 — Profile digest is string-bound.** The tree at this commit contains the v0.1.0 profile and its gate report, not the v0.1.1 artifact. The script checks that the digest *string* `b92c…` is present; it cannot hash a local copy. Acceptable for this scope; note it for the integration gate.
- **L5 — Kernel scope versus specification.**
  - `Profile.compatible` is Prop-valued, so executability is not enforced by type; there is no `Decidable` requirement.
  - The codec proves `decode ∘ encode = id` and injectivity, but not the non-canonical-string rejection (`encode (decode b) = b`) required by spec §2.7.
  - The `Determinateπ` / `FormallyUnderdeterminationCapable` preflight is not formalized; the fixture's determining-evidence theorems only illustrate it.

  All three are outside this gate's stated minimal-kernel scope and should be covered before a receipt-verifier gate.

## 10. Limitations of this verdict

- It covers only the minimal witness kernel, the fixture, the target binding, the negative mutation, the axiom audit, and the manifest build binding.
- It does not cover a receipt verifier, SCITT, digest implementation, MCP adapter, hosted service, or any Track-A action.
- Commit parent and GitHub signature status (custody checks 3–4) are unverified by this gate.

## 11. Verdict

**PASS** — bound exclusively to:
- commit `864f069179726f75424eb58d7555a66fa07faa7d`
- tree `a96ba6cc35867e410c0395c5f435fb4caf448dbb`
- VerifierManifestV0 `892b4c25ef569e93f0404bcbf5a621748f2f5b5319bc70cce6138ba8298e0ec3`
- final profile `b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558`

This is an implementation execution and audit verdict only. It does not approve merge, tag, public visibility, a GitHub Release, Zenodo publication, or any claim that the receipt or SCITT layers exist. Those decisions remain Ivan Nestorov's.
