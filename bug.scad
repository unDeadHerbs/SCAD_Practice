$fn=100;

module bug(){
     difference(){
	  translate([0,-100,0])
	       cube([40,100,10]);
	  translate([20,0,0]){
	       translate([0,-27,0]){
		    cylinder(d=15,h=12/*10*/);
		    translate([0,-50,0]){
			 cylinder(d=15,h=12/*10*/);}}}}}

bug();
translate([0,120,0]){
     render(){
	  bug();}}

