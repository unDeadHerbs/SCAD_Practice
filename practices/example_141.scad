$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

p1=$preview?1+1/$fn:1;// A "one" over-cut for prettier previews.
module example_141(){
	length=95;
	width=60;
	piller_thickness=15;
	r1=35;
	r2=20;
	edge_space=12.5; //esimated	
	module base()
		difference(){
		thickness=14;
			Cube([length,width,thickness],center=Y+2*Z);
			translate(-thickness*Z+40*X)
				Cube([15,width*p1,6],center=Y);}
	module piller(){
		height=76;
		translate((edge_space+r1)*X)
			difference(){
				Cube([piller_thickness,width,height],
						 center=Y);
				translate(height*Z)
					rotate(90*Y)
						arch(r=8,h=28,t=piller_thickness,bottom_edge=true);}}
	module curveB()
		translate(edge_space*X)
			difference(){
				Cube([r1,width,r1],center=Y);
				translate(r1*Z)
					rotate(90*X)
						cylinder(r=r1,h=width*p1,center=true);}
	module curveS()
		translate((edge_space+r1+piller_thickness)*X)
			difference(){
				Cube([r2,width,r2],center=Y);
				translate(r2*(X+Z))
					rotate(90*X)
						cylinder(r=r2,h=width*p1,center=true);}
	module socket()
		translate((edge_space+r1)*X)
			rotate(180*Z)
				arch(r=10,ri=5/*guessed*/,thickness=36,height=30,bottom_edge=true);
	base();
	piller();
	curveB();
	curveS();
	socket();}

example_141();
