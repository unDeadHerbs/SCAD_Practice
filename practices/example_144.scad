$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module _preview_cut() scale($preview?1+1/$fn:1) children();
module example_144(){
	// I'm not pleased with this, the numbers are too unlinked.
	shaft_size=50;
	plate_thickness=20;
	plate_length=100;
	module plate(){
		thickness=plate_thickness;
		plate_width=120;
		bevel=20; // guessed
		corner_depth=60; // guessed
		module base_shape()
			hull(){
				translate((plate_length-bevel)*Y)
					pair(plate_width-bevel*2)
						cylinder(r=bevel,h=thickness);
				translate(corner_depth*Y)
					Cube([plate_width,plate_length-bevel-corner_depth,thickness],center=X);
				cylinder(d=shaft_size,h=thickness);}
		module holes()
			pair(90)
				_preview_cut()
					cylinder(d=14,h=thickness);
		difference(){
			base_shape();
			translate(75*Y)
				holes();}}
	module socket()
		annulus(od=shaft_size,id=30,h=70);
	module strut(){
		height=45;//Ambiguous, interpreting as the bottom of the meniscus.
		overcut=1;
		thickness=10;
		length=plate_length-shaft_size/2;
		slope=height/length;
		translate(shaft_size/2*Y+plate_thickness*Z)
			rotate(90*Z)
				translate(-overcut*X)
				//TODO: center = Y
					ramp(length+overcut,(length+overcut)*slope,thickness,true);}
	plate();
	socket();
	strut();}

rotate(90*X)
example_144();
