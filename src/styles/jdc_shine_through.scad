// JDC shine-through style — JDC profile + Exo/Hiragino fonts + shine-through rendering
//
// Implements the five abstract key-role modules for use with keyboard layout files.
// Reads from assembly scope: part, skin, flat_top

// ===== Fonts =====

_jdc_exo = "Exo 2 Semi Bold:style=Semi Bold";
_jdc_exobold = "Exo 2 Semi Bold:style=Bold";
_jdc_kata = "Hiragino Sans:style=W7";
_jdc_icons = "Material Icons Outlined:style=Regular";


// ===== Internal helpers =====

// Counter-rotate keycap so the dished top surface sits flat on the print bed.
module _jdc_orient() {
  if (flat_top) {
    rotate([$top_tilt / $key_height, 0, 0]) children();
  } else {
    children();
  }
}

module _jdc_render() {
  _jdc_orient() shine_through_key(part, skin);
}


// ===== Key-role modules =====

// Alpha key: primary letter top-left + optional katakana sub-legend bottom-right
module alpha(letter, x, row, w=1, sub="", homing=false, dish=false) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row) auto_stabilized(w) {
    $key_bump = homing;
    $key_bump_depth = 0.6;
    $key_bump_edge = 2.0;
    legend(letter, [-0.6, 0.6], size=5, font=_jdc_exo)
      if (sub != "") {
        legend(sub, [0.6, -0.6], size=4, font=_jdc_kata)
          _jdc_render();
      } else {
        _jdc_render();
      }
  }
}

// Shifted key: primary top-left + shifted bottom-left + optional katakana bottom-right
module shifted(primary, shift, x, row, w=1, sub="") {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row) auto_stabilized(w) {
    legend(primary, [-0.65, 0.65], size=4, font=_jdc_exobold)
      legend(shift, [-0.65, -0.65], size=4, font=_jdc_exobold)
        if (sub != "") {
          legend(sub, [0.6, -0.6], size=4, font=_jdc_kata)
            _jdc_render();
        } else {
          _jdc_render();
        }
  }
}

// Modifier key: text label centered
module modifier(label, icon_code, x, row, w=1) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row) auto_stabilized(w) {
    legend(label, [0, 0], size=4, font=_jdc_exo)
      _jdc_render();
  }
}

// Icon key: single icon centered
module icon(icon_code, x, row, w=1, sz=6, rot=0) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row) auto_stabilized(w) {
    legend(icon_code, [0, 0], size=sz, font=_jdc_icons, rotation=rot)
      _jdc_render();
  }
}

// Blank key: no legend
module blank(x, row, w=1, dish=true) {
  translate_u(x, 0) u(w) rounded_cherry() jdc_row(row) auto_stabilized(w) {
    $dish_type = dish ? $dish_type : "disable";
    _jdc_render();
  }
}
