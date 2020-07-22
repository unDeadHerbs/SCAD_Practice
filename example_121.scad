$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

// TODO: This needs cleaning up.
module example_121(){
     width=28*mm;
     rad=14;
     peg_hold=6;
     module slot_plate(){
	  thickness=8;
	  module nib(){
	       Cube([8/*missing*/,width,7],center=Y);
	  }
	  translate(-thickness*X+5*Z){
	       nib();}
	  rotate(90*Y){
	       translate(46*-X){
		    difference(){
			 arch(r=width/2,h=60,t=thickness);
			 hull(){
			      wcylinder(r=peg_hold,h=thickness);
			      translate(20*X){
				   wcylinder(r=peg_hold,h=thickness);}}}}}}
     module body(){
	  outer_glue(){
	       translate(28*X+rad*Z){
		    rotate(90*X){
			 annulus(ro=rad,ri=peg_hold,h=width,center=true);}}
	       Cube([28,width,28],center=Y);}}
     module bottom_plate(){
	  outer_glue(){
	  translate(-28*X){
	  annulus(ro=rad,ri=peg_hold,t=10);}
	  Cube([-28,width,10],center=Y);}}
     translate(width*Z)
	  slot_plate();
     body();
     bottom_plate();
     }

example_121();

