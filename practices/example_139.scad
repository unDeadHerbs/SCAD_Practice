$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

p1=$preview?1+1/$fn:1;// A "one" over-cut for prettier previews.
module example_139(){
  radius=62.5;
	module periphery(){
		curveture=20;
		height=50;
		hull(){
			translate((height-curveture)*Z)
				rotate_extrude(angle=360)
					translate((radius-curveture)*X)
						circle(r=20);
			cylinder(r=radius,h=(height-curveture));}}
	module base(){
		thicness=12;
		difference(){
			cylinder(r=radius,h=thicness);
			cylinder(d=25,h=thicness*p1);
			set(count=3,r=45)
				cylinder(r=8,h=thicness*p1);}}
	module wing(){
		angle=120;
		length=100/*oversize*/;
		thicness=10;
		rotate(-angle/2*Z){
			Cube([length,thicness,length]);
			rotate((angle-90)*Z)
				Cube([thicness,length,length]);}}

	/* I interpret the 15deg indications as saying that the wings
	 * intersect the bounding circle at (0,1) and (1,0).  Working from
	 * the right center intersection.
	 *
	 * m=-tan(15)
	 * m=(0-p)/(r-p)
	 * d=\sqrt(2)*p
	 */
	m=-tan(15*degrees);
	corner_radius=sqrt(2)*radius*m/(m-1);
	
	intersection(){
		union(){
			base();
			set(3,corner_radius)
				wing();}
		periphery();}}

example_139();
