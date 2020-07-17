$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>

module example_114(body_size=100*mm){
     module claw(has_claw=true,thickness=body_size/2)render(){
	  peg_percent=.5;
	  translate(down(thickness/2)){
	  outer_glue(){
	       translate(forward(body_size/2)){
		    annulus(ro=body_size/2,
			    ri=body_size/2*peg_percent,
			    t=thickness,
			    cut_tangent=has_claw,
			    cut_symmetric=has_claw);}
	       translate(body_size*[0,-1/2,0]){
		    cube([body_size/2,body_size,thickness]);}}}}
     module body(){
	  cube(body_size*[1,1,.5],
	       center=true);}
     body();
     pair(100){
	  claw();}
     translate(up(25*mm)){
	  rotate([90,-90,0]*degrees){
	       claw(thickness=30*mm);}}
     translate(down(25*mm)){
	  rotate([0,90,0]*degrees){
	       claw(false,30*mm);}}}

example_114();
