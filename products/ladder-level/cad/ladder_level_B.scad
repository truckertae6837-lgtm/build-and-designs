// LadderLevel Template B — Heavy duty thicker walls
$fn=32;
L=190; W=85; Hmax=55; Hmin=10;
module wedge(){
  difference(){
    linear_extrude(W) polygon([[0,0],[L,0],[L,Hmin],[0,Hmax]]);
    for(i=[0:16]) translate([14+i*10, Hmin+i*2.4, W/2-20])
      rotate([0,0,8]) cube([6,10,40], center=true);
    translate([25,Hmax-4,12]) cube([100,5,W-24]);
  }
}
wedge();
translate([0,0,W+12]) mirror([0,0,1]) wedge();
