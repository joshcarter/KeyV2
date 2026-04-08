#!/bin/bash
set -euo pipefail

OPENSCAD="${OPENSCAD:-/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD}"
SCAD_FILE="examples/aek_kinesis.scad"
OUTPUT_DIR="${1:-output/kinesis}"

mkdir -p "$OUTPUT_DIR"

ROWS="left_top left_bottom right_top right_bottom thumbs"
# ROWS="test"
PARTS="body legends"

echo "Rendering Kinesis Advantage2 layout -> $OUTPUT_DIR/"

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
