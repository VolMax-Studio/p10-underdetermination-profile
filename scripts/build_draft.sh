#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRAFT_DIR="$SCRIPT_DIR/../draft"
BIN_DIR="/home/volmax-studio/.local/bin"

export PATH="$BIN_DIR:$PATH"
export AWK="$BIN_DIR/gawk"
export WGET="false"

cd "$DRAFT_DIR"

echo "=== Toolchain ==="
"$BIN_DIR/kdrfc" --version
xml2rfc --version
"$BIN_DIR/idnits" --version
ruby --version

echo "=== 1. kdrfc (Markdown -> XML) ==="
"$BIN_DIR/kdrfc" -x draft-nestorov-scitt-p10-underdetermination-00.md

echo "=== 2. xml2rfc (XML -> TXT) ==="
xml2rfc draft-nestorov-scitt-p10-underdetermination-00.xml --text

echo "=== 3. idnits ==="
"$BIN_DIR/idnits" draft-nestorov-scitt-p10-underdetermination-00.txt
