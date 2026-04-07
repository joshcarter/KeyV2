// Drop CTRL TKL (87-key) physical layout — Dvorak with JIS katakana sub-legends
//
// Defines WHERE each key goes and WHAT role it serves.
// Does NOT define fonts, legend positions, profile, or render method —
// those come from the style file included by the assembly.
//
// Calls five abstract key-role modules that must be provided by a style:
//   alpha(letter, x, row, w, sub, homing, dish)
//   shifted(primary, shift, x, row, w, sub)
//   modifier(label, icon_code, x, row, w)
//   icon(icon_code, x, row, w, sz, rot)
//   blank(x, row, w, dish)

module drop_ctrl_tkl_function_row() {
  r = 1;
  // Esc
  icon("\uf182", 0, r, rot=45);
  // F1-F12
  modifier("F1", "\uE312", 1, r);
  modifier("F2", "\uE312", 2, r);
  modifier("F3", "\uE312", 3, r);
  modifier("F4", "\uE312", 4, r);
  modifier("F5", "\uE312", 5, r);
  modifier("F6", "\uE312", 6, r);
  modifier("F7", "\uE312", 7, r);
  modifier("F8", "\uE312", 8, r);
  modifier("F9", "\uE312",  9, r);
  modifier("F10", "\uE312", 10, r);
  modifier("F11", "\uE312", 11, r);
  modifier("F12", "\uE312", 12, r);
}

module drop_ctrl_tkl_number_row() {
  r = 1;
  // Dvorak number row: ` 1 2 3 4 5 6 7 8 9 0 [ ]
  // JIS katakana:        ヌ フ ア ウ エ オ ヤ ユ ヨ ワ ホ ヘ

  shifted("`", "~",  0, r, sub="");
  shifted("1", "!",  1, r, sub="ヌ");
  shifted("2", "@",  2, r, sub="フ");
  shifted("3", "#",  3, r, sub="ア");
  shifted("4", "$",  4, r, sub="ウ");
  shifted("5", "%",  5, r, sub="エ");
  shifted("6", "^",  6, r, sub="オ");
  shifted("7", "&",  7, r, sub="ヤ");
  shifted("8", "*",  8, r, sub="ユ");
  shifted("9", "(",  9, r, sub="ヨ");
  shifted("0", ")", 10, r, sub="ワ");
  shifted("[", "{", 11, r, sub="ホ");
  shifted("]", "}", 12, r, sub="ヘ");
  // Backspace (2u) - backspace icon U+E14A
  icon("\uE14A", 13.5, r, w=2);
}

module drop_ctrl_tkl_top_alpha_row() {
  r = 2;
  // Tab (1.5u) - keyboard_tab icon U+E31C
  modifier("tab", "\uE31C", 0.25, r, w=1.5);
  // Dvorak top row: ' , . p y f g c r l / =
  // JIS katakana:   タ テ イ ス カ ン ナ ニ ラ セ ゛ ゜
  shifted("'", "\"",  1.5, r, sub="タ");
  shifted(",", "<",   2.5, r, sub="テ");
  shifted(".", ">",   3.5, r, sub="イ");
  alpha("p",  4.5, r, sub="ス");
  alpha("y",  5.5, r, sub="カ");
  alpha("f",  6.5, r, sub="ン");
  alpha("g",  7.5, r, sub="ナ");
  alpha("c",  8.5, r, sub="ニ");
  alpha("r",  9.5, r, sub="ラ");
  alpha("l", 10.5, r, sub="セ");
  shifted("/", "?", 11.5, r, sub="゛");
  shifted("=", "+", 12.5, r, sub="゜");
  // Backslash (1.5u) - no katakana equivalent on ANSI
  shifted("\\", "|", 13.75, r, w=1.5, sub="");
}

module drop_ctrl_tkl_home_row() {
  r = 3;
  // Caps Lock (1.75u) - keyboard_capslock icon U+E318
  modifier("caps lock", "\uE318", 0.375, r, w=1.75);
  // Dvorak home row: a o e u i d h t n s -
  // JIS katakana:    チ ト シ ハ キ ク マ ノ リ レ ケ
  // Homing bumps on u and h; dish=true on home-position keys
  alpha("a",  1.75, r, sub="チ", dish=true);
  alpha("o",  2.75, r, sub="ト", dish=true);
  alpha("e",  3.75, r, sub="シ", dish=true);
  alpha("u",  4.75, r, sub="ハ", homing=true, dish=true);
  alpha("i",  5.75, r, sub="キ");
  alpha("d",  6.75, r, sub="ク");
  alpha("h",  7.75, r, sub="マ", homing=true, dish=true);
  alpha("t",  8.75, r, sub="ノ", dish=true);
  alpha("n",  9.75, r, sub="リ", dish=true);
  alpha("s", 10.75, r, sub="レ", dish=true);
  shifted("-", "_", 11.75, r, sub="ケ");
  // Enter (2.25u) - keyboard_return icon U+E31B
  modifier("return", "\uE31B", 13.375, r, w=2.25);
}

module drop_ctrl_tkl_bottom_row() {
  r = 4;
  // Left Shift (2.25u)
  modifier("shift", "\uE5F8", 0.625, r, w=2.25);
  // Dvorak bottom row: ; q j k x b m w v z
  // JIS katakana:      ツ サ ソ ヒ コ ミ モ ネ ル メ
  shifted(";", ":",  2.25, r, sub="ツ");
  alpha("q",  3.25, r, sub="サ");
  alpha("j",  4.25, r, sub="ソ");
  alpha("k",  5.25, r, sub="ヒ");
  alpha("x",  6.25, r, sub="コ");
  alpha("b",  7.25, r, sub="ミ");
  alpha("m",  8.25, r, sub="モ");
  alpha("w",  9.25, r, sub="ネ");
  alpha("v", 10.25, r, sub="ル");
  alpha("z", 11.25, r, sub="メ");
  // Right Shift (2.75u)
  modifier("shift", "\uE5F8", 13.125, r, w=2.75);
}

module drop_ctrl_tkl_mods_row() {
  r = 4;
  // Drop CTRL bottom: LCtrl Win LAlt Space RAlt Fn Menu RCtrl
  modifier("control", "\uEAE6",  0.125, r, w=1.25);
  modifier("cmd",     "\uEAE7",  1.375, r, w=1.25);
  modifier("option",  "\uEAE8",  2.625, r, w=1.25);
  blank(6.375, r, w=6.25, dish=false);  // space bar
  modifier("option",  "\uEAE8", 10.125, r, w=1.25);
  modifier("fn",      "\uE312", 11.375, r, w=1.25);
  modifier("menu",    "\uE896", 12.625, r, w=1.25);
  modifier("control", "\uEAE6", 13.875, r, w=1.25);
}

module drop_ctrl_tkl_nav_cluster() {
  // PrtSc / ScrLk / Pause (row 1 profile)
  icon("\ue8ad", 0, 1, sz=5); // print
  icon("\ue897", 1, 1, sz=5); // scroll
  icon("\ue034", 2, 1, sz=5); // pause
  // Ins / Home / PgUp (row 1 profile)
  icon("\uE089", 3, 1, sz=5); // insert
  icon("\uEACF", 4, 1, sz=5, rot=90);  // home
  icon("\uEACF", 5, 1, sz=5);          // page up
  // Del / End / PgDn (row 2 profile)
  icon("\uE14A",  6, 2, sz=5, rot=180); // delete
  icon("\uEACF",  7, 2, sz=5, rot=270); // end
  icon("\uEACF",  8, 2, sz=5, rot=180); // page down
  // Arrow keys (row 4 profile)
  icon("\uE316",  9, 4); // Up
  icon("\uE314", 10, 4); // Left
  icon("\uE313", 11, 4); // Down
  icon("\uE315", 12, 4); // Right
}

// Dispatcher: render one row at a time
module drop_ctrl_tkl_row(render_row) {
  if (render_row == "function")  drop_ctrl_tkl_function_row();
  if (render_row == "numbers")   drop_ctrl_tkl_number_row();
  if (render_row == "top_alpha") drop_ctrl_tkl_top_alpha_row();
  if (render_row == "home")      drop_ctrl_tkl_home_row();
  if (render_row == "bottom")    drop_ctrl_tkl_bottom_row();
  if (render_row == "mods")      drop_ctrl_tkl_mods_row();
  if (render_row == "nav")       drop_ctrl_tkl_nav_cluster();
}
