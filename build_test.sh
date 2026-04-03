#!/bin/bash
set -euo pipefail

OPENSCAD="${OPENSCAD:-/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD}"
SCAD_FILE="examples/dvorak_tkl.scad"
OUTPUT_DIR="${1:-output/dvorak_tkl}"

mkdir -p "$OUTPUT_DIR"

ROWS="test"
PARTS="body shine"

echo "Rendering Dvorak TKL layout -> $OUTPUT_DIR/"

pids=()
labels=()

for row in $ROWS; do
  for p in $PARTS; do
    out="$OUTPUT_DIR/${row}_${p}.stl"
    echo "  $row / $p ..."
    "$OPENSCAD" -D "render_row=\"$row\"" -D "part=\"$p\"" -o "$out" "$SCAD_FILE" &
    pids+=($!)
    labels+=("$row/$p")
  done
done

echo "Waiting for ${#pids[@]} renders..."

failed=0
for i in "${!pids[@]}"; do
  if wait "${pids[$i]}"; then
    echo "  ${labels[$i]} done."
  else
    echo "  ${labels[$i]} FAILED."
    failed=$((failed + 1))
  fi
done

echo ""
if [ $failed -eq 0 ]; then
  echo "All renders complete."
else
  echo "$failed render(s) failed."
fi
echo ""
echo "Output:"
ls -lh "$OUTPUT_DIR/"*.stl 2>/dev/null || echo "  No STL files found."
