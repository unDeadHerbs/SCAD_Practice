$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module example_118(){
     base_height=55*mm;
     plate_thickness=15*mm;
     module bracket(){
	  thickness=plate_thickness;
	  width=70*mm;
	  height=base_height;
	  length=180*mm;
	  top_lenght=80*mm;
	  afixment_lengh=(length-top_lenght)/2;
	  module plate(){
	       translate(up(base_height)){
		    Cube([top_lenght,width,-thickness],center=X+Y);}}
	  module wall(){
	       Cube([thickness,width,height],center=Y);}
	  module afixment(){
	       hole_radius=10*mm;
	       slot_height=20*mm;
	       difference(){
		    Cube([afixment_lengh,width,thickness],center=Y);
		    translate(forward(afixment_lengh-slot_height)){
			 arch(r=hole_radius,
			      h=slot_height+hole_radius,
			      t=thickness);}}}
	  plate();
	  pair(top_lenght){
	       wall();
	       afixment();}}
     module nozzel(){
	  cylinder(r1=20*mm,r2=35*mm,h=50*mm);}
     module nozzel_hole(){
	  camshaft([         8*mm,
		    30*mm*Z, 8*mm,
		    15*mm*Z,15*mm,
		    20*mm*Z,15*mm]);}
     difference(){
	  union(){
	       bracket();
	       translate(up(base_height)){
		    nozzel();}}
	  translate(up(base_height-plate_thickness)){
	       nozzel_hole();}}}

example_118();

