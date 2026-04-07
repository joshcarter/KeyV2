// Kinesis Advantage2 (KB600) physical layout — Dvorak
//
// 68 keys: 56 well (4×6 + 4 bottom per side) + 12 thumb cluster.
// Function row omitted (rubber keys, not removable).
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

// ===== Left/Right Well — 4 main rows × 6 keys each =====

module kinesis_advantage2_numbers() {
  r = 1;
  // Left well row 1: = 1 2 3 4 5
  shifted("=", "+", 0.125, r, w=1.25);
  shifted("1", "!", 1.25, r);
  shifted("2", "@", 2.25, r);
  shifted("3", "#", 3.25, r);
  shifted("4", "$", 4.25, r);
  shifted("5", "%", 5.25, r);

  // Right well row 1: 6 7 8 9 0 [
  shifted("6", "^",  7, r);
  shifted("7", "&",  8, r);
  shifted("8", "*",  9, r);
  shifted("9", "(", 10, r);
  shifted("0", ")", 11, r);
  shifted("[", "{", 12.125, r, w=1.25);
}

module kinesis_advantage2_top_alpha() {
  r = 2;
  // Left well row 2: Tab ' , . P Y
  modifier("tab", "\uE31C", 0.125, r, w=1.25);
  shifted("'", "\"", 1.25, r);
  shifted(",", "<",  2.25, r);
  shifted(".", ">",  3.25, r);
  alpha("p", 4.25, r);
  alpha("y", 5.25, r);

  // Right well row 2: F G C R L ]
  alpha("f",  7, r);
  alpha("g",  8, r);
  alpha("c",  9, r);
  alpha("r", 10, r);
  alpha("l", 11, r);
  shifted("]", "}", 12.125, r, w=1.25);
}

module kinesis_advantage2_home() {
  r = 3;
  // Left well row 3: Caps A O E U I
  modifier("caps", "\uE318", 0.125, r, w=1.25);
  alpha("a", 1.25, r, dish=true);
  alpha("o", 2.25, r, dish=true);
  alpha("e", 3.25, r, dish=true);
  alpha("u", 4.25, r, homing=true, dish=true);
  alpha("i", 5.25, r);

  // Right well row 3: D H T N S -
  alpha("d",  7, r);
  alpha("h",  8, r, homing=true, dish=true);
  alpha("t",  9, r, dish=true);
  alpha("n", 10, r, dish=true);
  alpha("s", 11, r, dish=true);
  shifted("-", "_", 12.125, r, w=1.25);
}

module kinesis_advantage2_bottom() {
  r = 4;
  // Left well row 4: LShift ; Q J K X
  modifier("shift", "\uE5F8", 0.125, r, w=1.25);
  shifted(";", ":", 1.25, r);
  alpha("q", 2.25, r);
  alpha("j", 3.25, r);
  alpha("k", 4.25, r);
  alpha("x", 5.25, r);

  // Right well row 4: B M W V Z RShift
  alpha("b",  7, r);
  alpha("m",  8, r);
  alpha("w",  9, r);
  alpha("v", 10, r);
  alpha("z", 11, r);
  modifier("shift", "\uE5F8", 12.125, r, w=1.25);
}

// ===== Bottom modifier rows (4 keys each side) =====

module kinesis_advantage2_bottom_mods() {
  r = 1;
  // Left bottom: ` \ ← →
  shifted("`", "~", 0, r);
  shifted("\\", "|", 1, r);
  icon("\uE314", 2, r);  // left arrow
  icon("\uE315", 3, r);  // right arrow

  // Right bottom: ↑ ↓ / =
  icon("\uE316",  9, r);  // up arrow
  icon("\uE313", 10, r);  // down arrow
  shifted("/", "?", 11, r);
  shifted("=", "+", 12, r);
}

// ===== Thumb clusters =====

module kinesis_advantage2_thumbs() {
  r = 4;
  // Left thumb cluster (laid out sequentially):
  //   Ctrl  Alt  [Backspace 2u]  [Delete 2u]  Home  End
  modifier("ctrl", "\uEAE6", 0, r);
  modifier("opt",  "\uEAE8", 1, r);
  icon("\uE14A", 2.5, r, w=2);                      // backspace (2u)
  icon("\uE14A", 4.5, r, w=2, rot=180);             // delete (2u)
  icon("\uEACF", 6, r, sz=5, rot=90);               // home
  icon("\uEACF", 7, r, sz=5, rot=270);              // end

  // Right thumb cluster (laid out sequentially):
  //   Cmd  Ctrl  [Space 2u]  [Enter 2u]  PgUp  PgDn
  modifier("cmd",     "\uEAE7",  9, r);
  modifier("ctrl", "\uEAE6", 10, r);
  blank(11.5, r, w=2, dish=false);                   // space (2u, dishless)
  modifier("enter", "\uE31B", 13.5, r, w=2);         // enter (2u)
  icon("\uEACF", 15, r, sz=5);                       // page up
  icon("\uEACF", 16, r, sz=5, rot=180);              // page down
}

// ===== Test row =====

module kinesis_advantage2_test() {
  // Caps 1.25u | A (homing) | 5/% | Enter 2u | Cmd
  modifier("caps", "\uE318", 0.125, 3, w=1.25);
  alpha("a", 1.25, 3, homing=true, dish=true);
  shifted("5", "%", 2.25, 1);
  modifier("enter", "\uE31B", 3.75, 4, w=2);
  modifier("cmd", "\uEAE7", 5.25, 4);
}

// ===== Dispatcher =====

module kinesis_advantage2_row(render_row) {
  if (render_row == "numbers")     kinesis_advantage2_numbers();
  if (render_row == "top_alpha")   kinesis_advantage2_top_alpha();
  if (render_row == "home")        kinesis_advantage2_home();
  if (render_row == "bottom")      kinesis_advantage2_bottom();
  if (render_row == "bottom_mods") kinesis_advantage2_bottom_mods();
  if (render_row == "thumbs")      kinesis_advantage2_thumbs();
  if (render_row == "test")        kinesis_advantage2_test();
}
