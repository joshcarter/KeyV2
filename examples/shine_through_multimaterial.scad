include <../includes.scad>

/* Shine-through multimaterial keycaps for multi-tool printers (e.g. Prusa XL)

   Generates two STL files:

     body  - thin opaque outer shell with legend-shaped openings
     shine - translucent interior (inner walls, stem, keytop backing,
             and legend fills through the shell)

   The opaque shell covers the keycap's entire outer surface, blocking
   light everywhere except at legend-shaped openings. The translucent
   interior fills the rest of the keycap: inner walls, stem, supports,
   and the keytop material behind the legends.

   LED light travels through the translucent stem and inner structure,
   reaching the inner keytop surface. At legend locations the translucent
   material continues through openings in the opaque shell to the outer
   surface. Everywhere else the opaque shell blocks the light.

   Cross-section (outside to inside):
     [opaque]      Thin outer shell covering sides + keytop
     [translucent] Inner walls, keytop backing, stem, supports
     [translucent] Legend fills plugged through shell openings

   Workflow:
     1. Set part = "body", render (F6), export STL -> opaque filament
     2. Set part = "shine", render (F6), export STL -> translucent filament
     3. Import both STLs into PrusaSlicer as parts of one object
     4. Assign each part to a different tool head

   Notes:
     - skin is the opaque shell thickness: per-side for walls, direct for
       keytop. 3-4x nozzle diameter recommended (e.g. 0.75-1mm for 0.25mm)
     - 0.25mm nozzle recommended for legend detail
     - Layer height 0.1-0.12mm for best quality
     - Sans-serif fonts with uniform stroke width print cleanest
*/

// ===== Configuration =====

// Part to render: "body" for opaque shell, "shine" for translucent interior
part = "shine"; // [body, shine]

// Opaque shell thickness (mm). Per-side for walls, direct for keytop.
// Use 3-4x your nozzle diameter for good opacity.
skin = 0.8; // [0.4:0.1:2.0]


// ===== Shine-through modules =====

// Generates one part of a shine-through keycap based on the `part` variable.
// Use in place of key() with profile, stem, and legend variables already set.
module shine_through_key() {
  // Small overlap ensures the legend fills connect to the interior
  legend_depth = skin + 0.1;

  if (part == "body") {
    // Thin opaque outer shell with legend openings
    difference() {
      outer_shape();
      // Inner boundary of the opaque skin
      shape(skin * 2, skin);
      // Cut legend openings through the shell
      dished() {
        legends(legend_depth);
      }
    }
  } else {
    // Translucent interior: inner walls, stem, supports, inner keytop
    intersection() {
      key();
      shape(skin * 2, skin);
    }
    // Translucent legend fills through the opaque shell
    intersection() {
      outer_shape();
      dished() {
        legends(legend_depth);
      }
    }
  }
}


// ===== Example: Dvorak home row =====

dvorak_home = ["a", "o", "e", "u", "i", "d", "h", "t", "n", "s"];

$font_size = 6;

for (x = [0:len(dvorak_home)-1]) {
  translate_u(x, 0) cherry() dsa_row(3) legend(dvorak_home[x]) {
    shine_through_key();
  }
}
