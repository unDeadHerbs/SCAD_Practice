/*
 * Make a pair of an object.
 *
 * @param split The distance to seperate the pair.
 *
 * @param rot An optional amount to rotate the pair.
 *
 * @param edge Center on the left of the pair rather than the middle.
 *
 * @pair mirrored Make the left a mirror of the right instead of a
 *                rotation.
 */
module pair(split,rot=0,edge=false/*, mirrord=false*/){
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

module xpair(split,rot=0,edge=false){
     pair(split,rot,edge){
	  children();}}
module ypair(split,rot=0,edge=false){
     rotate(90){
	  pair(split,rot,edge){
	       rotate(-90){
		    children();}}}}

/*
 * Make a pair but with a middle element.
 *
 * @param split The distance to seperate the pair.
 *
 * @param rot An optional amount to rotate the pair.
 */
module tripple(split,rot=0){
     rotate([0,0,90]){
	  children();}
     pair(split,rot){
	  children();}}
/*
 * Make a set of objects in a circle.
 *
 * @param count The number of elements in the circle
 *
 * @param r The raius of the circle.
 */
module set(count,r){
     for(i=[0:count]){
	  rotate([0,0,360/count*i]){
	       translate([r,0,0]){
		    children();}}}}

module set_better(count,radius,r,diameter,d){
     module set_impl(count,r){
	  for(i=[0:count]){
	       rotate([0,0,360/count*i]){
		    translate([r,0,0]){
			 children();}}}}
     if(!count){
	  //error
     }
     if(radius){
	  if(r || diameter || d){
	       // error
	  }else{
	       set_impl(count,radius){
		    children();}}}
     if(r){
	  if(radius || diameter || d){
	       // error
	  }else{
	       set_impl(count,r){
		    children();}}}
     if(diameter){
	  if(radius || r || d){
	       // error
	  }else{
	       set_impl(count,diameter/2){
		    children();}}}
     if(d){
	  if(radius || r || diameter){
	       // error
	  }else{
	       set_impl(count,d/2){
		    children();}}}}

/*
 * A quick rename of translate along z.
 *
 * @param distance The distance to lift by.
 */
module up(distance){
     translate([0,0,distance]){
	  children();}}

module arch(radius,height,thickness){
     cylinder(r=radius,h=thickness);
     translate([0,-radius,0]){
	  cube([height-radius,2*radius,thickness]);}}


/*
 * An annulus.
 *
 * @param ro The outer radius.
 *
 * @param ri The inner radius.
 *
 * @param h The height of the annulus.
 */
module annulus(ro,ri,h){
     if(ri<0){
	  difference(){
	       cylinder(r=ro,h);
	       cylinder(r=ro+ri,h);}}
     else{
	  difference(){
	       cylinder(r=ro,h);
	       cylinder(r=ri,h);}}}
