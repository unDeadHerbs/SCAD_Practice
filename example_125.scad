$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module example_125(){
     curve_rad=100;
     hole_dia=24;
     wall_thickness=3;
     module pipe(){
	  annulus(od=30,id=hole_dia,h=70);
	  difference(){
	       Cube([50,50,-wall_thickness],center=X+Y);
	       wcylinder(d=hole_dia,h=-wall_thickness);}}
     module curved_box(){
	  // Assuming square crossesction.
	  rotate(-90*X){
	       rotate_extrude(angle=-90){
		    translate((curve_rad-25)*X){
			 difference(){
			      translate(-25*Y)
				   square([50,50]);
			      translate(wall_thickness*X-25*Y){
				   square([50-2*wall_thickness,50-wall_thickness]);}}}}}}
     curved_box();
     translate(curve_rad*Z){
	  rotate(-90*Y){
	       pipe();}}
     translate(curve_rad*X){
	  mirror(Z){
	       pipe();}}
}

example_125();

