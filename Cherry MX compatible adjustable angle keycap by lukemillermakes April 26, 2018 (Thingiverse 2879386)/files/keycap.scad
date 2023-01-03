$fn=120;

module keycap1(angle){
$w = 13;
$r = 35;
union(){
translate([34.9,-73.7,0]) import ("./stemKey.stl");
rotate(a=angle,v=[0,1,0]){
difference(){
hull(){
cylinder(r=4,h=3.5);
minkowski(){
translate([0,0,1])cube([$w,$w,1],center=true);
cylinder(r=2,h=.5);
}
translate([0,0,-1])cylinder(r=6,h=3);
}
translate([0,0,-$r+.8]) sphere(r=$r);
}
}
translate([2.9,-.5,3.8]) cube([$w/2-1,1,4.5]);
}
}

$angle = 5;
rotate(a=90,v=[0,1,0]) keycap1($angle);
