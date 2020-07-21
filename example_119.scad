$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

module grid(directions,times){
     module itter(d,t){
     for(i=[0:t]){
	  translate(d*i){
	       children();}}}
     if(len(directions)==1){
	  itter(directions[0],times[0])children();}
	  else{
	       itter(directions[0],times[0]){
		    grid(pop(directions),pop(times)){
			 children();}}}}

module example_119(){
     length=200;
     width=100;
     thickness=20*mm;
     module plate(){
	  inset_x=25*mm;
	  inset_y=20*mm;
	  peg_dia=15;
	  difference(){
	       Cube([length,width,thickness]);
	       translate(inset_x*X+inset_y*Y)
	       grid([(length-2*inset_x)/3*X,(width-2*inset_y)*Y],[4,2])
		    wcylinder(d=peg_dia,h=thickness);}}
     module struts(){
	  strut_lenght=70;
	  end_curve=15;
	  pin_hole=7.5;
	  angle=145*degrees;
	  top_center=[length/2,width/2,thickness];
	  translate(top_center-thickness/2*Y){
	       rotate(-90*X){
		    cylinder(r=17.5*mm,h=thickness);}}
	  pair(0,center=top_center){
	       outer_hull(){
		    rotate(-(angle-90)*Y){
			 translate((width-thickness)/2*Y
				  +strut_lenght*Z
				  +end_curve*X){
			      rotate(-90*X){
				   annulus(ro=end_curve,ri=pin_hole,t=thickness);}}}
		    translate(thickness*Z+(width-thickness)/2*Y){
			 ramp(length/2,thickness,thickness);}}}
     }
     plate();
     struts();
}

example_119();

