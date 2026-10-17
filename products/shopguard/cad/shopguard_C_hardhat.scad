$fn=48;
difference(){
  cube([50,35,18]);
  translate([2,2,2]) cube([46,31,20]);
  // brim clamp jaws
  translate([10,-8,6]) cube([30,10,4]);
}
translate([0,-12,0]) cube([50,6,18]);
