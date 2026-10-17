// LadderLevel Template C — includes vial clip + sling plate
use <ladder_level_B.scad>
// Additional clip for bubble vial
translate([220,0,0]) difference(){
  cube([40,20,18]);
  translate([5,5,5]) cube([30,10,20]);
  translate([20, -0.1, 9]) rotate([-90,0,0]) cylinder(h=25,r=6);
}
