// =============================================================================
// PlantSense Probe — matches product hero photo:
//   dark capsule head + teal neck ring + flat-face stem + 3 oval sensors + tip
// Units: millimeters
//
// Pot sizes (electronics head FIXED; only stem/bury length changes):
//   S — small pots  4–5"  (~10–15 cm soil)   total ≈ 154 mm
//   M — medium pots 6–7"  (~15–22 cm soil)   total ≈ 199 mm  ← hero scale
//   L — large pots  8–12" (~22–30 cm soil)   total ≈ 254 mm
//
// Export:
//   openscad -D 'SIZE="S"' -D 'PART="assembled"'  -o stl/plant_sense_S.stl plant_sense_probe.scad
//   openscad -D 'SIZE="M"' -D 'PART="print_plate"' -o stl/plant_sense_M_print.stl plant_sense_probe.scad
//   PART = assembled | head | ring | stem | lid | print_plate
// =============================================================================

$fn = 64;

SIZE = "M"; // "S" | "M" | "L"
PART = "assembled";

// ---- Fixed head (same for every size — ESP32-C3 + battery) -----------------
head_w = 26;
head_d = 16;
head_h = 40;
wall   = 1.7;

// ---- Size → bury depth below teal ring ------------------------------------
function bury_for(s) =
  s == "S" ? 95 :
  s == "L" ? 195 :
             140;

bury_h   = bury_for(SIZE);
stem_w   = 12.0;   // width across flats (X) — photo: slim
stem_d   = 10.5;   // depth front-to-back (Y) after flats — flatter than round
stem_r   = 3.2;    // side corner radius
tip_h    = 16;
ring_h   = 3.0;
ring_od  = max(stem_w, stem_d) + 5.5;
tenon_d  = min(stem_w, stem_d) - 0.8;
ring_id  = tenon_d + 0.35;

// Sensor oval centers from tip base (thirds along bury zone)
sensor_bot = tip_h + bury_h * 0.22;
sensor_mid = tip_h + bury_h * 0.50;
sensor_top = tip_h + bury_h * 0.78;
oval_w = 5.0;
oval_h = 11.5;
oval_depth = 2.2; // deeper pocket so ovals read clearly on the flat face

stem_body_h = bury_h;
head_z0 = tip_h + stem_body_h + ring_h;
total_h = tip_h + stem_body_h + ring_h + head_h;

echo(str("PlantSense SIZE=", SIZE,
         " total=", total_h, "mm",
         " bury=", bury_h, "mm",
         " stem=", stem_w, "x", stem_d, "mm"));

// ---- helpers ---------------------------------------------------------------
module capsule_body(w, d, h) {
  hull() {
    translate([-(w - d) / 2, 0, d / 2]) sphere(d = d);
    translate([ (w - d) / 2, 0, d / 2]) sphere(d = d);
    translate([-(w - d) / 2, 0, h - d / 2]) sphere(d = d);
    translate([ (w - d) / 2, 0, h - d / 2]) sphere(d = d);
  }
}

module rounded_rect_2d(w, d, r) {
  // Flat front + flat back, rounded left/right — hero stem cross-section
  hull() {
    translate([-(w / 2 - r), -(d / 2 - r)]) circle(r = r);
    translate([ (w / 2 - r), -(d / 2 - r)]) circle(r = r);
    translate([-(w / 2 - r),  (d / 2 - r)]) circle(r = r);
    translate([ (w / 2 - r),  (d / 2 - r)]) circle(r = r);
  }
}

module oval_2d(w, h) {
  hull() {
    translate([0, -h / 2 + w / 2]) circle(d = w);
    translate([0,  h / 2 - w / 2]) circle(d = w);
  }
}

// ---- TIP -------------------------------------------------------------------
module tip() {
  // Cone from near-point to stem footprint
  hull() {
    translate([0, 0, 0.4])
      scale([0.08, 0.08, 1])
        linear_extrude(height = 0.2)
          rounded_rect_2d(stem_w, stem_d, stem_r);
    translate([0, 0, tip_h - 0.2])
      linear_extrude(height = 0.2)
        rounded_rect_2d(stem_w, stem_d, stem_r);
  }
}

// ---- STEM ------------------------------------------------------------------
module stem_outer() {
  difference() {
    union() {
      tip();
      translate([0, 0, tip_h])
        linear_extrude(height = stem_body_h)
          rounded_rect_2d(stem_w, stem_d, stem_r);
      // tenon through ring into head
      translate([0, 0, tip_h + stem_body_h])
        cylinder(h = ring_h + 3.2, d = tenon_d);
    }

    // Three recessed oval sensor windows on FRONT flat face
    for (z = [sensor_bot, sensor_mid, sensor_top]) {
      translate([0, -stem_d / 2 - 0.05, z])
        rotate([90, 0, 0])
          linear_extrude(height = oval_depth + 0.5)
            oval_2d(oval_w, oval_h);

      // wire path from core into pocket
      translate([0, 0, z])
        rotate([90, 0, 0])
          cylinder(h = stem_d / 2 + 1.5, d = 2.0);
    }

    // Hollow wire channel (solid tip remains)
    translate([0, 0, tip_h + 10])
      linear_extrude(height = stem_body_h + ring_h + 2)
        rounded_rect_2d(stem_w - 2 * wall, stem_d - 2 * wall, max(0.6, stem_r - wall));
  }
}

// ---- TEAL ACCENT RING ------------------------------------------------------
module accent_ring() {
  difference() {
    cylinder(h = ring_h, d = ring_od);
    translate([0, 0, -0.1])
      cylinder(h = ring_h + 0.2, d = ring_id);
  }
}

// ---- CAPSULE HEAD ----------------------------------------------------------
module head_shell() {
  difference() {
    capsule_body(head_w, head_d, head_h);

    // electronics cavity
    translate([0, 0, 2.4])
      capsule_body(head_w - 2 * wall, head_d - 2 * wall, head_h - 4.2);

    // USB-C on upper front face (hero)
    translate([0, -head_d / 2 - 0.2, head_h * 0.68])
      rotate([90, 0, 0])
        hull() {
          translate([-3.8, 0, 0]) cylinder(h = wall + 2.5, d = 3.6);
          translate([ 3.8, 0, 0]) cylinder(h = wall + 2.5, d = 3.6);
        }

    // status LED peephole
    translate([0, -head_d / 2 - 0.2, head_h * 0.30])
      rotate([90, 0, 0])
        cylinder(h = wall + 2.5, d = 2.2);

    // stem socket
    translate([0, 0, -0.3])
      cylinder(h = 7, d = tenon_d + 0.4);

    // rear service opening
    translate([-head_w / 2 + wall + 0.3, 1.5, 3])
      cube([head_w - 2 * wall - 0.6, head_d, head_h - 6]);
  }

  // board rails
  for (x = [-5, 5])
    translate([x - 0.6, -2.5, 4])
      cube([1.2, 5, head_h * 0.50]);
}

module head_lid() {
  difference() {
    union() {
      intersection() {
        capsule_body(head_w - 0.5, head_d - 0.5, head_h - 0.5);
        translate([-head_w, 2.0, 2.5])
          cube([head_w * 2, head_d, head_h - 5]);
      }
      translate([-head_w / 2 + wall + 0.5, 1.2, 3.5])
        cube([head_w - 2 * wall - 1.0, 1.4, head_h - 7]);
    }
    translate([0, head_d / 2 - 1, head_h / 2])
      rotate([90, 0, 0])
        cylinder(h = 4, d = 2.0);
  }
}

// ---- ASSEMBLY / PRINT PLATE ------------------------------------------------
module assembled() {
  color([0.22, 0.22, 0.24]) stem_outer();
  color([0.05, 0.55, 0.58])
    translate([0, 0, tip_h + stem_body_h])
      accent_ring();
  color([0.22, 0.22, 0.24])
    translate([0, 0, head_z0])
      head_shell();
}

module print_plate() {
  translate([0, 0, 0]) stem_outer();
  translate([stem_w / 2 + head_w / 2 + 10, 0, 0]) head_shell();
  translate([stem_w / 2 + head_w / 2 + 10, head_d + 14, 0])
    rotate([90, 0, 0]) head_lid();
  translate([stem_w / 2 + head_w + ring_od + 18, 0, 0]) accent_ring();
}

if (PART == "assembled") assembled();
else if (PART == "head") head_shell();
else if (PART == "ring") accent_ring();
else if (PART == "stem") stem_outer();
else if (PART == "lid") head_lid();
else if (PART == "print_plate") print_plate();
else assembled();
