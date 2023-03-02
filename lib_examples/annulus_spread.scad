$fn=100;
// 	 --camera=36,57,26,35,0,87,401
//$vpt = [12,0,0];
//$vpr = [52,0,15];
//$vpd = 75;
use <../lib.scad>

for(i=[0:30:180])
     translate(right(3/4*i))
	  annulus(ro=10,
		  ri=5,
		  t=5,
		  theta=i,
		  cut_tangent=true,
		  cut_symmetric=true);

for(i=[0:30:180])
     translate(right(3/4*i)+forward(25))
	  annulus(ro=10,
		  ri=5,
		  t=5,
		  theta=i*1.9,
		  cut_symmetric=true);
