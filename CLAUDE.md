# KeyV2 - Parametric Mechanical Keycap Library (OpenSCAD)

## Project Overview

Parametric keycap generator for 3D printing. Generates keycap models using OpenSCAD's
special variable (`$var`) inheritance system for configuration.

## Architecture

- `includes.scad` — entry point, pulls in all modules via `use`/`include`
- `src/key.scad` — core keycap generation: `shape()`, `outer_shape()`, `inner_shape()`,
  `dished()`, `key()`, `shine_through_key()`
- `src/settings.scad` — all default `$variable` values
- `src/key_profiles.scad` — profile registry and `key_profile()` dispatcher
- `src/key_profiles/` — individual profiles (dsa, sa, cherry, jdc, etc.)
- `src/key_transformations.scad` — modifier modules: `legend()`, `front_legend()`,
  `cherry()`, `rounded_cherry()`, `u()`, `stabilized()`, etc.
- `src/key_sizes.scad` — `u()`, `translate_u()`, width helpers
- `src/features/legends.scad` — `keytext()` and `legends()` rendering
- `src/hulls/hull.scad` — `placed_shape_slice()` for hull-based shape generation
- `src/layouts/` — predefined keyboard layouts (60%, HHKB, planck, etc.)
- `src/constants.scad` — `$unit = 19.05` (mm per key unit)

## Key Concepts

- **Special variables** (`$var`) cascade through module children. Profiles set them,
  `key()` reads them.
- **Module chaining**: `cherry() dsa_row(3) legend("a") key()` — each module sets
  variables, passes to children.
- **Legend array**: `legend()` appends `[text, position, size, font, rotation]` to
  `$legends`. `legends(depth)` renders all accumulated entries.
- **`shape(thickness_difference, depth_difference)`** creates inset/offset versions
  of the outer keycap shape, used for wall thickness and keytop.
- **Layout positioning**: `translate_u(x, y)` translates by `x * 19.05mm`. For wider
  keys, compute center position: e.g., a 2u key after 13 1u keys has center at 13.5.
- **Named parameters in OpenSCAD**: must match formal parameter names exactly.
  `ik(..., r=1)` will NOT set `row` — use `row=1`.

## Custom Additions (JDC project)

### JDC Profile (`src/key_profiles/jdc.scad`)
Custom profile based on DSA with less taper, thicker keytop, squared scoop dish.
Key differences from DSA: `$width_difference=4`, `$height_difference=4`,
`$keytop_thickness=2.0`, `$dish_type="squared scoop"`, uniform `$total_depth=9.0`.

### Shine-Through Multimaterial (`shine_through_key()` in `src/key.scad`)
Splits keycap into opaque shell + translucent interior for bi-material printing.
- `part="body"` — thin outer shell with legend-shaped openings
- `part="shine"` — interior structure (walls, stem, supports) + legend fills
- `skin` parameter controls shell thickness (recommend 3-4x nozzle diameter)

### Legend Rotation
`legend()` accepts `rotation=` parameter (degrees CCW). Stored as 5th element in
the `$legends` tuple. Used for rotated icons (e.g., flipped backspace for Delete).

## Files

- `examples/dvorak_tkl.scad` — full 87-key Drop CTRL layout, Dvorak + JIS katakana
- `examples/shine_through_multimaterial.scad` — small test-print file
- `examples/font_test.scad` — font rendering tests
- `build_dvorak_tkl.sh` — renders all row/part STL combinations in parallel
- `build_shine_through.sh` — renders body/shine for the test file
- `build_test.sh` — renders the test row

## Fonts

- `Exo 2 Semi Bold:style=Semi Bold` — primary text legends
- `Hiragino Sans:style=W7` — katakana sub-legends
- `Material Icons Outlined:style=Regular` — modifier key icons (use `\uXXXX` codepoints)

## Common Gotchas

- OpenSCAD render (F6) is required for correct geometry; preview (F5) may show artifacts
- `$key_bump` (homing bar) requires explicit handling in `shine_through_key()` — it's
  added to the body's outer union, not inherited from `outer_shape()`
- The `bk()` helper (blank key) does not accept `sz` — it has no legend
- Stabilizers auto-configure via `$stabilizers` in settings.scad based on `$key_length`
- OpenSCAD CLI: `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD`
- Use `-D 'var="value"'` to override top-level variables from CLI

## Printer Setup

- Prusa XL, 5 tool heads, 0.25mm nozzles
- Layer height 0.1-0.12mm for legend detail
- Opaque PLA + translucent/clear PLA for shine-through
- Kailh Whale Pro Silent Tactile switches — use `rounded_cherry()` stem
