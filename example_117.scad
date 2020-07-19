$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module ramp(length,height,width){
     hull(){
	  polyhedron([[0,0,0],[length,0,0],[0,0,height],
		      [0,width,0],[length,width,0],[0,width,height]],
		     [[0,1,2],[3,4,5],[0,1,4,3],[0,3,5,2],[1,2,5,4]]);}}

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
	  internal_strut_angle=150*degrees;
	  strut_length=80*mm;
	  terminal_radius=25*mm;
	  center=strut_length*(sin(internal_strut_angle)*Z
			      +cos(internal_strut_angle)*X)
	        +terminal_radius*(sin(internal_strut_angle-90)*Z
				 +cos(internal_strut_angle-90)*X);
	  outer_hull(){
	       translate((width-thickness)/2*Y){
		    translate(center){
			 rotate(-90*X){
			      annulus(ro=terminal_radius,id=20,h=thickness);}}}
	       translate((width-thickness)/2*Y){
		    cube([length,thickness,thickness]);}}}

     plate();
     supports();
     strut();
}

example_117();
