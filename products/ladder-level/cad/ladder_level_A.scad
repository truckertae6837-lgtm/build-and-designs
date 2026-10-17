// LadderLevel Template A — Compact interlocking wedge (mm)
$fn=32;
L=160; W=70; Hmax=45; Hmin=8;
module wedge(teeth=true){
  difference(){
    linear_extrude(W) polygon([[0,0],[L,0],[L,Hmin],[0,Hmax]]);
    if(teeth) for(i=[0:14]) translate([12+i*9, Hmin+i*2.2, W/2-15])
      rotate([0,0,8]) cube([5,8,30], center=true);
    // pad recess
    translate([20,Hmax-3,10]) cube([80,4,W-20]);
  }
}
wedge();
translate([0,0,W+10]) mirror([0,0,1]) wedge();
translate([180,0,0]) cube([80,3,50]); // TPU pad blank
