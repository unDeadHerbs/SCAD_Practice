$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_105(){
     depth=100*mm;
     module plate(){
	  thickness=20*mm;
	  width=150*mm;
	  module notchs(){
	       inset=15*mm;
	       module notch(){
		    radius=7.5*mm;
		    cylinder(r=radius,h=thickness);
		    translate([0,-radius,0]){
			 cube([inset,2*radius,thickness]);}}
	       pair(width-2*inset,rot=90*degrees){notch();}
	  }
	  module body(){
	       wall_thickness=20*mm;
	       top_thickness=10*mm; // missing
	       translate([0,-width/2,0]){
		    difference(){
			 cube([depth,width,thickness]);
			 translate([wall_thickness,0,0]){
			      cube([depth-2*wall_thickness,
				    width,
				    thickness-top_thickness]);}}}}
	  difference(){
	       body();
	       translate([depth/2,0,0]){
		    notchs();}}}
     module cup(){
	  height=80*mm;
	  width=80*mm;
	  length=depth;
	  module shell(){
	       top_lip=20*mm;
	       front_lip=20*mm;
	       translate([0,-width/2,0]){
	       hull(){
		    cube([top_lip,width,height]);// backwall
		    cube([length,width,front_lip]);// bottom
	       }}}
	  module cutout(){
	       bottom_thickness=10*mm;
	       back_thickness=10*mm;
	       top_thickness=10*mm;
	       wall_thickness=10*mm;
	       translate([back_thickness,
			  -(width/2-wall_thickness),
			  bottom_thickness])
		    cube([length-back_thickness,
			  width-2*wall_thickness,
			  height-bottom_thickness-top_thickness]);}
	  module peg_hole(){
	       radius=15;
	       up(height/2){
		    rotate([0,90,0]){
			 cylinder(r=radius,h=/*overcut*/length,center=true);}}}
	  difference(){
	       shell();
	       cutout();
	       peg_hole();
	  }
     }
     translate([0,0,-20])plate();
     cup();}

example_105();
