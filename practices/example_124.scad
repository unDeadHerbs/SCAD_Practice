$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_124(){
     id=45;
     thickness=10;
     rad=125;
     module botom_plate(){
	  difference(){
	       annulus(od=90,id=id,t=thickness);
	       set(4,d=70)wcylinder(d=10,h=thickness);}}
     module front_plate(){
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
     translate(rad*Y){
	  botom_plate();}
     translate(rad*Z){
	  rotate(90*X){
	       front_plate();}}
     elbow_pipe();}

example_124();

