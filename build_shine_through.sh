#!/bin/bash
set -euo pipefail

OPENSCAD="${OPENSCAD:-/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD}"
SCAD_FILE="${1:-examples/shine_through_multimaterial.scad}"
OUTPUT_DIR="${2:-output}"

mkdir -p "$OUTPUT_DIR"

base="$(basename "$SCAD_FILE" .scad)"

echo "Rendering $SCAD_FILE -> $OUTPUT_DIR/"
echo "  body (opaque)..."
"$OPENSCAD" -D 'part="body"' -o "$OUTPUT_DIR/${base}_body.stl" "$SCAD_FILE" &
pid_body=$!

echo "  shine (translucent)..."
"$OPENSCAD" -D 'part="shine"' -o "$OUTPUT_DIR/${base}_shine.stl" "$SCAD_FILE" &
pid_shine=$!

wait $pid_body && echo "  body done." || echo "  body FAILED."
wait $pid_shine && echo "  shine done." || echo "  shine FAILED."

echo "Output:"
ls -lh "$OUTPUT_DIR/${base}_"*.stl
