$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

p1=$preview?1+1/$fn:1;// A "one" over-cut for prettier previews.
module example_143(){
	length=295;
	width=150;
	plate_thickness=15;
	module base()
		difference(){
		Cube([length,width,plate_thickness],center=X+Y);
		pair(r=235/2){
			rotate(90*Z)
				pair(r=50)
					cylinder(d=18,h=plate_thickness*p1);
			arch_rad=15/*guessed*/;
			arch(r=arch_rad,h=30+arch_rad,t=plate_thickness*p1);}}
		module socket()
			translate(plate_thickness*Z)
				difference(){
					height=100;
					annulus(od=125,id=70,h=height);
					set(d=95,8)
						cylinder(d=13,h=height*p1);}
	base();
	socket();}

example_143();
