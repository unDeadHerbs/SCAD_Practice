$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_112(){
     thin_shaft_length=45*mm;
     thick_shaft_length=35*mm;
     plate_thickness=10*mm;
     module body(){
	  module plate(){
	       difference(){
		    cylinder(r=50*mm,h=plate_thickness);
		    set(6,40*mm){
			 cylinder(d=11.8*mm,h=plate_thickness);}}}
	  module shaft(){
	       up(plate_thickness){
		    cylinder(r=25*mm,h=45*mm);
		    up(thin_shaft_length){
			 cylinder(r=30*mm,h=thick_shaft_length);}}}
	  plate();
	  shaft();}
     module core(){
	  overlap=10*mm;
	  inner_radius=20*mm;
	  socket_radius=25*mm;
	  inner_length=plate_thickness+thin_shaft_length+overlap;
	  socket_length=thick_shaft_length-overlap;
	  cylinder(r=inner_radius,h=inner_length);
	  up(inner_length){
	       cylinder(r=socket_radius,h=socket_length);}}
     difference(){
	  body();
	  core();}}

example_112();
