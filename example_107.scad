$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_107(){
     small_axle_length=50*mm;
     large_axle_length=130*mm;
     small_hole_radius=9*mm;
     large_hole_radius=24*mm;

     module square_plate(){
	  thickness=20*mm;
	  edge_radius=10*mm;
	  hole_radius=5*mm;
	  side_lenght=50*mm;
	  rotate([90,0,0]){
	  difference(){
	       hull(){
		    rotate(45){
			 set(4,r=sqrt(2)*side_lenght/2){
			      cylinder(r=edge_radius,h=thickness);}}}
	       rotate(45){
		    set(4,r=sqrt(2)*side_lenght/2){
			 cylinder(r=hole_radius,h=thickness);}}
	       cylinder(r=small_hole_radius,h=thickness);}}}
     module double_axle(){
	  small_axle_radius=15*mm;
	  large_axle_radius=30*mm;
	  wall_thickness=6*mm;
	  rotate([-90,0,0]){
	  difference(){
	       union(){
		    cylinder(r=small_axle_radius,h=small_axle_length);
		    up(small_axle_length){cylinder(r=large_axle_radius,h=large_axle_length);}}
	       cylinder(r=small_hole_radius,h=small_axle_length+wall_thickness);
	       up(small_axle_length+wall_thickness){cylinder(r=large_hole_radius,h=large_axle_length-wall_thickness);}}}}
     module back_plate(){
	  thickness=20*mm;
	  inter_holes_radius=45*mm;
	  holes_radius=6*mm;
	  plate_radius=60*mm;
	  rotate([-90,0,0]){
	  difference(){
	       cylinder(r=plate_radius,h=thickness);
	       set(4,r=inter_holes_radius){
		    cylinder(r=holes_radius,h=thickness);}
	       cylinder(r=large_hole_radius,h=thickness);
	  }}
     }
     
     square_plate();
     double_axle();
     translate([0,small_axle_length+large_axle_length,0]) back_plate();
}

example_107();
