$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_132(){
  length=100;
  module body(){
    rotate(90*X){
      annulus(od=75,id=45,t=length,center=true);}}
  module facet(){
    afixment_width=40;
    length=80;
    width=47;
    module top(){
      difference(){
	outer_hull(){
	  translate(100*Z){
	    rotate(90*X){
	      annulus(od=35,id=20,t=length,center=true);}}
	  translate(50*Z){
	    xpair(0){
	      // Using a ramp here just for the point.
	      ramp(width/2,1,length,center=true);}}}
	translate(60*Z){
	  Cube([width/*overcut*/,40,60/*overcut*/],center=X+Y);}}}
    module base(){
      Cube([width,afixment_width,50],center=X+Y);}
    top();
    base();}
  outer_glue(){
    body();
    facet();}}

example_132();
