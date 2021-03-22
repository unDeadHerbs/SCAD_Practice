$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_140(){
	id=45;
	thickness=10;
	rad=125;
	module plate(){
	  outer_hull(){
			annulus(or=35,id=id,t=thickness);
			translate(65*X){
		    annulus(or=15,id=15,t=thickness);}
			translate(-65*X){
		    annulus(or=15,id=15,t=thickness);}}}
	module elbow_pipe(){
	  rotate(-90*Y){
			rotate_extrude(angle = 90){
		    translate(rad*X){
					projection(cut = true){
			      annulus(od=50,id=id,t=1/*arbitary*/,center=true);}}}}}
	translate(rad*Y-thickness*Z)
		plate();
	elbow_pipe();
	translate(2*rad*Z)
		rotate(180*X)
			elbow_pipe();
	translate(2*rad*Z-rad*Y)
			plate();}

example_140();

