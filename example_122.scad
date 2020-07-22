$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module example_122(){
     length=280*mm;
     curveture=30;
     peg_hold=15;
     thickness=15;
     module base_atachment(){
	  ypair(length-curveture*2){
	       xpair(0){
		    arch(r=curveture,ri=peg_hold,
			 t=thickness,h=105,
			 bottom_edge=true);}}}
     cyl_rad=55;
     clip_inset=cyl_rad*(1-cos(asin(25/cyl_rad)));
     module c_clip(){
	  rad=cyl_rad;
	  //TODO: This should probably be made a mode of annulus.
	  difference(){
	       translate(rad*Z){
		    rotate(90*X){
			 annulus(ro=rad,ri=40,h=length,center=true);}}
	       // flat
	       translate(up(2*rad-clip_inset)){
		    Cube([50,length,clip_inset],center=X+Y);}
	       // cut
	       translate(up(rad)){
		    Cube([20,length,rad],center=X+Y);}}}
     module screw_clamps(){
	  translate(up(2*cyl_rad-clip_inset)){
	       ypair(140){
		    xpair(20){
			 rotate(-90*Y+180*Z){
			      arch(r=30,ri=peg_hold,
				   t=thickness,h=55+clip_inset,
				   bottom_edge=true);}}}}}
     base_atachment();
     c_clip();
     screw_clamps();}

example_122();

