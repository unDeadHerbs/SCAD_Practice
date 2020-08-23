$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_131(){
  hindge_inset=100-90+20-25; // hard_dim
  width=60;
  module bottom_body(){
    thickness=25;
    rad=width/2;
    length=100;
    module base_shape(){
      translate((length-rad)*X){
	outer_glue(){
	  annulus(ro=rad,id=18,t=thickness);
	  Cube([rad-length,width,thickness],center=Y);}}}
    module cuts(){
      translate((length-30)*X){
	Cube([30,width,4],center=Y);}
      translate(12*Z+50*X){
	Cube([50,width,13],center=Y);}}
    difference(){
      base_shape();
      cuts();}}
  module hindge(){
    cut_width=36;
    module base_shape(){
      outer_glue(){
	translate(10*X+65*Z){
	  rotate(90*X){
	    annulus(ro=20,id=20,t=width,center=true);}}
	translate(hindge_inset*X){
	  Cube([25,width,65],center=Y);}}
	Cube([hindge_inset,cut_width,40],center=Y);}
    module cut(){
      translate(-10*X+40*Z){
	  Cube([100/*overcut*/,cut_width,100/*overcut*/],center=Y);
      }
    }
    difference(){
      base_shape();
      cut();}}
  module central_hole(){
    translate(15*X){
	cylinder(d=15,h=40);}}
  difference(){
    union(){
      hindge();
      bottom_body();}
    central_hole();}}

example_131();
