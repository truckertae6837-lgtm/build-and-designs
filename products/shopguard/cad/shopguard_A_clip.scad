// ShopGuard A — Belt clip body
$fn=64;
module body(){
  difference(){
    hull(){ cube([58,42,4]); translate([2,2,16]) cube([54,38,3]); }
    translate([4,4,3]) cube([50,34,14]);
    // SOS button well
    translate([22,30,16]) cylinder(h=5,r=6);
    // speaker holes
    for(x=[10:8:48]) for(y=[8:8:24]) translate([x,y,17]) cylinder(h=3,r=0.8);
    // USB
    translate([24,-0.1,7]) cube([10,3,4]);
  }
}
module clip(){ translate([18,-8,6]) cube([20,10,2.5]); translate([18,-10,0]) cube([20,2.5,12]); }
body(); clip();
translate([70,0,0]) cube([58,42,2.2]); // lid
