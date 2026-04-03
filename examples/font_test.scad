include <../includes.scad>

// Font test: Exo 2 Semi Bold, Katakana, Material Icons
// Using outset legends for visibility in preview renders

$outset_legends = true;

exo = "Exo 2 Semi Bold:style=Semi Bold";
katakana_font = "Hiragino Sans:style=W7";
icons = "Material Icons Outlined:style=Regular";
icons_filled = "Material Icons:style=Regular";

// Key 1: Simple Exo 2 legend
translate_u(0, 0) cherry() dsa_row(3)
  legend("a", [-0.8, 0.8], size=6, font=exo)
    key();

// Key 2: Dual legend - Exo 2 + Katakana
translate_u(1, 0) cherry() dsa_row(3)
  legend("a", [-0.8, 0.8], size=6, font=exo)
    legend("チ", [0.8, -0.8], size=4, font=katakana_font)
      key();

// Key 3: Material Icon Outlined (U+E31B = keyboard icon)
translate_u(2, 0) cherry() dsa_row(3)
  legend("\uE31B", [0, 0], size=7, font=icons)
    key();
