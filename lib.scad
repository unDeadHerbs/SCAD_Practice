module pair(split,rot=0){
     rotate([0,0,rot]){
	  translate([split/2,0,0]){
	       children();}
	  translate([-split/2,0,0]){
	       rotate([0,0,180]){
		    children();}}}}

module set(count,r){
     for(i=[0:count]){
	  rotate([0,0,360/count*i]){
	       translate([r,0,0]){
		    children();}}}}
