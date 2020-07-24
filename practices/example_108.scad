$fn=100;
mm=1; // define units
degrees=1;

use <../lib.scad>;

module example_108(){
     plate_thickness=15*mm;
     plate_width=50*mm;
     module bottom_plate()
	  cube([/*plate_length*/200,
		plate_width,
		plate_thickness]);
     module support_strut(){
	  support_size=100*mm;
	  linear_extrude(15){
	       polygon([[0,0],[support_size,0],[0,support_size]]);}}
     module arc_plate(){
	  module slot(){
	       hull(){
		    pair(split=150*mm,rot=90,edge=true){
			 cylinder(r=11.75*mm,h=20*mm);}}}
	  nom_radius=200*mm;// Changed from 195.3 to match picture.
	  side=250;
	  difference(){
	       cube([side,side,plate_thickness]);
	       translate([plate_width/2,plate_width,0]){
		    slot();}
	       translate([side,side,0]){
		    cylinder(r=nom_radius,h=plate_thickness);}}}

     bottom_plate();
     translate([70,15+17.5,plate_thickness])rotate([90,0,0])support_strut();
     translate([50,0,265]){rotate([0,90,0]){arc_plate();}}
}

example_108();
