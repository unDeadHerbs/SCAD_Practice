$fn=100;
$vpt=[165,220,0];
$vpr=[40,0,90];
$vpd=1000;
use <../../lib.scad>

module claw(){
	render(){
		translate(forward(50)){
			annulus(ro=50,ri=25,t=50,
							cut_tangent=true,
							cut_symmetric=true);}}}

grid([forward(110),right(110)],[3,5]){
	claw();}
