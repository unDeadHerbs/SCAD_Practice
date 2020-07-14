$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_104(){
     body_thickness=50*mm;
     side_length=100*mm;
     module part_1(){
	  translate([body_thickness/2,0,0]){
	       children();}}
     module part_2(){
	  rotate([90,180,0]){
	       translate([body_thickness/2,0,0]){
		    children();}}}
     module body(){
	  cube([body_thickness,side_length,side_length],center=true);}
     module plate(){
	  thickness=30*mm;
	  translate([0,-side_length/2,-thickness/2]){
	       cube([side_length/2,side_length,thickness]);}
	  translate([side_length/2,0,0]){
	       cylinder(d=side_length,h=thickness,center=true);}}
     module washer(){
	  pin_hole=25*mm;
	  difference(){
	       plate();
	       translate([side_length/2,0,0]){
		    cylinder(r=pin_hole,h=body_thickness,center=true);}}}
     module claw(){
  	  pin_hole=25*mm;
	  difference(){
	       plate();
	       translate([side_length/2,0,0]){
		    hull(){
			 cylinder(r=pin_hole,h=body_thickness,center=true);
			 translate([body_thickness,0,0]){
			      cylinder(r=pin_hole,h=body_thickness,center=true);}}}}}
     union(){
	  body();
	  part_1() washer();
	  part_2() claw();}}

example_104();
