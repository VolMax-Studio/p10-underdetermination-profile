#!/usr/bin/env bash
set -euo pipefail

if rg -n --glob '*.lean' '\b(sorry|admit|sorryAx|native_decide|Lean\.ofReduceBool)\b' lean tests; then
  echo "error: placeholder proof found in Lean sources" >&2
  exit 1
fi

lake build --wfail

sha256sum -c lean/P10_CHECKER_SOURCE_SHA256SUMS
sha256sum -c lean/P10_OLEAN_SHA256SUMS

manifest_digest() {
  local field="$1"
  sed -n "s/.*\"${field}\": \"sha256:\([^\"]*\)\".*/\1/p" \
    lean/VerifierManifestV0.json
}

check_manifest_digest() {
  local field="$1"
  local path="$2"
  local expected
  local actual
  expected="$(manifest_digest "$field")"
  actual="$(sha256sum "$path" | cut -d' ' -f1)"
  if [[ -z "$expected" || "$expected" != "$actual" ]]; then
    echo "error: $field mismatch for $path" >&2
    exit 1
  fi
}

check_manifest_digest checker_source_tree_digest lean/P10_CHECKER_SOURCE_SHA256SUMS
check_manifest_digest dependency_lock_digest lake-manifest.json
check_manifest_digest build_manifest_digest lean/P10_OLEAN_SHA256SUMS
check_manifest_digest axiom_policy_digest lean/AXIOM_POLICY.md
check_manifest_digest acceptance_command_digest lean/ACCEPTANCE_COMMAND.txt

toolchain_identifier="$(tr -d '\r\n' < lean-toolchain)"
if ! rg -q "\"lean_toolchain_identifier\": \"${toolchain_identifier}\"" \
    lean/VerifierManifestV0.json; then
  echo "error: Lean toolchain identifier mismatch" >&2
  exit 1
fi

lean_executable="$(elan which lean)"
expected_lean_digest="$(manifest_digest lean_toolchain_artifact_digest)"
actual_lean_digest="$(sha256sum "$lean_executable" | cut -d' ' -f1)"
if [[ "$expected_lean_digest" != "$actual_lean_digest" ]]; then
  echo "error: Lean toolchain artifact mismatch" >&2
  exit 1
fi

while read -r digest path; do
  if ! rg -q "\"${path}\": \"sha256:${digest}\"" \
      lean/VerifierManifestV0.json; then
    echo "error: .olean digest set mismatch for $path" >&2
    exit 1
  fi
done < lean/P10_OLEAN_SHA256SUMS

if ! rg -q '"profile_specification_digest": "sha256:b92c0d689b9f16f2184ba2addb8653ed881595cc3a0117c62cadadf5c6dc6558"' \
    lean/VerifierManifestV0.json; then
  echo "error: final profile specification digest mismatch" >&2
  exit 1
fi

audit_output="$(lake env lean lean/P10/AxiomAudit.lean 2>&1)"
printf '%s\n' "$audit_output"

if printf '%s\n' "$audit_output" | rg -q 'depends on axioms: \['; then
  echo "error: axiom dependency found" >&2
  exit 1
fi

mutation_output="$(mktemp)"
if lake env lean tests/negative/WeakerTarget.lean >"$mutation_output" 2>&1; then
  echo "error: weaker-target mutation unexpectedly type-checked" >&2
  rm -f "$mutation_output"
  exit 1
fi

if ! rg -qi 'type mismatch' "$mutation_output"; then
  echo "error: weaker-target mutation failed for an unexpected reason" >&2
  cat "$mutation_output" >&2
  rm -f "$mutation_output"
  exit 1
fi

printf '%s\n' "negative mutation: weaker or differently indexed target rejected"
rm -f "$mutation_output"
