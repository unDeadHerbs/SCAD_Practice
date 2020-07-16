$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_102(){
     length=100*mm;
     axial_radius = 25*mm;
     plate_spacing=85*mm;
     tube_radius=15*mm;
     module handel(){
	  thickness=15*mm;
	  edge_radius=12.5*mm;
	  hole_radius=5*mm;
	  hold_distance=100*mm;
	  difference(){
	       hull(){
		    cylinder(r=axial_radius,h=thickness);
		    pair(hold_distance)
			 cylinder(r=edge_radius,h=thickness);}
	       cylinder(r=tube_radius,h=length);
	       pair(hold_distance)
		    cylinder(r=hole_radius,h=thickness);}}
     module axle(){
	  annulus(ro=axial_radius,ri=tube_radius,h=length);}
     module plate(){
	  thickness=15*mm;
	  hole_radius=6*mm;
	  hole_spacing=35*mm;
	  difference(){
	       annulus(ro=50*mm,ri=tube_radius,h=thickness);
	       set(count=6,r=hole_spacing){
		    cylinder(r=hole_radius,h=thickness);}}}
     handel();
     axle();
     translate(up(plate_spacing)){
	  plate();}}

example_102();
