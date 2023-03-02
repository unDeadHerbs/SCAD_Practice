// Animation: FPS:60 Frames:300
$fn=100;
$vpt = [12,0,0];
$vpr = [52,0,15];
$vpd = 75;
$vpf = 22;
use <../../lib.scad>

spin  = $t*360;
bounces = 4;
theta = sin($t*bounces*180)^2*180;

render(){
	rotate(spin*[0,0,1]){
		annulus(ro=10,
						ri=5,
						t=5,
						theta=theta,
						cut_tangent=true,
						cut_symmetric=true);}
	translate($vpt*2){
		rotate(spin*[0,0,1]){
			annulus(ro=10,
							ri=5,
							t=5,
							theta=theta*1.9,
							cut_symmetric=true);}}}
