$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module example_120(){
     thickness=10;
     width=70*mm;
     length=240*mm;
     module plate(){
	  Cube([length-5/*for curve*/,width,thickness],center=Y);}
     module ring(){
	  annulus(ro=50,id=35,t=thickness);}
     module strut(){
	  rad=20;
	  translate(thickness/2*Y-rad*X){
	       rotate(180*Z){
		    /*manual offset to embed in curve*/
		    translate(-6*X){
			 ramp(60+6,40+6,thickness);}}}
	  annulus(ro=rad,id=15,height=60);}
     module pin_shaft(){ // rename this
	  radius=25;
	  translate((length-radius)*X){
	       difference(){
		    translate(thickness*Z){
			 rotate(90*X){
			      translate(-width/2*Z){
				   annulus(ro=radius,id=10,t=width);}}}
		    Cube(width*[1,1,-1],center=X+Y);}}}
     outer_glue(){
	  ring();
	  translate(175*X+thickness*Z){
	       strut();}
	  pin_shaft();
	  plate();
     }
}

example_120();

