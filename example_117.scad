$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module example_117(){
     length=150;
     width=100;
     thickness=15;
     module plate(){
	  peg_dia=15; // Assumed
	  peg_inset=forward(30)+right(20);
	  difference(){
	       cube([length,width,thickness]);
	       translate(peg_inset){
		    ypair(width-2*peg_inset[1],edge=true){
			 xpair(length-2*peg_inset[0],edge=true){
			      cylinder(d=peg_dia,h=thickness);}}}}}
     module supports(){
	  l=(width-thickness)/2;
	  height=20;
	  translate(forward((length-thickness)/2)
		    +right(l+thickness/2)
		    +up(thickness)){
	       rotate(-90){
		    xpair(thickness){
			 ramp(l,height,thickness);}}}}
     module strut(){
	  internal_strut_angle=150*degrees-90;
	  strut_length=80*mm;
	  terminal_radius=25*mm;
	  outer_hull(){
	       translate((width-thickness)/2*Y){
		    rotate(-internal_strut_angle*Y){
			 translate(strut_length*Z+terminal_radius*X){
			      rotate(-90*X){
				   annulus(ro=terminal_radius,id=20,h=thickness);}}}}
	       translate((width-thickness)/2*Y+up(thickness)){
		    ramp(length,thickness,thickness);}}}

     plate();
     supports();
     strut();
}

example_117();
