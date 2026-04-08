// AEK Kinesis Advantage2 — Dvorak layout with AEK inset-color style
//
// Assembly: keyboard layout + legend style + configuration.
// Renders one row at a time as body/legends parts.

include <../includes.scad>
include <../src/keyboards/kinesis_advantage2.scad>
include <../src/styles/aek_inset.scad>

// ===== Configuration =====

render_row = "left_top"; // [left_top, left_bottom, right_top, right_bottom, thumbs, test]
part = "body";         // [body, legends]

$inset_legend_depth = 1.0;
$stem_inner_slop = 0.1;
$stabilizer_type = "rounded_cherry";

// ===== Render =====

kinesis_advantage2_row(render_row);
