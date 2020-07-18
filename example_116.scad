$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module example_116(){
     width=70;
     top_length=100;
     body_centers=30;
     main_plate=10;
     module top_pip(){
	  translate(forward(width/4)){
	       rotate([90]){
		    annulus(od=width/2,id=15,h=top_length);}}}
     module front_pipe(){
	  dia=35;
	  difference(){
	       translate(up(main_plate)){
		    rotate(90*Y){
			 annulus(od=dia,ri=10,h=width,
				 cut_tangent=true,cut_symmetric=true);}}
	       Cube([width,dia,-dia],center=Y);}}
     back_plate=30;
     module body(){
	  height=60;
     	  corner_curve=10;
	  full_lenght=170;
	  hull(){
	  translate(up(height-corner_curve)+forward(corner_curve)){
	  rotate([90]){
	       pair(width-2*corner_curve,edge=true){
	       cylinder(r=corner_curve,h=back_plate);}}}
	  Cube([width,-back_plate,height/2]);}
	  Cube([width,-top_length,body_centers]);
	  Cube([width,-full_lenght,main_plate]);
     }
     outer_glue(){
	  translate(up(body_centers)){
	       top_pip();}
	  translate(up(body_centers)+forward(70/2)){
	       top_pip();}
	  translate(left(135)){
	       front_pipe();}
	  body();
	  }
}

example_116();
