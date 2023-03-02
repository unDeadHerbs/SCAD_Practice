$fn=100;
$vpt=[0,0,0];
$vpr=[40,0,90];
$vpd=400;
use <../../lib.scad>

module block(){
	translate([0,-50,0]){
		cube([50,100,50]);}}

module claw(){
	render(){
		translate(forward(50)){
			annulus(ro=50,ri=25,t=50,
							cut_tangent=true,
							cut_symmetric=true);}}}

	color("green"){
		render(){
			outer_glue(){
				block();
				claw();}}}
