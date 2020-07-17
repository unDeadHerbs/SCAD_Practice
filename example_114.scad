$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>

module example_114(){
     body_size=100*mm;
     module claw(c=true){
	  peg_percent=.5;
	  translate(forward(50)+down(25)){
	       rotate(180){
		    difference(){
			 arch(r=body_size/2,
			      w=body_size/2*peg_percent,
			      h=body_size,
			      t=body_size/2);
			 if(c){
			      hull(){
				   pair(d=-/*overcut*/body_size,edge=true){
					wcylinder(r=body_size/2*peg_percent,
						  h=body_size);}}}}}}}
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
