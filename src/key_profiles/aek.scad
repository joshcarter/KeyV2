use <../functions.scad>
include <../settings.scad>

// AEK profile - Apple Extended Keyboard inspired with:
//   - asymmetric taper (4mm sides, 1mm front-to-back)
//   - flat top (dish disabled by default)
//   - thicker keytop (2mm)
//   - sculpted square shape with side/corner sculpting
//   - uniform 9mm depth across all rows

module aek_row(row=3, column = 0) {
  $key_shape_type = "sculpted_square";
  $bottom_key_width = 18.0;
  $bottom_key_height = 18.0;
  $width_difference = 4;
  $height_difference = 1;
  $keytop_thickness = 2.0;
  $top_tilt = 0;
  $top_skew = 0;
  $dish_type = "disable";
  $dish_depth = 1.2;
  $dish_skew_x = 0;
  $dish_skew_y = 0;
  $height_slices = 10;

  $side_sculpting = function(progress) (1 - progress) * 4.5;
  $corner_sculpting = function(progress) pow(progress, 2);

  $corner_radius = 1;
  $more_side_sculpting_factor = 0.4;

  $top_tilt_y = side_tilt(column);
  extra_height = $double_sculpted ? extra_side_tilt_height(column) : 0;

  $total_depth = 9.0 + extra_height;
  children();
}
