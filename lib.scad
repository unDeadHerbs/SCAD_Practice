module pair(split,rot=0,edge=false){
     module center(){
	  if(edge){
	       translate([split/2,0,0]){
		    children();}}
	  else{
	       children();}}
     rotate([0,0,rot]){
	  center(){
	       translate([split/2,0,0]){
		    children();}
	       translate([-split/2,0,0]){
		    rotate([0,0,180]){
			 children();}}}}}

module tripple(split,rot=0){
     rotate([0,0,90]){
	  children();}
     pair(split,rot){
	  children();}}

module set(count,r){
     for(i=[0:count]){
	  rotate([0,0,360/count*i]){
	       translate([r,0,0]){
		    children();}}}}

module up(distance){
     translate([0,0,distance]){
	  children();}}

module arch(radius,height,thickness){
     cylinder(r=radius,h=thickness);
     translate([0,-radius,0]){
	  cube([height-radius,2*radius,thickness]);}}
