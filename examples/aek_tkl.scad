// DEPRECATED: Use examples/aek_dvorak_tkl.scad instead.
// This file is kept temporarily for output verification comparison.

include <../includes.scad>

/* AEK-inspired Dvorak TKL (87-key) layout
   Apple Extended Keyboard aesthetic: Futura Condensed Oblique font,
   uppercase alpha legends, flat-topped profile with asymmetric taper,
   multi-material colored legends (not shine-through).

   Two-part rendering for multi-material:
     part="body"    -> keycap with inset legend cavities (1mm deep)
     part="legends" -> legend fill geometry for second color

   Workflow:
     1. Set render_row to the desired row
     2. Set part to "body" or "legends"
     3. Render (F6) and export STL
     4. Repeat for all rows and parts
     Or use build_aek_tkl.sh to render everything automatically.
*/

// ===== Configuration =====

// Which keyboard row to render
render_row = "home"; // [function, numbers, top_alpha, home, bottom, mods, nav, test]

// Part to render: "body" for keycap shell, "legends" for colored legend fills
part = "body"; // [body, legends]

// Legend cavity depth (mm)
$inset_legend_depth = 1.0;

// Stem fit (adjust for your printer)
$stem_inner_slop = 0.1; // mm

// This seems to work better than the stabilizer stems
$stabilizer_type = "rounded_cherry";


// ===== Fonts =====

futura = "Futura LT:style=CondensedOblique";
icons = "Material Icons Outlined:style=Regular";


// ===== Render dispatch =====

module render_part() {
  if (part == "body") {
    key();
  } else if (part == "legends") {
    dished() { legends($inset_legend_depth); }
  }
}


// ===== Helper modules =====

// Alpha key: uppercase letter, bottom-left position
module ak(primary, x, row, dish=false) {
  translate_u(x, 0) u(1) rounded_cherry() aek_row(row) {
    $dish_type = dish ? "squared scoop" : $dish_type;
    legend(primary, [2, 2], size=6, font=futura, halign="left", valign="bottom")
      render_part();
  }
}

// Shifted key: primary top-left + shifted bottom-left
module sk(primary, shifted, x, row, w=1) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) {
    $stabilizers = w >= 6 ? [[-50,0],[50,0]] : w >= 2 ? [[-12,0],[12,0]] : [];
    legend(primary, [2, 2], size=5, font=futura, halign="left", valign="bottom")
      legend(shifted, [2, 2], size=5, font=futura, halign="left", valign="top")
        render_part();
  }
}

// Modifier key: text label top-left + icon bottom-left, stacked left column
module mk(icon_code, label, x, row, w=1) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) {
    $stabilizers = w >= 6 ? [[-50,0],[50,0]] : w >= 2 ? [[-12,0],[12,0]] : [];
    legend(label, [2, 2], size=4, font=futura, halign="left", valign="bottom")
      legend(icon_code, [2, 2], size=5, font=icons, halign="left", valign="top")
        render_part();
  }
}

// Icon-only key (centered)
module ik(icon_code, x, row, w=1, sz=6, rot=0) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) {
    $stabilizers = w >= 6 ? [[-50,0],[50,0]] : w >= 2 ? [[-12,0],[12,0]] : [];
    legend(icon_code, [0, 0], size=sz, font=icons, rotation=rot)
      render_part();
  }
}

// Blank key (no legend)
module bk(x, row, w=1, dish=false) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) {
    $stabilizers = w >= 6 ? [[-50,0],[50,0]] : w >= 2 ? [[-12,0],[12,0]] : [];
    $dish_type = dish ? "squared scoop" : $dish_type;
    render_part();
  }
}


// ===== Row definitions =====

module function_row() {
  r = 1;
  // Esc
  ik("\uf182", 0, r, rot=45);
  // F1-F4
  mk("\uE312", "F1", 1, r);
  mk("\uE312", "F2", 2, r);
  mk("\uE312", "F3", 3, r);
  mk("\uE312", "F4", 4, r);
  // F5-F8
  mk("\uE312", "F5", 5, r);
  mk("\uE312", "F6", 6, r);
  mk("\uE312", "F7", 7, r);
  mk("\uE312", "F8", 8, r);
  // F9-F12
  mk("\uE312", "F9",  9, r);
  mk("\uE312", "F10", 10, r);
  mk("\uE312", "F11", 11, r);
  mk("\uE312", "F12", 12, r);
}

module number_row() {
  r = 1;
  // Dvorak number row: ` 1 2 3 4 5 6 7 8 9 0 [ ]

  sk("`", "~",  0, r);
  sk("1", "!",  1, r);
  sk("2", "@",  2, r);
  sk("3", "#",  3, r);
  sk("4", "$",  4, r);
  sk("5", "%",  5, r);
  sk("6", "^",  6, r);
  sk("7", "&",  7, r);
  sk("8", "*",  8, r);
  sk("9", "(",  9, r);
  sk("0", ")", 10, r);
  sk("[", "{", 11, r);
  sk("]", "}", 12, r);
  // Backspace (2u) - backspace icon U+E14A
  mk("\uE14A", "delete", 13.5, r, w=2);
}

module top_alpha_row() {
  r = 2;
  // Tab (1.5u)
  mk("\uE31C", "tab", 0.25, r, w=1.5);
  // Dvorak top row: ' , . P Y F G C R L / =
  sk("'", "\"",  1.5, r);
  sk(",", "<",   2.5, r);
  sk(".", ">",   3.5, r);
  ak("P",  4.5, r);
  ak("Y",  5.5, r);
  ak("F",  6.5, r);
  ak("G",  7.5, r);
  ak("C",  8.5, r);
  ak("R",  9.5, r);
  ak("L", 10.5, r);
  sk("/", "?", 11.5, r);
  sk("=", "+", 12.5, r);
  // Backslash (1.5u)
  sk("\\", "|", 13.75, r, w=1.5);
}

module home_row() {
  r = 3;
  // Caps Lock (1.75u)
  mk("\uE318", "caps lock", 0.375, r, w=1.75);
  // Dvorak home row: A O E U I D H T N S -
  ak("A",  1.75, r, dish=true);
  ak("O",  2.75, r, dish=true);
  ak("E",  3.75, r, dish=true);
  ak("U",  4.75, r, dish=true);   // homing
  ak("I",  5.75, r);
  ak("D",  6.75, r);
  ak("H",  7.75, r, dish=true);   // homing
  ak("T",  8.75, r, dish=true);
  ak("N",  9.75, r, dish=true);
  ak("S", 10.75, r, dish=true);
  sk("-", "_", 11.75, r);
  // Enter (2.25u) - keyboard_return icon U+E31B
  mk("\uE31B", "return", 13.375, r, w=2.25);
}

module bottom_row() {
  r = 4;
  // Left Shift (2.25u)
  mk("\uE5F8", "shift", 0.625, r, w=2.25);
  // Dvorak bottom row: ; Q J K X B M W V Z
  sk(";", ":",  2.25, r);
  ak("Q",  3.25, r);
  ak("J",  4.25, r);
  ak("K",  5.25, r);
  ak("X",  6.25, r);
  ak("B",  7.25, r);
  ak("M",  8.25, r);
  ak("W",  9.25, r);
  ak("V", 10.25, r);
  ak("Z", 11.25, r);
  // Right Shift (2.75u)
  mk("\uE5F8", "shift", 13.125, r, w=2.75);
}

module mods_row() {
  r = 4;
  // Drop CTRL bottom: LCtrl Win LAlt Space RAlt Fn Menu RCtrl

  mk("\uEAE6", "control",  0.125, r, w=1.25);
  mk("\uEAE7", "cmd",  1.375, r, w=1.25);
  mk("\uEAE8", "option",   2.625, r, w=1.25);
  bk(6.375, r, w=6.25);                        // space bar
  mk("\uEAE8", "option",  10.125, r, w=1.25);
  mk("\uE312", "fn",      11.375, r, w=1.25);
  mk("\uE896", "menu",    12.625, r, w=1.25);
  mk("\uEAE6", "control", 13.875, r, w=1.25);
}

module nav_cluster() {
  // PrtSc / ScrLk / Pause (row 1 profile)
  ik("\ue8ad", 0, 1, sz=5); // print
  ik("\ue897", 1, 1, sz=5); // scroll
  ik("\ue034", 2, 1, sz=5); // pause
  // Ins / Home / PgUp (row 1 profile)
  ik("\uE089", 3, 1, sz=5); // insert
  ik("\uEACF", 4, 1, sz=5, rot=90);  // home
  ik("\uEACF", 5, 1, sz=5);          // page up
  // Del / End / PgDn (row 2 profile)
  ik("\uE14A",  6, 2, sz=5, rot=180); // delete
  ik("\uEACF",  7, 2, sz=5, rot=270); // end
  ik("\uEACF",  8, 2, sz=5, rot=180); // page down
  // Arrow keys (row 4 profile)
  ik("\uE316",  9, 4); // Up
  ik("\uE314", 10, 4); // Left
  ik("\uE313", 11, 4); // Down
  ik("\uE315", 12, 4); // Right
}

module test() {
  r = 3;
  // A few test keys to verify profile and rendering
  ak("A", 0, r);
  ak("U", 1, r, dish=true);  // homing key with squared scoop
  sk("1", "!", 2, r);
  mk("\uE14A", "delete", 3.5, r, w=2);
}


// ===== Render selected row =====

if (render_row == "function")  function_row();
if (render_row == "numbers")   number_row();
if (render_row == "top_alpha") top_alpha_row();
if (render_row == "home")      home_row();
if (render_row == "bottom")    bottom_row();
if (render_row == "mods")      mods_row();
if (render_row == "nav")       nav_cluster();
if (render_row == "test")      test();
