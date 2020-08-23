$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_133(){
  side=120;
  module body(){
    Cube(side,center=true);}
  module x_hole(){
    Cube([side,50,50],center=true);
  }
  module y_holes(){
    // Center Hole
    rotate(90*X){
      cylinder(d=30,h=side);}
    // Top Cut
    translate(side/2*Z){
      rotate(90*X){
	cylinder(d=25,h=side,center=true);}}
    // Bottom Cut
    translate(-side/2*Z){
      rotate(90*X){
	cylinder(r=30,h=side,center=true);}}
    // Corners
    rotate(90*X+45*Y){
      set(4,r=sqrt(2)*side/2){
	rotate(45*Z)
	  Cube([40,40,side],center=true);}}}
  difference(){
    body();
    x_hole();
    y_holes();}}

example_133();
