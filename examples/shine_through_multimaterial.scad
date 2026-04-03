include <../includes.scad>

/* Shine-through multimaterial keycaps for multi-tool printers (e.g. Prusa XL)

   Generates two STL files:

     body  - thin opaque outer shell with legend-shaped openings
     shine - translucent interior (inner walls, stem, keytop backing,
             and legend fills through the shell)

   Workflow:
     1. Set part = "body", render (F6), export STL -> opaque filament
     2. Set part = "shine", render (F6), export STL -> translucent filament
     3. Import both STLs into PrusaSlicer as parts of one object
     4. Assign each part to a different tool head

   Or use build_shine_through.sh to render both parts automatically.

   Notes:
     - skin is the opaque shell thickness: per-side for walls, direct for
       keytop. 3-4x nozzle diameter recommended (e.g. 0.75-1mm for 0.25mm)
     - 0.25mm nozzle recommended for legend detail
     - Layer height 0.1-0.12mm for best quality
     - Sans-serif fonts with uniform stroke width print cleanest
*/

// ===== Configuration =====

// Part to render: "body" for opaque shell, "shine" for translucent interior
part = "body"; // [body, shine]

// Opaque shell thickness (mm). Per-side for walls, direct for keytop.
// Use 3-4x your nozzle diameter for good opacity.
skin = 1.0; // [0.4:0.1:2.0]

// ===== Example: Dvorak home row =====

exo = "Exo 2 Semi Bold:style=Semi Bold";

dvorak_home = ["a", "o", "e"];

for (x = [0:len(dvorak_home)-1]) {
  translate_u(x, 0) rounded_cherry() jdc_row(3)
    legend(dvorak_home[x], [-0.5, 0.5], size=6, font=exo) {
        shine_through_key(part, skin);
  }
}
