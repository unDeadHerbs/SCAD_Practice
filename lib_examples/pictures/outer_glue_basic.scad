$fn=100;
$vpt=[0,150,0];
$vpr=[40,0,90];
$vpd=800;
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

translate(right(300)){
	color("green"){
		render(){
			outer_glue(){
				claw();
				block();}}}}

translate(right(150)){
	color("red"){
		claw();}}

color("blue"){
	block();}
