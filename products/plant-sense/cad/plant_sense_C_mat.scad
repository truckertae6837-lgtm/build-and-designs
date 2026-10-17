// PlantSense Template C — Under-pot mat
$fn=48;
difference(){
  hull(){ for(x=[0,120]) for(y=[0,120]) translate([x,y,0]) cylinder(h=6,r=8); }
  translate([10,10,2]) cube([100,100,5]);
  for(x=[30,60,90]) translate([x,60,-0.1]) cylinder(h=8,r=4);
}
