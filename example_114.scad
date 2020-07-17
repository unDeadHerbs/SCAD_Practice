$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>

module example_114(){
     body_size=100*mm;
     module claw(has_claw=true){
	  peg_percent=.5;
	  translate(down(body_size/2/2)){
	  outer_glue(){
	       translate(forward(body_size/2)){
		    if(has_claw){
			 annulus(ro=body_size/2,
				 ri=body_size/2*peg_percent,
				 t=body_size/2,
				 cut_tangent=true,
				 cut_sym=true);}
		    else{
			 annulus(ro=body_size/2,
				 ri=body_size/2*peg_percent,
				 t=body_size/2);}}
	       translate(body_size*[0,-1/2,0]){
		    cube(body_size*[1/2,1,1/2]);}}}}
     module body(){
	  cube(body_size*[1,1,.5],
	       center=true);}

     body();
     pair(100){
	  claw();}
     translate(up(25)){
	  rotate([90,-90,0]){
	       claw();}}
     translate(down(25)){
	  rotate([0,90,0]){
	       claw(false);}}}

example_114();
