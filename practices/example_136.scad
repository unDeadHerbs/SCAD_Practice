$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_136(){
	theta=120;
	thickness=10;
	outer_rad=30;
  inner_offset=thickness/tan(theta/2);
	module arc_plate(l,hole_pos){
		difference(){
			union(){
				translate((l-outer_rad)*X)
					cylinder(r=outer_rad,h=thickness);
				Cube([l-outer_rad,2*outer_rad,thickness],center=Y);}
			translate(hole_pos*X)
				wcylinder(d=15,h=thickness);}}
	module support(){
		right=[0,6,0]; left=-right; // thickness=12
		p_offset=[inner_offset,0,thickness];
		rotation=[-sin(theta-90),0,cos(theta-90)];
		p_upper=rotation*40+p_offset;
		p_base=[60,0,0]+p_offset;
		polyhedron([left+p_offset,left+p_upper,left+p_base,
								right+p_offset,right+p_upper,right+p_base],
							 [[0,1,2],[3,5,4],[5,2,1,4],[0,3,4,1],[3,0,2,5]]);}
	arc_plate(100,75+inner_offset);
	rotate(-theta*Y)
		translate(-thickness*Z)
			arc_plate(80,55+inner_offset);
	support();}

example_136();
