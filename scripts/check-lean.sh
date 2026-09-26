#!/usr/bin/env bash
set -euo pipefail

if rg -n --glob '*.lean' '\b(sorry|admit)\b' lean; then
  echo "error: placeholder proof found in Lean sources" >&2
  exit 1
fi

lake build --wfail

audit_output="$(lake env lean lean/P10/AxiomAudit.lean 2>&1)"
printf '%s\n' "$audit_output"

if printf '%s\n' "$audit_output" | rg -q 'depends on axioms: \['; then
  echo "error: axiom dependency found" >&2
  exit 1
fi
