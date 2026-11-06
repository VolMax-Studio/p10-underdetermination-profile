# GATE_FINAL (round 4): adversarial review of draft-nestorov-scitt-p10-underdetermination-03

**Round 1:** FAIL. M27 disagreed with S2a/S2b (I4, I3/N8). Body lines 472 and 488 and M7 contradicted the new M27 and M5. M16 kept "not after closure → REJECT". P10-ERR-04 had no record.
**Round 2:** FAIL. M27(b) "checkpoint key" sent the rotated or other supplied key cases to REJECT. The History misstated M35.
**Round 3:** FAIL. M27 sent I5 `LeafSpecDigestMismatch` to HALT, where S2b gives REJECT. Non-blocking: the appendix rule did not hold for S2b dominance (PRE:383), and (b)/(c) did not tie the key to the configured fingerprint.

Mode: read-only. The only writes are under /tmp/claude-0/gate2/ (this file and the `work*/` scratch directories).

Notation:
- D3 = `/tmp/pup/draft/draft-nestorov-scitt-p10-underdetermination-03.md`, sha256 `c441ef4c70bc581865b0ca46757cf0806b6ac4f462154a49c32b943558f82096`.
- PRE = `/tmp/s2b/frozen/S2B_PREREG_v0.1_r7.md`.
- S2A = `/tmp/lau/interop/p10/appendix-a/repos/p10-coverage-lean-s2/` (741d56d).
- SPS = `/tmp/s2b/frozen/StatementPayloadSchemaV0_r9.md`.
- V = `/tmp/s2b/vectors/` (8eaa91c).
- PROF = `/tmp/pup/P10_Underdetermination_Profile_v0.1.1.md`.

## Overall verdict: **PASS** (no blocking findings; non-blocking findings listed below)

The round-3 blocker (I5) is fixed. Every M27 key-case row maps to exactly one outcome, and that outcome agrees with S2b. That includes the composites of a supplied-key fingerprint mismatch with (b) or (c). The qualified appendix rule is accurate against PRE:383 and against S2a, provided "full-prefix replay" is read as the `FullPrefixReplay` reconstruction defined at D3:475-484. A looser reading of that term is possible; see N1.

Absence of further findings is **NOT DEMONSTRATED**, and this PASS is not proof of correctness. The kramdown/xml2rfc build was not checkable because `kramdown-rfc` is unavailable. Erratum ratification is the owner's governance step and was not assessed. The draft text does not claim ratification.

---

## D. Diff integrity: **SUPPORTED (PASS)**

- I extracted `-02` from tag `ietf-draft-02-ratified-2026-10-30`. It is byte-identical to the working-tree `-02`.
- I applied `/tmp/claude-0/s/02-to-03.diff` (19397 bytes, 15 hunks) with `patch` in `/tmp/claude-0/gate2/work4/`. It applied cleanly.
- `cmp` against D3 shows the files are identical.
- **New-text scan.** I diffed the round-3 reproduction (`work3/a.md`) against the round-4 D3. Exactly three lines changed: D3:783 (the appendix rule), D3:945 (M27 Expected) and D3:1599 (History). Every other hunk is byte-identical to the version I reviewed in round 3. The round-3 verdicts for those hunks stand.

---

## 1. I5 `LeafSpecDigestMismatch`: maps to REJECT only — **SUPPORTED**

- **S2b behaviour.** S2b compares `frozen.leaf_encoding_spec_digest` (equal to `pB.leaf_encoding_spec_digest`, PRE:229) with its own spec copy (PRE:359). The check runs at P7, only after P3 and P6 pass (PRE:377). The result is `Invalid(binding)`, composed REJECT (PRE:683 and 704). The vector V/I/I5-spec confirms it.
- **D3 mapping.** D3 (b) gives REJECT when four conditions hold:
  - the target is authenticated under the key used for replay;
  - that key's fingerprint equals the configuration's;
  - the root is equal;
  - "the `LeafEncodeV0` specification used for replay differs from the committed leaf-encoding specification".

  I5 satisfies all four.
- **No overlap with (a).** I5 is not a replay that "succeeds", because S2b returns `Invalid`.
- **No overlap with the HALT list.** Every HALT-list item is excluded by the P3 and P6 preconditions. A fingerprint mismatch is excluded by (b)'s own fingerprint condition.
- **Composites.**
  - I5 with a supplied-key fingerprint mismatch: (b) fails, so D3 gives HALT. S2b gives HALT, because P0 `Invalid(request)` is first in order (PRE:370, 383 and 702).
  - I5 with a malformed configuration: HALT in both.
- **Related control.** A log that actually used another encoding, verified with the committed spec, gives D3 HALT, because the target does not authenticate. This matches V/M/M5-* and M6-* (`ReceiptTargetAuthenticationFailure`).

## 2. M27 key-case table (D3:945) — **SUPPORTED** (all rows hold)

| Input | D3 M27 | Sources |
|---|---|---|
| Receipt signed by K2; configuration and supplied key K1 | HALT (the signature fails) | PRE:455-456; C7-detached and C7-attached → HALT (PRE:703) |
| Receipt signed by K2 or a rotated key; that key supplied; configuration K1 | HALT (supplied-key fingerprint differs) | PRE:452 and 808; C24-newkey-supplied, C7-otherkey-supplied, M13 → `Invalid(request)` → HALT |
| Configuration and supplied key K2; Receipt by K2; commitment K1 | REJECT under (a) | I3-other-ts-key (S2b Verified), then S2a C1 (Coverage.lean:260-261); s2a-t11/N8 |
| No Receipt key | HALT (catch-all) | PRE:451; C8 |
| Authenticated Receipt, TS `iss` differs | REJECT under (b) | PRE:462 and 377; C9, I2-ts-iss |
| Committed spec ≠ the spec used for replay | REJECT under (b) | I5-spec (above) |
| VDS ≠ 1 attached, signature valid | REJECT under (c) | PRE:457; C10b |
| VDS ≠ 1 detached, or bad signature | HALT | PRE:458-459; C10, C10c |
| Configuration VDS ≠ 1 or malformed | HALT (verifier error) | PRE:370 and 702; I4-frozen-vds; I7-* and I8 `RequestMalformed` |
| **Composite:** supplied-key fingerprint mismatch + TS `iss` difference | HALT: (b) needs a fingerprint-equal key, so the HALT list applies | P0 `Invalid(request)` is first in order → HALT (PRE:370, 383, 702) |
| **Composite:** supplied-key fingerprint mismatch + attached VDS ≠ 1 | HALT: (c) needs "that key", the fingerprint-equal key from (b), so (c) does not hold and the "apart from case (c)" exemption is not reached | P0 `Invalid(request)` comes before P3 `VdsAlgorithmMismatch` → HALT |

`LogIdentityInconsistent` breaches (PRE:504) are covered as follows:
- TS identity is covered by (b).
- The key thumbprint is checked at P0, so it cannot differ once (b) applies.
- VDS is covered by P0 or (c).
- The leaf profile digest is covered by the I5 clause.

No key case is mapped to no outcome or to two outcomes.

## 3. Qualified appendix rule (D3:783) — **SUPPORTED**, with N1 below

The rule reads: "where an earlier check fails, that check's outcome applies, except that within full-prefix replay an established invalidity takes precedence over unavailable material."

- **Against PRE:383.** The dominance rule says "If any `Invalid` is established → `Invalid` (first in the order above as `reason` …); else if any `Unavailable` → `Unavailable`". The exception reproduces Invalid-over-Unavailable. The first-in-order choice among several Invalids is the "earlier check" part of the rule.
  - Round-3 example: P0 `Unavailable(capability)` with P7 `TsIssuerMismatch`. This now gives REJECT under the exception, which matches S2b.
  - Invalid(request) or Invalid(replay) against Unavailable: HALT either way.
- **Against S2a.** The S2a chain is strictly first-failure (Coverage.lean:150-154 and 252-300; `S2_PREREG_v0.2.6.md:398`).
  - C1 REJECT comes before C2 HALT, which comes before C3-C13. For example, an unavailable row together with an omitted admission gives C2 HALT (N16 ordering).
  - This agrees with the unqualified "earlier check" rule, because S2a lies outside the S2b reconstruction.
- **Post-S2a.** The lowest A row wins (BIND-multiple-lowest, BIND-unavailable-and-mismatch), which matches the rule.

---

## C. History (D3:1599): new text — **SUPPORTED**

- "M16 … or the verified target statement is not after it" matches D3 M16.
- The M27 additions match D3:945: the `LeafEncodeV0`-specification difference gives REJECT, the supplied-key fingerprint mismatch gives HALT, and the malformed configuration gives HALT.
- The parenthetical on the appendix qualifier matches D3:783.
- The rest is unchanged from round 3 and SUPPORTED there: the M35 sentence; "four body sentences"; "§7.1 for tests, Sections 2 and 3 for body sentences".
- The erratum wording asserts no ratification.

---

## Findings

### BLOCKING
None found. This is not a proof that none exist.

### Non-blocking
- **N1 (AMBIGUOUS).** "Within full-prefix replay" is accurate only if it means the `FullPrefixReplay` reconstruction at D3:475-484, which corresponds to the S2b phases P0-P9. D3:488 says "Replay verifies that the profile and unique commitment were registered before the first relevant admission …". A reader could therefore treat lifecycle and coverage checks as "within full-prefix replay". Under that reading, an unavailable row or payload combined with a late profile commitment would give REJECT. S2a gives C2 HALT first (Coverage.lean:295-297 comes before :175). Suggested fix: "within the `FullPrefixReplay` reconstruction ({{full-prefix-replay}}), before coverage checks".
- **N2.** In M27(c), "that key" is an anaphor to (b)'s key definition. It works, but restating "the key used for replay, whose fingerprint equals the replay configuration's" in (c) would be more robust.
- **N3.** D3:512 and D3:559 are body sentences outside the appendix rule, so they still lack its qualifier (unchanged from round 3).
- **N4.** M7 does not map the admission-only-in-other-log case itself (S2a C8 or C12 REJECT). M14 still says "preflight". The T1-T6 HALT outcomes are not stated in any test.
- **N5.** There is no vector for a literally absent `limitations` member, or for a cited non-owner closure with no valid owner closure. Both rest on schema text and code order only (SPS:107 and 315; Coverage.lean:183-189).
- **N6.** Editorial:
  - a `{{statement-and-predicate-structure}}` cross-reference for R;
  - the `S_R` / `R` notation collision;
  - `receipt.evidence_digest` at D3:556;
  - the `E0n` versus `P10-ERR-0n` naming, with `E01`-`E03` also used as pin labels at D3:1342-1366.
- **N7.** Not checkable here: the build (`kramdown-rfc` absent), the "outside reading of `-02`" provenance, and the existence or ratification of P10-ERR-04 (the owner's governance step).

## Overall: **PASS** (no blocking findings; N1 is recommended before submission)

---

# Round 5 (narrowest re-check): **PASS**

The scope was the N1 and N2 edits only. Everything else carries forward from round 4.

Round-5 D3 is `/tmp/pup/draft/draft-nestorov-scitt-p10-underdetermination-03.md`, sha256 `ea043b68af33a96aa86a65113accb04a5ec3a620831bf2594ef1ca9a172a4924`. This matches the expected `ea043b68…4924`.

1. **Patch reproduction: SUPPORTED.**
   - I extracted `-02` freshly from tag `ietf-draft-02-ratified-2026-10-30`.
   - I applied the regenerated `/tmp/claude-0/s/02-to-03.diff` with `patch` in `/tmp/claude-0/gate2/work5/`. It applied cleanly.
   - `cmp` against D3 shows the files are identical.

2. **Only the three intended changes since round 4: SUPPORTED.**
   - I diffed the round-4 reproduction (`work4/a.md`, sha256 `c441ef4c…`) against D3. Exactly three lines differ, and each differs only by the stated string:
     - **D3:783 (appendix rule).** "within full-prefix replay" became "within the `FullPrefixReplay` reconstruction ({{full-prefix-replay}}), before coverage checks,".
     - **D3:945 (M27(c)).** "valid under that key" became "valid under the key used for replay, whose fingerprint equals the replay configuration's,".
     - **D3:1599 (History parenthetical).** "within full-prefix replay" became "within the `FullPrefixReplay` reconstruction, before coverage checks,".
   - No other byte changed.

3. **N1 is closed, N2 is closed, and nothing new is broken: SUPPORTED.**
   - **N1.** The exception is now confined to the `FullPrefixReplay` reconstruction (D3:475-484). That corresponds to S2b phases P0-P9, where the dominance rule applies: an `Invalid` beats an `Unavailable` (PRE:383). The exception explicitly excludes coverage and lifecycle checks, which follow S2a's strict first-failure order (C1 before C2 before C3-C13; Coverage.lean:252-300). So the round-4 counter-reading is now excluded: an unavailable row combined with a late profile commitment gives C2 HALT before C3 REJECT, and the draft now says the same.
   - **N2.** M27(c) now states the fingerprint condition itself. The composite of a supplied-key fingerprint mismatch with an attached VDS ≠ 1 still gives HALT, matching S2b (P0 `Invalid(request)` is first; PRE:370, 383, 702). The other round-4 key-case rows are unaffected, including I5 → REJECT.
   - **The anchor resolves.** `{#full-prefix-replay}` exists at D3:455, and `{{full-prefix-replay}}` is already used 8 times in D3. The History parenthetical has no cross-reference, so it adds no new reference. Rendering was not checked, because `kramdown-rfc` is absent.

**Round 5 verdict: PASS.** No blocking findings. The round-4 non-blocking items N3-N7 remain. Absence of further findings is NOT DEMONSTRATED.
