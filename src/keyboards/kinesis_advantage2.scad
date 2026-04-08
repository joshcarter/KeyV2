// Kinesis Advantage2 (KB600) physical layout — Dvorak
//
// 68 keys total: 56 well (4×6 + 4 bottom per side) + 12 thumb cluster.
// Function row omitted (rubber keys, not removable).
//
// Organized by physical sections for easier printing and testing:
//   - left_top:      12 keys (2 rows: numbers + top alpha)
//   - left_bottom:   10 keys (3 rows: home + bottom + extras)
//   - right_top:     12 keys (2 rows: numbers + top alpha)
//   - right_bottom:  10 keys (3 rows: home + bottom + extras)
//   - thumbs:        12 keys (2 rows: left cluster + right cluster)
//
// Keys arranged in 2D on print bed using translate_u(0, y) offsets.
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

// ===== Left Keywell — Top 2 rows (numbers + top alpha) =====

module kinesis_advantage2_left_top() {
  // Row 1 (numbers, profile r=1) at y=0
  translate_u(0, 0) {
    shifted("=", "+", 0.125, 1, w=1.25);
    shifted("1", "!", 1.25, 1);
    shifted("2", "@", 2.25, 1);
    shifted("3", "#", 3.25, 1);
    shifted("4", "$", 4.25, 1);
    shifted("5", "%", 5.25, 1);
  }

  // Row 2 (top alpha, profile r=2) at y=1
  translate_u(0, -1) {
    modifier("tab", "\uE31C", 0.125, 2, w=1.25);
    shifted("'", "\"", 1.25, 2);
    shifted(",", "<",  2.25, 2);
    shifted(".", ">",  3.25, 2);
    alpha("p", 4.25, 2);
    alpha("y", 5.25, 2);
  }
}

// ===== Left Keywell — Bottom 3 rows (home + bottom + extras) =====

module kinesis_advantage2_left_bottom() {
  // Row 1 (home, profile r=3) at y=0
  translate_u(0, 0) {
    modifier("caps", "\uE318", 0.125, 3, w=1.25);
    alpha("a", 1.25, 3, dish=true);
    alpha("o", 2.25, 3, dish=true);
    alpha("e", 3.25, 3, dish=true);
    alpha("u", 4.25, 3, homing=true, dish=true);
    alpha("i", 5.25, 3);
  }

  // Row 2 (bottom, profile r=4) at y=1
  translate_u(0, -1) {
    modifier("shift", "\uE5F8", 0.125, 4, w=1.25);
    shifted(";", ":", 1.25, 4);
    alpha("q", 2.25, 4);
    alpha("j", 3.25, 4);
    alpha("k", 4.25, 4);
    alpha("x", 5.25, 4);
  }

  // Row 3 (bottom extras, profile r=1) at y=2
  translate_u(0, -2) {
    shifted("`", "~", 0, 1);
    shifted("\\", "|", 1, 1);
    icon("\uE314", 2, 1);  // left arrow
    icon("\uE315", 3, 1);  // right arrow
  }
}

// ===== Right Keywell — Top 2 rows (numbers + top alpha) =====

module kinesis_advantage2_right_top() {
  // Row 1 (numbers, profile r=1) at y=0
  translate_u(0, 0) {
    shifted("6", "^",  0, 1);
    shifted("7", "&",  1, 1);
    shifted("8", "*",  2, 1);
    shifted("9", "(", 3, 1);
    shifted("0", ")", 4, 1);
    shifted("[", "{", 5.125, 1, w=1.25);
  }

  // Row 2 (top alpha, profile r=2) at y=1
  translate_u(0, -1) {
    alpha("f",  0, 2);
    alpha("g",  1, 2);
    alpha("c",  2, 2);
    alpha("r", 3, 2);
    alpha("l", 4, 2);
    shifted("]", "}", 5.125, 2, w=1.25);
  }
}

// ===== Right Keywell — Bottom 3 rows (home + bottom + extras) =====

module kinesis_advantage2_right_bottom() {
  // Row 1 (home, profile r=3) at y=0
  translate_u(0, 0) {
    alpha("d",  0, 3);
    alpha("h",  1, 3, homing=true, dish=true);
    alpha("t",  2, 3, dish=true);
    alpha("n", 3, 3, dish=true);
    alpha("s", 4, 3, dish=true);
    shifted("-", "_", 5.125, 3, w=1.25);
  }

  // Row 2 (bottom, profile r=4) at y=1
  translate_u(0, -1) {
    alpha("b",  0, 4);
    alpha("m",  1, 4);
    alpha("w",  2, 4);
    alpha("v", 3, 4);
    alpha("z", 4, 4);
    modifier("shift", "\uE5F8", 5.125, 4, w=1.25);
  }

  // Row 3 (bottom extras, profile r=1) at y=2
  translate_u(0, -2) {
    icon("\uE316",  0, 1);  // up arrow
    icon("\uE313", 1, 1);  // down arrow
    shifted("/", "?", 2, 1);
    shifted("=", "+", 3, 1);
  }
}

// ===== Thumb Clusters =====

module kinesis_advantage2_thumbs() {
  // Left thumb cluster (profile r=4) at y=0:
  //   Ctrl  Alt  [Backspace 2u]  [Delete 2u]  Home  End
  translate_u(0, 0) {
    modifier("ctrl", "\uEAE6", 0, 4);
    modifier("opt",  "\uEAE8", 1, 4);
    icon("\uE14A", 2.5, 4, w=2, rot=270);                    // backspace (2u)
    icon("\uE14A", 4.5, 4, w=2, rot=90);           // delete (2u)
    icon("\uEACF", 6, 4, sz=5, rot=90);             // home
    icon("\uEACF", 7, 4, sz=5, rot=270);            // end
  }

  // Right thumb cluster (profile r=4) at y=1:
  //   Cmd  Ctrl  [Space 2u]  [Enter 2u]  PgUp  PgDn
  translate_u(0, -1) {
    modifier("cmd", "\uEAE7", 0, 4);
    modifier("ctrl", "\uEAE6", 1, 4);
    blank(2.5, 4, w=2, dish=false);                 // space (2u, dishless)
    icon("\uE31B", 4.5, 4, w=2, rot=90);       // enter (2u)
    icon("\uEACF", 6, 4, sz=5);                     // page up
    icon("\uEACF", 7, 4, sz=5, rot=180);            // page down
  }
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
  if (render_row == "left_top")      kinesis_advantage2_left_top();
  if (render_row == "left_bottom")   kinesis_advantage2_left_bottom();
  if (render_row == "right_top")     kinesis_advantage2_right_top();
  if (render_row == "right_bottom")  kinesis_advantage2_right_bottom();
  if (render_row == "thumbs")        kinesis_advantage2_thumbs();
  if (render_row == "test")          kinesis_advantage2_test();
}
