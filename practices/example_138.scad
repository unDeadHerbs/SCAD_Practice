$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

p1=$preview?1+1/$fn:1;// A "one" over-cut for prettier previews.
module example_138(){
	major_radius=50;
	central_radius=25;
	module bracket(){
		h=30;
		length=75;
		slot_width=18;
		wall_thick=(40-slot_width)/4; // estimated
		width=slot_width+2*wall_thick;
		Cube([length,11/*overcut*/,width],center=X+Z+2*Y);
		difference(){
			Cube([length,h,width],center=X+Z);
			Cube([length-2*wall_thick,h,slot_width]*p1,center=X+Z);}}
	module axel(){
		annulus(or=35,ir=central_radius,h=90,center=true);}
	module socket(){
		thickness=40;
		module side_hole() annulus(or=20,ir=10,h=thickness,center=true);
		outer_hull(){
			annulus(or=major_radius,ir=central_radius,h=thickness,center=true);
			translate(85*X)
				side_hole();
			translate(-85*X)
				side_hole();}}
	translate(major_radius*Y)
		bracket();
	axel();
	socket();}

rotate(90*X)
	example_138();
