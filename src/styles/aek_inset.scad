// AEK inset-color style — AEK profile + Futura font + inset legend rendering
//
// Implements the five abstract key-role modules for use with keyboard layout files.
// Reads from assembly scope: part, $inset_legend_depth

// ===== Fonts =====

_aek_futura = "Futura LT:style=CondensedOblique";
_aek_icons = "Material Icons Outlined:style=Regular";


// ===== Internal helpers =====

// Uppercase a single lowercase ASCII letter
function _aek_upper(s) = chr(ord(s) - 32);

// Render dispatch: body = full key, legends = inset legend geometry
module _aek_render() {
  if (part == "body") {
    key();
  } else if (part == "legends") {
    dished() { legends($inset_legend_depth); }
  }
}


// ===== Key-role modules =====

// Alpha key: uppercase letter, left/bottom edge-relative position
// Squared scoop dish on homing keys; dish hint for home-position keys
module alpha(letter, x, row, w=1, sub="", homing=false, dish=false) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) auto_stabilized(w) {
    $dish_type = (homing || dish) ? "squared scoop" : $dish_type;
    legend(_aek_upper(letter), [2, 2], size=6, font=_aek_futura, halign="left", valign="bottom")
      _aek_render();
  }
}

// Shifted key: primary bottom-left + shifted top-left (stacked left column)
module shifted(primary, shift, x, row, w=1, sub="") {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) auto_stabilized(w) {
    legend(primary, [2, 2], size=5, font=_aek_futura, halign="left", valign="bottom")
      legend(shift, [2, 2], size=5, font=_aek_futura, halign="left", valign="top")
        _aek_render();
  }
}

// Modifier key: text label top-left + icon bottom-left, stacked left column
module modifier(label, icon_code, x, row, w=1) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) auto_stabilized(w) {
    legend(label, [2, 2], size=4, font=_aek_futura, halign="left", valign="bottom")
      legend(icon_code, [2, 2], size=5, font=_aek_icons, halign="left", valign="top")
        _aek_render();
  }
}

// Icon key: single icon centered
module icon(icon_code, x, row, w=1, sz=6, rot=0) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) auto_stabilized(w) {
    legend(icon_code, [0, 0], size=sz, font=_aek_icons, rotation=rot)
      _aek_render();
  }
}

// Blank key: no legend
module blank(x, row, w=1, dish=false) {
  translate_u(x, 0) u(w) rounded_cherry() aek_row(row) auto_stabilized(w) {
    $dish_type = dish ? "squared scoop" : $dish_type;
    _aek_render();
  }
}
