include <../includes.scad>

/* Dvorak TKL (87-key) layout with JIS katakana sub-legends
   Designed for Drop CTRL with Prusa XL multi-material printing.

   Renders one keyboard row at a time as shine-through body/shine parts.
   Use render_row and part to select what to render.

   Workflow:
     1. Set render_row to the desired row
     2. Set part to "body" or "shine"
     3. Render (F6) and export STL
     4. Repeat for all rows and parts
     Or use build_dvorak_tkl.sh to render everything automatically.
*/

// ===== Configuration =====

// Which keyboard row to render
render_row = "test"; // [function, numbers, top_alpha, home, bottom, mods, nav, test]

// Part to render: "body" for opaque shell, "shine" for translucent interior
part = "shine"; // [body, shine]

// Opaque shell thickness (mm)
skin = 1.0; // [0.4:0.1:2.0]


// ===== Fonts =====

exo = "Exo 2 Semi Bold:style=Semi Bold";
kata = "Hiragino Sans:style=W7";
icons = "Material Icons Outlined:style=Regular";


// ===== Helper modules =====

// Dual-legend key: Dvorak primary (top-left) + katakana (bottom-right)
module dk(primary, katakana, x, row, w=1, bump=false) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row) {
    $key_bump = bump;
    $key_bump_depth = 0.6;  // mm height above surface
    $key_bump_edge = 2.0;   // mm from front edge
    legend(primary, [-0.6, 0.6], size=5, font=exo)
      legend(katakana, [0.6, -0.6], size=4, font=kata)
        shine_through_key(part, skin);
  }
}

// Single text legend key (centered)
module tk(label, x, row, w=1, sz=4) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row)
    legend(label, [0, 0], size=sz, font=exo)
      shine_through_key(part, skin);
}

// Single text legend key (top-left, no katakana)
module pk(primary, x, row, w=1, sz=5) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row)
    legend(primary, [-0.6, 0.6], size=sz, font=exo)
      shine_through_key(part, skin);
}

// Icon legend key (centered)
module ik(icon_code, x, row, w=1, sz=6, rot=0) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row)
    legend(icon_code, [0, 0], size=sz, font=icons, rotation=rot)
      shine_through_key(part, skin);
}

// Blank key (no legend)
module bk(x, row, w=1) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row)
    shine_through_key(part, skin);
}


// ===== Row definitions =====

module function_row() {
  r = 1;
  // Esc
  ik("\uf182", 0, r, rot=45);
  // F1-F4
  tk("F1", 1, r);
  tk("F2", 2, r);
  tk("F3", 3, r);
  tk("F4", 4, r);
  // F5-F8
  tk("F5", 5, r);
  tk("F6", 6, r);
  tk("F7", 7, r);
  tk("F8", 8, r);
  // F9-F12
  tk("F9",  9, r);
  tk("F10", 10, r);
  tk("F11", 11, r);
  tk("F12", 12, r);
}

module number_row() {
  r = 1;
  // Positions: 13 x 1u keys + 2u backspace + 3 nav keys
  // Dvorak number row: ` 1 2 3 4 5 6 7 8 9 0 [ ]
  // JIS katakana:        ヌ フ ア ウ エ オ ヤ ユ ヨ ワ ホ ヘ

  pk("`",  0, r);
  dk("1", "ヌ",  1, r);
  dk("2", "フ",  2, r);
  dk("3", "ア",  3, r);
  dk("4", "ウ",  4, r);
  dk("5", "エ",  5, r);
  dk("6", "オ",  6, r);
  dk("7", "ヤ",  7, r);
  dk("8", "ユ",  8, r);
  dk("9", "ヨ",  9, r);
  dk("0", "ワ", 10, r);
  dk("[", "ホ", 11, r);
  dk("]", "ヘ", 12, r);
  // Backspace (2u) - backspace icon U+E14A
  ik("\uE14A", 13.5, r, w=2);
}

module top_alpha_row() {
  r = 2;
  // Positions: 1.5u tab + 12 x 1u + 1.5u backslash + 3 nav
  // Dvorak top row: ' , . p y f g c r l / =
  // JIS katakana:   タ テ イ ス カ ン ナ ニ ラ セ ゛ ゜

  // Tab (1.5u) - keyboard_tab icon U+E31C
  ik("\uE31C", 0.25, r, w=1.5);
  // Alpha keys
  dk("'", "タ",  1.5, r);
  dk(",", "テ",  2.5, r);
  dk(".", "イ",  3.5, r);
  dk("p", "ス",  4.5, r);
  dk("y", "カ",  5.5, r);
  dk("f", "ン",  6.5, r);
  dk("g", "ナ",  7.5, r);
  dk("c", "ニ",  8.5, r);
  dk("r", "ラ",  9.5, r);
  dk("l", "セ", 10.5, r);
  dk("/", "゛", 11.5, r);
  dk("=", "゜", 12.5, r);
  // Backslash (1.5u) - no katakana equivalent on ANSI
  pk("\\", 13.75, r, w=1.5);
}

module home_row() {
  r = 3;
  // Positions: 1.75u caps + 11 x 1u + 2.25u enter
  // Dvorak home row: a o e u i d h t n s -
  // JIS katakana:    チ ト シ ハ キ ク マ ノ リ レ ケ
  // Homing bumps on u (Dvorak) and h (Dvorak)

  // Caps Lock (1.75u) - keyboard_capslock icon U+E318
  ik("\uE318", 0.375, r, w=1.75);
  // Home row alpha
  dk("a", "チ",  1.75, r);
  dk("o", "ト",  2.75, r);
  dk("e", "シ",  3.75, r);
  dk("u", "ハ",  4.75, r, bump=true);   // homing
  dk("i", "キ",  5.75, r);
  dk("d", "ク",  6.75, r);
  dk("h", "マ",  7.75, r, bump=true);   // homing
  dk("t", "ノ",  8.75, r);
  dk("n", "リ",  9.75, r);
  dk("s", "レ", 10.75, r);
  dk("-", "ケ", 11.75, r);
  // Enter (2.25u) - keyboard_return icon U+E31B
  ik("\uE31B", 13.375, r, w=2.25);
}

module bottom_row() {
  r = 4;
  // Positions: 2.25u LShift + 10 x 1u + 2.75u RShift + 1u Up arrow
  // Dvorak bottom row: ; q j k x b m w v z
  // JIS katakana:      ツ サ ソ ヒ コ ミ モ ネ ル メ

  // Left Shift (2.25u)
  bk(0.625, r, w=2.25);
  // Bottom row alpha
  dk(";", "ツ",  2.25, r);
  dk("q", "サ",  3.25, r);
  dk("j", "ソ",  4.25, r);
  dk("k", "ヒ",  5.25, r);
  dk("x", "コ",  6.25, r);
  dk("b", "ミ",  7.25, r);
  dk("m", "モ",  8.25, r);
  dk("w", "ネ",  9.25, r);
  dk("v", "ル", 10.25, r);
  dk("z", "メ", 11.25, r);
  // Right Shift (2.75u)
  bk(13.125, r, w=2.75);
}

module mods_row() {
  r = 4;
  // Positions: 3 x 1.25u + 6.25u space + 4 x 1.25u + 3 x 1u arrows
  // Drop CTRL bottom: LCtrl Win LAlt Space RAlt Fn Menu RCtrl

  ik("\uEAE6", 0.125,  r, w=1.25);   // control
  ik("\uEAE7",  1.375,  r, w=1.25);  // windows/command
  ik("\uEAE8",  2.625,  r, w=1.25);  // alt
  bk(6.375, r, w=6.25);              // Spacebar (blank)
  ik("\uEAE8",  10.125, r, w=1.25);  //alt
  ik("\uE312",   11.375, r, w=1.25); // fn
  ik("\uE896", 12.625, r, w=1.25);   // menu
  ik("\uEAE6", 13.875, r, w=1.25);   //control
}

module nav_cluster() {
  // PrtSc / ScrLk / Pause (row 1 profile)
  ik("\ue8ad", 0, 1, sz=5); //print 
  ik("\ue897", 1, 1, sz=5); //scroll
  ik("\ue034", 2, 1, sz=5); //pause
  // Ins / Home / PgUp (row 1 profile)
  ik("\uE089", 3, 1, sz=5); // insert
  ik("\uEACF", 4, 1, sz=5, rot=90); //home
  ik("\uEACF", 5, 1, sz=5); //page up
  // Del / End / PgDn (row 2 profile)
  ik("\uE14A",  6, 2, sz=5, rot=180); //delete
  ik("\uEACF",  7, 2, sz=5, rot=270); //end
  ik("\uEACF", 8, 2, sz=5, rot=180); //page down
  // Arrow keys (row 4 profile)
  ik("\uE316",  9, 4);   // Up
  ik("\uE314", 10, 4);   // Left
  ik("\uE313", 11, 4);   // Down
  ik("\uE315", 12, 4);   // Right
}

module test() {
  ik("\uf182", 0, row=1, rot=45);
  ik("\uE31C", 1.25, row=2, w=1.5);
  dk("a", "チ",  2.5, row=3);
  ik("\uEAE7",  3.625,  row=4, w=1.25);  // windows/command
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