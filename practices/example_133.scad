$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_133(){
  side=120;
	rotate(90*X)
		difference(){
			// body
			Cube(side,center=true);
			// Square Hole
			Cube([side,50,50],center=true);
			// Center Circular Hole
			cylinder(d=30,h=side,center=true);
			// Top Circular Cut
			translate(side/2*Y)
				cylinder(d=25,h=side,center=true);
			// Bottom Circular Cut
			translate(-side/2*Y)
				cylinder(r=30,h=side,center=true);
			// Corners
			rotate(45*Z)
				set(4,r=sqrt(2)*side/2)
					rotate(45*Z)
	  				Cube([40,40,side],center=true);}}

example_133();
