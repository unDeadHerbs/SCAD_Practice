$fn=100;
mm=1; // define units
degrees=1;

use <../lib.scad>;

module example_111(){
     disk_thickness=20*mm;
     plate_thickness=10*mm;
     plate_width=175*mm;
     depth=90*mm;
     height=80*mm;
     module disk(){
	  rotate([-90*degrees]){
	       cylinder(r=52.5,h=disk_thickness);}}
     module holes(){
	  rotate([-90*degrees]){
	       cylinder(r=15*mm,h=disk_thickness);
	       set(7,r=40*mm){
		    cylinder(r=6*mm,h=disk_thickness);}}}
     module frame(){
	  strut_thickness=10*mm; // missing from diagram
	  hole_space=depth-disk_thickness-plate_thickness;
    	  rotate([-90]){
	       ypair(height-2*strut_thickness){
		    translate([-plate_width/2,0,0]){
			 difference(){
			      cube([plate_width,10,depth]);
			      translate([strut_thickness,0,disk_thickness]){
				   cube([plate_width-2*strut_thickness,
					 10,
					 hole_space]);}}}}}}
     module plate(){
	  cube([plate_width,plate_thickness,height]);}

     difference(){
	  union(){
	       disk();
	       frame();
	       translate([-plate_width/2,depth-plate_thickness,-height/2]){
		    plate();}}
	  holes();}}

example_111();
