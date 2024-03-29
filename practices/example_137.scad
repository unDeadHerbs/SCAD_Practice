$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

p1=$preview?1+1/$fs:1;// A "zero" over-cut for prettier previews.
module example_137(){
	width=100*mm;
	block_length=60;
	module block(){
		height=50;
		length=block_length; // To hand out of env.
		difference(){
			Cube([width,length,height],center=X+Y);
			translate(height*Z)
				rotate(-90*degrees*X)
					cylinder(r=30,h=length*p1,center=true);
			slot_depth=15;
			translate((height-slot_depth)*Z)
				Cube([width*p1,30,slot_depth*p1],center=X+Y);}};
	module slat(){
		height=10;
		flat_length=10;
		// TODO: That =2*Y= is ugly.
		cut_heigt=2;
		side_width=30;
		difference(){
			union(){
				Cube([width,flat_length,height],center=X+2*Y);
				translate(-flat_length*Y)
					rotate(-90*degrees*Z)
						ramp(10,height,width,center=X);}
			translate(cut_heigt*Z)
				Cube([width-2*side_width,
							2*flat_length*p1,
							(height-cut_heigt)*p1],
						 center=X+2*Y);}};
	translate(block_length/2*Y)
		block();
	slat();}

example_137();
