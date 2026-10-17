$fn=64;
difference(){
  hull(){ cylinder(h=12,r=28); translate([0,0,0]) scale([1.3,0.7,1]) cylinder(h=12,r=28); }
  translate([0,0,-0.1]) cylinder(h=13,r=22);
  translate([-8,-40,3]) cube([16,20,8]);
}
