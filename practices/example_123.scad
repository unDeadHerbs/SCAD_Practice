$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_123(){
     module funnel(){
	  camshaft([40,60*Z,40,0*Z,55,20*Z,55,0*Z,70,20*Z,70]);}
     module fork(){
	  length=180;
	  cut_inset=55;
	  cut_curveture=15;
	  thickness=20;
	  difference(){
	       Cube([length,80,thickness],center=Y);
	       translate(length*X){
		    mirror(X){
			 arch(r=cut_curveture,h=cut_inset,t=thickness,bottom_edge=true);}}}}
     module pivot(){
	  width=40;
	  rad=20;
	  translate(rad*Z){
	       rotate([90,180,0]){
		    translate(-width/2*Z){
			 arch(r=rad,ri=12.5,h=110,t=width,bottom_edge=true);}}}}
     module hole(){
	  wcylinder(d=60,h=100);}
     difference(){
	  union(){
	       funnel();
	       fork();
	       pivot();}
	  hole();}}

example_123();

