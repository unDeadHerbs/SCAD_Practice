$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_127(){
     width=48;
     module main_axle(){
	  difference(){
	       cylinder(d=width,h=70);
	       camshaft([15,15*Z,15,0*Z,6.5,40*Z,6.5,0*Z,15,15*Z,15]);}}
     module l_plate(){
	  llength=-60;
	  Cube([85,width,15],center=Y);
	  translate(70*X){
	       difference(){
		    Cube([15,width,llength],center=Y);
		    translate(llength*Z){
			 rotate([180,-90,0]){
			      arch(r=8,h=28,t=15,bottom_edge=true);}}}}}
     main_axle();
     l_plate();
}

example_127();

