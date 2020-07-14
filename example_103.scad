$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_103(){
     inter_cylinder_distance=100*mm;
     side_length=50*mm;
     module both_sides(){
	  children();
	  translate([0,inter_cylinder_distance,0]){
		    rotate([0,90,0]){
			 children();}}}
     module shell(){
	  hull(){
	       both_sides(){
		    cylinder(r=side_length/2,h=side_length,center=true);}}}
     module slots(){
	  slot_height=20*mm;
	  both_sides(){
	       cube([side_length,side_length,slot_height],center=true);}
     }
     module pins(){
	  pin_radius=10*mm;
	  both_sides(){
	       cylinder(r=pin_radius,h=inter_cylinder_distance);}}
     difference(){
	  shell();
	  slots();
	  pins();}
}

example_103();
