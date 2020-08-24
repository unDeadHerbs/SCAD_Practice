$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module point(vec){
  // Move the object so that [0,0,0] is at =vec=, rotating the object
  // along the smallest arch to reach there.
  
  // assert only one child
  // assert not [0,0,0]
  // assert not [-x,0,0]

  angle=acos(vec[0]/
	       sqrt(vec[0]*vec[0]+vec[1]*vec[1]+vec[2]*vec[2]));
  normal=[0,vec[2],-vec[1]];
  
  translate(vec){
    rotate(a=-angle,v=normal){
      children();}}}

module example_134(){
  side=150;
  plane_vec=([1,1,1]/sqrt(3)*[150/2,150/2,150/2-80])*[1,1,1]/sqrt(3);
  echo(plane_vec);
  cut_apothem=20;
  difference(){
    Cube(side,center=true);
    point(plane_vec){
      Cube(side/*overcut*/,center=Y+Z);}
    point(-plane_vec){
      Cube(side/*overcut*/,center=Y+Z);}
    point(plane_vec){
      rotate(90*Y){
	cylinder(r=15,h=side*5/*overcut*/,center=true);}}}}

example_134();
