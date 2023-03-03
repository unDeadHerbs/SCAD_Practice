$fn=100;
$vpt=[0,0,0];
$vpr=[40,0,90];
$vpd=800;
use <../../lib.scad>

module claw(){
	render(){
		translate(forward(50)){
			annulus(ro=50,ri=25,t=50,
							cut_tangent=true,
							cut_symmetric=true);}}}

set(5,50){
	claw();}
