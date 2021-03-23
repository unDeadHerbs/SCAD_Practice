$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

p1=$preview?1+1/$fn:1;// A "one" over-cut for prettier previews.
module example_142(){
	length=120;
	width=60;
	end_stop_thickness=10;
	thickness=10;
	module base()
		difference(){
			Cube([length,width,thickness],center=X+Y+2*Z);
			rotate(45*degrees*Z)
				set(4,r=width/sqrt(2)/2)
					translate(-thickness*Z)
						wcylinder(r=6,h=thickness);}
	module walls(){
		height=40;
		difference(){
			Cube([end_stop_thickness,width,height],
				center=Y);
			translate(height*Z)
				rotate(90*Y)
					arch(r=8,h=28,t=end_stop_thickness,bottom_edge=true);}}
	module square_facet()
		// Assuming the central hole doesn't go though the bottom plate.
		translate(-thickness*Z)
			//TODO: Replace with =center= when that exists on annulus.
			annulus(ro=width/2,ri=6*sqrt(2),h=thickness*2,$fn=4);
	base();
	pair(r=length/2-end_stop_thickness)
		walls();
	square_facet();}

example_142();
