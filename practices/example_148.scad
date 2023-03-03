$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

// This is similar to a vampire tap.
module example_148(){
	// I'm assuming that the center of the arch is on the surface.  This
	// is against my intuition but lines up with the diagram.
	width=50;
	module plate(){
		inter_hole=45+20;
		length=20+inter_hole;
		difference(){
			Cube([width,length,4],center=X+Y);
			ypair(inter_hole)
				wcylinder(d=10,h=4);
			ypair(length+10)
				xpair(width-10)
					rotate(-45*Z)
						Cube(10*sqrt(2),center=Y+Z);}}
	module arch()
		rotate([0,90,0])
			cylinder(h=width,r=22.5,center=true);
	module negative(){
		cylinder(d=15,h=50);
		rotate([0,90,0])
			wcylinder(h=width,r=17.5,center=true);
		Cube(100,center=X+Y+2*Z);}
	module shaft()annulus(id=30,od=35,h=45);

	difference(){
		union(){
			plate();
			arch();
			shaft();}
		negative();}}

example_148();
