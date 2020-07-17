/*
 * Sum all of the elements in a vector.
 */
function sum(x, i = 0)=
     len(x) > i
     ?x[i]
      +sum(x, i + 1)
     :0;
/*
 * Count the number of non-undef elements of a list.
 */
function count_defined(list) =
     sum([
      for (e=list)
	   if(e!=undef)
	      1]);
/*
 * Return the first non-undef element, if there is one.
 */
function any(list) =
     [for(e=list)
	 if(e!=undef)
	    e
     ][0];
/*
 * Assert that exactly one element is non-undef and return it.
 */
function unique(list,message) =
     message
     ?assert(count_defined(list)==1,message)
      any(list)
     :any(list);


/*
 * A copy of =cylinder= that is slightly taller so that =difference=
 * dosen't cause graphical glitches.
 */
module wcylinder(h,r,r1,r2,d,d1,d2,center){
     fix_delta=1;
     if(center){
	  cylinder(h=h+fix_delta,r=r,r1=r1,r2=r2,d=d,d1=d1,d2=d2,center=center);}
     else{
	  translate(down(fix_delta)){
	       cylinder(h=h+2*fix_delta,r=r,r1=r1,r2=r2,d=d,d1=d1,d2=d2,center=center);}}}

/*
 * Make a pair of an object.
 *
 * @param split The distance to separate the pair.
 *        radius
 *        diameter
 *        r
 *        d
 *
 * @param rot An optional amount to rotate the pair.
 *        theta
 *
 * @param edge Center on the left of the pair rather than the middle.
 *
 * @pair mirrored Make the left a mirror of the right instead of a
 *                rotation.
 */
module pair(split,rot,edge=false,mirrored=false,
     radius,r,diameter,d,theta){
     rad=unique([split/2,radius,r,diameter,d/2],
		"Distance required.");
     angle=any([rot,theta,0]);
     module center(){
	  if(edge){
	       translate([rad,0,0]){
		    children();}}
	  else{
	       children();}}
     module flip(){
	  if(mirrored){
	       mirror([0,1,0]){
		    children();}}
	  else{
	       rotate([0,0,180]){
		    children();}}}
     rotate([0,0,angle]){
	  center(){
	       translate([rad,0,0]){
		    children();}
	       translate([-rad,0,0]){
		    flip(){
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
 * @param r The radius of the circle.
 */
module set(count,radius,
	   c,r,diameter,d){
     cnt=unique([count,c],
		"Count required.");
     rad=unique([radius,r,diameter/2,d/2],
		"Radius required.");
     for(i=[0:cnt]){
	  rotate([0,0,360/cnt*i]){
	       translate([rad,0,0]){
		    children();}}}}

/*
 * A quick rename of translate along z.
 *
 * @param distance The distance to lift by.
 */
function up(distance)=
     [0,0,unique([distance],"Distance required.")];
function down(distance)=
     up(-distance);
function right(distance)=
     [0,unique([distance],"Distance required."),0];
function left(distance)=
     right(-distance);
function forward(distance)=
     [unique([distance],"Distance required."),0,0];
function back(distance)=
     forward(-distance);

/*
 * A rectangle with a circular end.
 */
module arch(radius,height,thickness,
	    r,h,t,
	    window_radius,w){
     rad=unique([radius,r],
		"Radius required.");
     hei=unique([height,h],
		"Height required.");
     th=unique([thickness,t],
	       "Thickness required.");
     wi=any([window_radius,w]);
     if(wi){
	  difference(){
	       arch(r=rad,h=hei,t=th);
	       wcylinder(r=wi,h=th);}}
     else{
	  cylinder(r=rad,h=th);
	  translate([0,-rad,0]){
	       cube([hei-rad,2*rad,th]);}}}


/*
 * An annulus.
 *
 * @param outer_radius The outer radius.
 *        radius_outer
 *        ro
 *
 * @param inner_radius The inner radius.
 *        radius_inner
 *        ri 
 *
 * @param height The height of the annulus.
 *        h
 */
module annulus(outer_radius,inner_radius,height,
	       radius_outer,radius_inner,
	       ro,ri,h,center=false){
     rad_out=unique([outer_radius,radius_outer,ro],
		    "Outer radius required.");
     rad_in=unique([inner_radius,radius_inner,ri],
		   "Inner radius required.");
     hei=unique([height,h],
		"Height required.");
     if(rad_in<0){
	  difference(){
	       cylinder(r=rad_out,h=hei,center=center);
	       wcylinder(r=rad_out+rad_in,h=hei,center=center);}}
     else{
	  difference(){
	       cylinder(r=rad_out,h=hei,center=center);
	       wcylinder(r=rad_in,h=hei,center=center);}}}
