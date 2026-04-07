// AEK Dvorak TKL — Drop CTRL layout with AEK inset-color style
//
// Assembly: keyboard layout + legend style + configuration.
// Renders one row at a time as body/legends parts.

include <../includes.scad>
include <../src/keyboards/drop_ctrl_tkl.scad>
include <../src/styles/aek_inset.scad>

// ===== Configuration =====

render_row = "home"; // [function, numbers, top_alpha, home, bottom, mods, nav]
part = "body";      // [body, legends]

$inset_legend_depth = 1.0;
$stem_inner_slop = 0.1;
$stabilizer_type = "rounded_cherry";

// ===== Render =====

drop_ctrl_tkl_row(render_row);
