$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>

module example_113(){
     core_radius=40;
     lenght=50;
     edge_with=30*mm;
     module core(){
	  rotate([90]){
	       annulus(ro=core_radius,ri=30,h=lenght,center=true);}}
     module under_cut(){
	  cut_depth=5*mm;
	  cut_inset=5*mm; // hidden in diagram
	  cube([core_radius*2-cut_inset*2,
		lenght,
		2*cut_depth],
	       center=true);}
     module clip_to_top(){
	  translate(-core_radius*[1,1,1]){
	       cube([1,1,.5]*core_radius*2);}}
     module edges(){
	  thickness=20*mm;
	  peg_radius=7*mm;
	  pair(2*55){
	       rotate(180){
		    difference(){
			 arch(r=edge_with/2,
			      h=40*mm,
			      t=thickness,
			      w=peg_radius);}}}}
     module top(){
	  wall_thickness=5*mm;
	  size=[40,edge_with,20];
	  translate(up(core_radius)){
	       difference(){
		    cube(size,center=true);
		    translate([-20+wall_thickness,-edge_with/2+wall_thickness,0]){
			 cube([40-2*wall_thickness,
			       edge_with-2*wall_thickness,
			       10]);}}}}
     module top_hole(){
	  cylinder(d=15*mm,h=/*overcut*/50);}
     difference(){
	  union(){
	       core();
	       edges();
	       top();}
	  union(){
	       under_cut();
	       clip_to_top();
	       top_hole();}}}

example_113();
