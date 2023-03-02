$fn=100;
$vpt = [12,68,0];
$vpr = [30,0,90];
$vpd = 270;
use <../../lib.scad>

render(){
	for(i=[0:30:180])
		translate(right(3/4*i))
			annulus(ro=10,
							ri=5,
							t=5,
							theta=i,
							cut_tangent=true,
							cut_symmetric=true);

	for(i=[0:30:180])
		translate(right(3/4*i)+forward(24))
			annulus(ro=10,
							ri=5,
							t=5,
							theta=i*1.9,
							cut_symmetric=true);}
