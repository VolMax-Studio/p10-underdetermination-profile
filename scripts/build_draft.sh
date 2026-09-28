#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRAFT_DIR="$SCRIPT_DIR/../draft"
BIN_DIR="/home/volmax-studio/.local/bin"

export PATH="$BIN_DIR:$PATH"
export AWK="$BIN_DIR/gawk"
export WGET="false"

cd "$DRAFT_DIR"

MD_FILE="draft-nestorov-scitt-p10-underdetermination-00.md"
XML_FILE="draft-nestorov-scitt-p10-underdetermination-00.xml"
TXT_FILE="draft-nestorov-scitt-p10-underdetermination-00.txt"

echo "=== 0. Markdown source integrity ==="
ruby - "$MD_FILE" <<'RUBY'
path = ARGV.fetch(0)
text = File.binread(path).force_encoding(Encoding::UTF_8)
failures = []
failures << "manually authored <spanx" if text.include?("<spanx")
failures << "&zwsp;" if text.include?("&zwsp;")
failures << "numeric U+200B entity" if text.match?(/&#(?:0*8203|[xX]0*200[bB]);/)
{
  "U+200B ZERO WIDTH SPACE" => "\u200B",
  "U+2060 WORD JOINER" => "\u2060",
  "U+FEFF ZERO WIDTH NO-BREAK SPACE/BOM" => "\uFEFF",
  "U+00AD SOFT HYPHEN" => "\u00AD"
}.each do |name, character|
  failures << name if text.include?(character)
end

# A block-list marker must not immediately follow prose. Without the blank
# line, kramdown renders the apparent list as one paragraph. Ignore YAML
# metadata and fenced source blocks, and permit consecutive list items.
lines = text.lines.map(&:chomp)
in_metadata = true
in_fence = false
lines.each_with_index do |line, index|
  if in_metadata
    in_metadata = false if line.match?(/^---\s+(?:abstract|middle|back)\s*$/)
    next
  end
  if line.match?(/^\s*(?:```|~~~)/)
    in_fence = !in_fence
    next
  end
  next if in_fence || !line.match?(/^\s*[-*]\s+/)

  previous = index.zero? ? "" : lines[index - 1]
  next if previous.strip.empty? || previous.match?(/^\s*[-*]\s+/)

  failures << "list item on line #{index + 1} immediately follows prose"
end
unless failures.empty?
  warn "Markdown source integrity failed: #{failures.join(', ')}"
  exit 1
end
puts "Markdown source integrity: OK"
RUBY

echo "=== Toolchain ==="
"$BIN_DIR/kdrfc" --version
xml2rfc --version
"$BIN_DIR/idnits" --version
ruby --version

echo "=== 1. kdrfc (Markdown -> XML) ==="
"$BIN_DIR/kdrfc" -x "$MD_FILE"

echo "=== 2. xml2rfc (XML -> TXT) ==="
xml2rfc "$XML_FILE" --text

echo "=== 2a. Generated XML integrity ==="
ruby - "$XML_FILE" <<'RUBY'
path = ARGV.fetch(0)
text = File.binread(path).force_encoding(Encoding::UTF_8)
content = text.lines.reject { |line| line.match?(/^\s*<!ENTITY\s+/) }.join
failures = []
failures << "&zwsp; outside a DTD entity definition" if content.include?("&zwsp;")
failures << "numeric U+200B entity outside a DTD entity definition" if content.match?(/&#(?:0*8203|[xX]0*200[bB]);/)
{
  "U+200B ZERO WIDTH SPACE" => "\u200B",
  "U+2060 WORD JOINER" => "\u2060",
  "U+FEFF ZERO WIDTH NO-BREAK SPACE/BOM" => "\uFEFF",
  "U+00AD SOFT HYPHEN" => "\u00AD"
}.each do |name, character|
  failures << name if content.include?(character)
end
failures << "corrupted FormallyUnderdeterminationCapable identifier" if content.match?(/FormallyUnder(?:&[^;]+;|\s|<[^>]+>)+determinationCapable/)
unless failures.empty?
  warn "Generated XML integrity failed: #{failures.join(', ')}"
  exit 1
end
puts "Generated XML integrity: OK"
RUBY

echo "=== 2b. Generated TXT integrity ==="
ruby - "$MD_FILE" "$TXT_FILE" <<'RUBY'
md_path, txt_path = ARGV
markdown = File.binread(md_path).force_encoding(Encoding::UTF_8)
text = File.binread(txt_path).force_encoding(Encoding::UTF_8)
failures = []
failures << "literal named or numeric entity" if text.match?(/&(?:[A-Za-z][A-Za-z0-9._:-]*|#[0-9]+|#[xX][0-9A-Fa-f]+);/)
{
  "U+200B ZERO WIDTH SPACE" => "\u200B",
  "U+2060 WORD JOINER" => "\u2060",
  "U+FEFF ZERO WIDTH NO-BREAK SPACE/BOM" => "\uFEFF",
  "U+00AD SOFT HYPHEN" => "\u00AD"
}.each do |name, character|
  failures << name if text.include?(character)
end

visible_markdown = markdown.gsub(/<!--.*?-->/m, "")
spans = visible_markdown.scan(/(?<!`)`([^`\n]+)`(?!`)/).flatten
normalized_spans = spans.map { |span| span.gsub(/\s+/, " ").strip }.uniq
normalized_text = text.gsub(/-\s+/, "-").gsub(/\s+/, " ")
missing = normalized_spans.reject { |span| normalized_text.include?(span) }
unless missing.empty?
  missing.each { |span| warn "Missing inline-code span in TXT: #{span.inspect}" }
  failures << "#{missing.length} visible inline-code span(s) missing or split"
end
failures << "FormallyUnderdeterminationCapable(π, c) is not intact" unless normalized_text.include?("FormallyUnderdeterminationCapable(π, c)")

unless failures.empty?
  warn "Generated TXT integrity failed: #{failures.join(', ')}"
  exit 1
end
puts "Generated TXT integrity: OK (#{normalized_spans.length} unique inline-code spans)"
RUBY

echo "=== 3. idnits ==="
IDNITS_OUTPUT="$("$BIN_DIR/idnits" "$TXT_FILE")"
printf '%s\n' "$IDNITS_OUTPUT"
if ! grep -Eq 'Summary: 0 errors \(\*\*\), 0 flaws \(~~\),' <<<"$IDNITS_OUTPUT"; then
  echo "idnits validation failed: nonzero errors or flaws" >&2
  exit 1
fi
