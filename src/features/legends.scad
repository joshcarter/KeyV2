module keytext(text, position, font_size, font_face, depth, rotation=0, halign="center", valign="center") {
  tw = top_total_key_width();
  th = top_total_key_height();

  // When halign is "left" or "right", position[0] is mm inset from that edge.
  // When halign is "center", position[0] is the legacy proportional factor (-1..1).
  woffset = (halign == "left")  ? -tw/2 + position[0] :
            (halign == "right") ?  tw/2 - position[0] :
            (tw/3.5) * position[0];

  // When valign is "top" or "bottom", position[1] is mm inset from that edge.
  // When valign is "center", position[1] is the legacy proportional factor (-1..1).
  // In keytop coords: Y positive = back edge ("top"), Y negative = front edge ("bottom").
  // text(valign="top") grows downward from anchor; text(valign="bottom") grows upward.
  hoffset = (valign == "top")    ?  th/2 - position[1] :
            (valign == "bottom") ? -th/2 + position[1] :
            (th/3.5) * -position[1];

  translate([woffset, hoffset, -depth]){
    color($tertiary_color) linear_extrude(height=$dish_depth + depth){
      rotate([0, 0, rotation])
        let(text_valign = (valign == "bottom") ? "baseline" : valign)
        text(text=text, font=font_face, size=font_size, halign=halign, valign=text_valign);
    }
  }
}

module legends(depth=0) {
  if (len($front_legends) > 0) {
    front_of_key() {
      for (i=[0:len($front_legends)-1]) {
        rotation = len($front_legends[i]) > 4 ? $front_legends[i][4] : 0;
        ha = len($front_legends[i]) > 5 ? $front_legends[i][5] : "center";
        va = len($front_legends[i]) > 6 ? $front_legends[i][6] : "center";
        rotate([90,0,0]) keytext($front_legends[i][0], $front_legends[i][1], $front_legends[i][2], $front_legends[i][3], depth, rotation, ha, va);
  	  }
    }
  }
  if (len($legends) > 0) {
    top_of_key() {
      for (i=[0:len($legends)-1]) {
        rotation = len($legends[i]) > 4 ? $legends[i][4] : 0;
        ha = len($legends[i]) > 5 ? $legends[i][5] : "center";
        va = len($legends[i]) > 6 ? $legends[i][6] : "center";
        keytext($legends[i][0], $legends[i][1], $legends[i][2], $legends[i][3], depth, rotation, ha, va);
      }
    }
  }
}
