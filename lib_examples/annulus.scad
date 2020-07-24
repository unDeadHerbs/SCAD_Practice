$fn=100;
use <../lib.scad>

render(){
     for(i=[0:30:180])
	  translate(right(2/3*i))
	       annulus(ro=10,
		       ri=5,
		       t=5,
		       theta=i,
		       cut_tangent=true,
		       cut_symmetric=true);
     for(i=[0:30:180])
	  translate(right(2/3*i)+forward(25))
	       annulus(ro=10,
		       ri=5,
		       t=5,
		       theta=i*1.9,
		       cut_symmetric=true);}
