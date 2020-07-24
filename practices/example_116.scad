$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_116(){
     width=70*mm;
     top_length=100*mm;
     body_centers=30*mm;
     main_plate=10*mm;
     back_plate=30*mm;
     module top_pipe(){
	  translate(forward(width/4)){
	       rotate(90*X*degrees){
		    annulus(od=width/2,id=15*mm,h=top_length);}}}
     module front_pipe(){
	  dia=35*mm;
	  difference(){
	       translate(up(main_plate)){
		    rotate(90*Y*degrees){
			 annulus(od=dia,ri=10*mm,h=width,
				 cut_tangent=true,cut_symmetric=true);}}
	       Cube([width,dia,-dia],center=Y);}}
     module body_structure(){
	  height=60*mm;
	  corner_curve=10*mm;
	  full_lenght=170*mm;
	  hull(){
	       Cube([width,-back_plate,height/2]);
	       translate(up(height-corner_curve)+forward(corner_curve)){
		    rotate(90*X*degrees){
			 pair(width-2*corner_curve,edge=true){
			      cylinder(r=corner_curve,h=back_plate);}}}}
	  Cube([width,-top_length,body_centers]);
	  Cube([width,-full_lenght,main_plate]);}
     outer_glue(){
	  translate(up(body_centers)){
	       top_pipe();}
	  translate(up(body_centers)+forward(70/2)){
	       top_pipe();}
	  translate(left(135*mm)){
	       front_pipe();}
	  body_structure();}}

example_116();
translate([70,-170,-80]){
     rotate(180){
	  example_116();}}
