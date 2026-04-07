// JDC Dvorak TKL — Drop CTRL layout with JDC shine-through style
//
// Assembly: keyboard layout + legend style + configuration.
// Renders one row at a time as shine-through body/shine parts.

include <../includes.scad>
include <../src/keyboards/drop_ctrl_tkl.scad>
include <../src/styles/jdc_shine_through.scad>

// ===== Configuration =====

render_row = "numbers"; // [function, numbers, top_alpha, home, bottom, mods, nav]
part = "shine";         // [body, shine]
skin = 1.0;             // opaque shell thickness (mm)
flat_top = true;        // tilt so top surface is flat on print bed

$stem_inner_slop = 0.1;
$stabilizer_type = "rounded_cherry";

// ===== Render =====

drop_ctrl_tkl_row(render_row);
