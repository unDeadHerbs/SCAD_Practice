$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>

module example_115(){
     height=60*mm;
     lenght=100*mm;
     width=140*mm;
     rad=25*mm;
     module block(){
	  hull(){
	       translate(left(lenght)+back(width/2-rad)){
		    cube([width-2*rad,1,height]);}
	       pair(width-2*rad,mirrored=true){
		    translate(up(height-rad)){
			 rotate([90]){
			      cylinder(r=rad,h=lenght-rad);}}
		    translate(left(lenght-rad)){
			 cylinder(r=rad,h=height-rad);}
		    translate(left(rad)){
			 cube(rad);}}}}
     module side_facet(){
	  back_wall=12*mm;
	  side_wall=5*mm;
	  bottom_wall=12*mm;
	  cut_depth=width/2-rad-side_wall;
	  translate(left(lenght)+up(bottom_wall)){
	       cube([cut_depth,
		     lenght-back_wall,
		     height-bottom_wall]);}

	  module peg(){cylinder(d=15*mm,h=bottom_wall);}
	  module slot(){
	       cube([25,back_wall,15]);}
	  translate(forward(cut_depth-20)){
	       translate(forward(-25/2)+left(back_wall)+up(22.5)){
		    slot();}
	       translate(left(27)){
		    peg();
		    translate(left(50)){
			 peg();}}}}
	  
     module axel(){
	  translate(up(height)){
	       rotate([90]){
		    cylinder(r=rad,h=lenght);}}}
     difference(){
	  block();
	  pair(60*mm,mirrored=true)
	       side_facet();
	  axel();}}

example_115();
