$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module example_128(){
     width=75;
     module hook_plate(){
	  height=100;
	  difference(){
	  translate(up(height)){
	  mirror(Z){
	  Cube([10,width,height]);
	  Cube([30,width,10]);
	  translate(10*Z+20*X){
	  ramp(10,30,width);}}}
	  translate(37.5*Y+40*Z){
	  rotate(90*Y){
	  wcylinder(h=10,d=25);}}}}
     module base(){
	  mirror(Y){
	       rotate(90*X){
		    linear_extrude(width){
			 polygon([[0,0]
				 ,[0,30]
				 ,[80,30]
				 ,[145,10]
				 ,[210,30]
				 ,[210,0]]);}}}}
     translate(up(30)){
	  pair(-80,edge=true){
	       hook_plate();}}
     base();
}

example_128();

