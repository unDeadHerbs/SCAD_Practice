module shape(){
     polyhedron([[0,0,0],[10,0,0],[0,0,10],
		 [0,10,0],[10,10,0],[0,10,10]],
		[[0,1,2],[3,4,5],[0,1,4,3],[0,3,5,2],[1,2,5,4]]);}

module pair(){
     children();
     translate([20,0,0]){
	       children();}}

module bug(){
     translate([12,0,0]){
	  cube([5,5,5]);}
     pair(){
	  shape();}}

module bug_with_hull(){
     translate([12,0,0]){
	  cube([5,5,5]);}
     pair(){
	  hull(){
	       shape();}}}

bug();

render(){
     translate([0,20,0]){
	  bug();}}

translate([0,40,0]){
     bug_with_hull();}
	  
render(){
     translate([0,60,0]){
	  bug_with_hull();}}
