// PlantSense Template A — Probe Stake (mm)
$fn=64;
H=180; W=18; D=12; wall=2;
module body(){
  difference(){
    hull(){ translate([0,0,0]) cube([W,D,8]); translate([2,1,H-10]) cube([W-4,D-2,10]); }
    translate([wall,wall,8]) cube([W-2*wall,D-2*wall,H-20]);
    // sensor pad windows at bottom/mid/top
    for(z=[30,90,150]) translate([-0.1,D/2-3,z]) cube([wall+0.2,6,10]);
    // USB slot
    translate([W/2-4,-0.1,H-16]) cube([8,wall+1,4]);
  }
}
module lid(){ difference(){ cube([W,D,wall+0.8]); for(x=[4,W-4]) for(y=[4,D-4]) translate([x,y,-0.1]) cylinder(h=5,r=1.1); } }
body();
translate([30,0,0]) lid();
