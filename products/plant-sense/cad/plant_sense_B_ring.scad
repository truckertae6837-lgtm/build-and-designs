// PlantSense Template B — Ring around root ball
$fn=80;
R_out=55; R_in=42; H=14;
difference(){
  cylinder(h=H,r=R_out);
  translate([0,0,-0.1]) cylinder(h=H+0.2,r=R_in);
  for(a=[0,120,240]) rotate([0,0,a]) translate([R_in+4,0,3]) cube([8,6,8], center=true);
}
