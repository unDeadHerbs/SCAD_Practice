$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_109(){
     inter_centers=180*mm;
     plate_thickness=20*mm;
     socket_thickness=60*mm;
     module plate(){
	  radius=75*mm;
	  hull(){
	  pair(inter_centers){
	  cylinder(r=radius,h=plate_thickness);}}}
     module top(){
	  radius_outer=35*mm;
	  radius_inner=20*mm;
	  depth=30*mm;
	  up(plate_thickness){
	       difference(){
		    hull(){
			 pair(inter_centers){
			      cylinder(r=radius_outer,h=socket_thickness);}}
		    up(socket_thickness-depth){
			 hull(){
			      pair(inter_centers){
				   cylinder(r=radius_inner,h=depth);}}}}}}
     module holes(){
	  big_radius=10*mm;
	  small_radius=7.5*mm;
	  module big_hole() cylinder(r=big_radius,h=plate_thickness);
	  module small_hole() cylinder(r=small_radius,h=plate_thickness+socket_thickness);
	  
	  tripple(inter_centers)
	       small_hole();
	  pair(110,90){
	       tripple(inter_centers,90){
		    big_hole();}}
     }
     difference(){
	  union(){
	       plate();
	       top();
	       }
	  holes();
     }
}

example_109();
