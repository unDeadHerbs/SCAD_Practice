$fn=100;
mm=1; // define units
degrees=1;

use <../lib.scad>;

module example_112(){
     shaft_radius=25*mm;
     wall_thickness=5*mm;
     plate_thickness=10*mm;
     module plate(){
	  plate_radius=50*mm;
	  difference(){
	       annulus(ro=plate_radius,
		       ri=shaft_radius-wall_thickness,
		       h=plate_thickness);
	       set(6,40*mm){
		    cylinder(d=11.8*mm,
			     h=plate_thickness);}}}
     module shaft(){
	  socket_length=35*mm;
	  shaft_length=45*mm;
	  socket_overlap=10*mm;
	  annulus(ro=shaft_radius,
		  ri=-wall_thickness,
		  h=shaft_length);
	  translate(up(shaft_length-socket_overlap)){
	       annulus(ro=shaft_radius+wall_thickness,
		       ri=-wall_thickness,
		       h=socket_length);}}
     plate();
     translate(up(plate_thickness)){
	  shaft();}}

example_112();
