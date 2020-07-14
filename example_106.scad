$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_106(){
     body_thickness=50*mm;
     body_width=200*mm;
     top_width=200*mm;
     body_length=500*mm;
     module body(){
	  module plate(){
	       mid_thickness=40*mm;
	       edge_thickness=25*mm;
	       hull(){
		    translate([0,-top_width/2,0]){
			 cube([body_width,top_width,mid_thickness]);}
		    translate([0,-body_length/2,0]){
			 cube([body_width,body_length,edge_thickness]);}}}
	  module side_notchs(){
	       depth=60*mm;
	       radius=25*mm; // unlabeled
	       pair(500-2*depth,90*degrees)
		    arch(radius,depth+radius,body_thickness);}
	  difference(){
	       plate();
	       translate([body_width/2,0,0]){side_notchs();}}}
     module top_facet(){
	  major_radius=top_width/2;
	  pin_radius=50*mm;
	  pin_elevation=150*mm;
	  back_thickness=30*mm;
	  top_thickness=50*mm;
	  difference(){
	       up(pin_elevation){
		    rotate([0,90,0]){
			 difference(){
			      arch(major_radius,pin_elevation+major_radius,body_width);
			      cylinder(r=pin_radius,h=body_width);}}}
	       translate([back_thickness,-top_width/2,top_thickness]){
		    cube([body_width-back_thickness,top_width,pin_elevation+major_radius-top_thickness]);}}}
     module body_notch(){
	  radius=40;
	  depth=100;
	  height=30;
	  elevation=20;
	  translate([body_width-depth,0,elevation]){
	       arch(radius,depth+radius,height);}}
     difference(){
	  union(){
	       body();
	       top_facet();}
	  body_notch();}}

example_106();
