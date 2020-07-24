$fn=100;
mm=1; // define units
degrees=1;

use <../lib.scad>

module example_101(){
     axial_radius = 30*mm;
     module handel(){
	  thickness=15*mm; // missing from Diagram
	  edge_radius=15*mm;
	  hole_radius=edge_radius/2;
	  hold_distance=150*mm;
	  difference(){
	       hull(){
		    cylinder(r=axial_radius,h=thickness);
		    pair(hold_distance)
			 cylinder(r=edge_radius,h=thickness);}
	       pair(hold_distance)
		    cylinder(r=hole_radius,h=thickness);}}
     module axle_key(){
	  length=75*mm;
	  slot_width=15*mm;
	  key_length=30*mm;
	  key_thickness=35*mm;
	  pin_radius=6*mm;
	  pin_height=60*mm;
	  difference(){
	       // axle
	       cylinder(r=axial_radius,h=length);
	       // slot
	       translate([-axial_radius,-slot_width/2,0])
		    cube([axial_radius*2,slot_width,length]);
	       // key
	       pair(key_thickness,90*degrees){
		    translate([0,-axial_radius,length-key_length]){
			 cube([/*overcut*/axial_radius,
			       /*overcut*/2*axial_radius,
			       key_length]);}}
	       // pin_hole
	       translate(up(pin_height)){
		    rotate([90,0,0]){
			 cylinder(r=pin_radius,h=/*overcut*/2*axial_radius,center=true);}}}}
     handel();
     axle_key();}

example_101();
