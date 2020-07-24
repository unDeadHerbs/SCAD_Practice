$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_126(){
     inter_centers=130;
     width=96;
     module side_plate(){
	  thickness=8;
	  hull(){
	       cylinder(r=40,h=thickness);
	       translate(inter_centers*X){
		    cylinder(r=20,h=thickness);}}}
     module major_axle(){
	  annulus(od=60,id=35,h=width,center=true);}
     module minor_axle(){
	  annulus(od=25,id=10,h=width,center=true);}
     outer_glue(){
	  major_axle();
	  translate(inter_centers*X){
	       minor_axle();}
	  zpair(50){
	       side_plate();}}}

example_126();

