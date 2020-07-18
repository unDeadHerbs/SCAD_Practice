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


X=[1,0,0];
Y=[0,1,0];
Z=[0,0,1];

/*
 * Glue each child onto the outside of the priors.
 *
 * TODO: The outside is currently defined by =hull= and this isn't
 * best.
 *
 * TODO: Make a better name.
 */
module outer_glue()
     for(c=[0:$children-1])
	  difference(){
	       children(c);
	       if(c!=0)
		    for(co=[0:c-1])
			 hull()
			      children(co);}


// This doesn't work because children aren't connected.

module outer_hull(){
     outer_glue()children();
     difference(){
	  hull()outer_glue()children();
	  for(c=[0:$children-1])hull()children(c);}}



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
	       mirror([1,0,0]){
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
 * @param split The distance to separate the pair.
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
function _move(distance)=
     unique([distance],"Distance required.");
function up(distance)=
     _move(distance)*Z;
function down(distance)=
     _move(-distance)*Z;
function right(distance)=
     _move(distance)*Y;
function left(distance)=
     _move(-distance)*Y;
function forward(distance)=
     _move(distance)*X;
function back(distance)=
     _move(-distance)*X;

/*
 * A copy of =cylinder= that is slightly taller so that =difference=
 * doesn't cause graphical glitches.
 */
module wcylinder(h,r,r1,r2,d,d1,d2,center){
     fix_delta=1;
     if(center){
	  cylinder(h=h+fix_delta,
		   r=r,r1=r1,r2=r2,
		   d=d,d1=d1,d2=d2,
		   center=true);}
     else{
	  translate(down(fix_delta)){
	       cylinder(h=h+2*fix_delta,
			r=r,r1=r1,r2=r2,
			d=d,d1=d1,d2=d2);}}}

module Cube(size,center=[0,0,0]){
     s=unique([size],"Size required.");
     if(center==true){
	  Cube(s,X+Y+Z);}
     else if(center==false){
	  Cube(s);}
     else if(len(s)==undef){
	  Cube([s,s,s],center);}
     else{
	  if(s[0]<0){
	       assert(center==false || center[0]!=0,
		    "Can't center and flip along the same axis.");
	       translate(X*s[0]){
		    Cube([-s[0],s[1],s[2]],center);}}
	  else if(s[1]<0){
	       assert(center==false || center[1]==0,
		      "Can't center and flip along the same axis.");
	       translate(Y*s[1]){
		    Cube([s[0],-s[1],s[2]],center);}}
	  else if(s[2]<0){
	       assert(center==false || center[2]==0,
		      "Can't center and flip along the same axis.");
	       translate(Z*s[2]){
		    Cube([s[0],s[1],-s[2]],center);}}
	  else translate([for(i=[0:2])-1/2*s[i]*center[i]]){
		    cube(s);}}}

/*
 * Mirror the children around a plane.
 */
module Mirror(normalVector,radius=0){
     translate(radius*normalVector){
	  mirror(normalVector){
	       translate(-radius*normalVector){
		    children();}}}}

/*
 * Make a parallelepiped out of three three-vectors.
 */
module parallelepiped(v1,v2,v3)
     hull() // Not sure why this is needed.
	  polyhedron([0*v1,v1,v1+v2,v2,v3,v3+v1,v3+v1+v2,v3+v2],
		     [[0,1,2,3],[4,5,6,7],[0,1,5,4],
		      [3,2,6,7],[0,3,7,4],[1,5,6,2]]);

/*
 * An annulus.
 *
 * @param outer_radius The outer radius.
 *        radius_outer
 *        ro
 *        od
 *
 * @param inner_radius The inner radius.
 *        radius_inner
 *        ri
 *        id
 *
 * @param thickness The height of the annulus.
 *        height
 *        t
 *        h
 *
 * @param center TODO
 *
 * @param theta An optional angle of exclusion.
 *              TODO: Have an inclusion mode.
 *
 * @param cut_tangent If the cut should be tangent to the center cut
 *                    instead of radial.  NOTE: If this is specified
 *                    but theta is not then the internal radius is
 *                    used.
 *
 * @param cut_symmetric If the cut should be symmetric about the X axis.
 */

// TODO: have an optional 2D child to shape the annulus's profile,
// this is in conflict with the radial parameters, as they define the
// shape.
module annulus(outer_radius,inner_radius,height,
	       radius_outer,radius_inner,
	       ro,od,ri,id,h,thickness,t,center=false,
	       theta,cut_tangent=false,cut_symmetric=false){
     rad_out=unique([outer_radius,radius_outer,ro,od/2],
		    "Outer radius required.");
     rad_in=unique([inner_radius,radius_inner,ri,id/2],
		   "Inner radius required.");
     hei=unique([height,h,thickness,t],
		"Height required.");

     module cutter(t,sym=true){
	  if(t>180){
	       assert(cut_tangent==false,
		      "Tangent cuts currently can't be over 180 degrees.");}
	  if(sym && cut_symmetric){
	       cutter(t/2,false);
	       mirror([0,1,0]){
		    cutter(t/2,false);}}
	  else if(t>90){
	       cutter(90,false);
	       rotate(90){
		    cutter(t-90,false);}}
	  else{
	       if(center){
		    translate(down(hei/2)){
			 parallelepiped(hei*[0,0,1],
					rad_out*[1,0,0],
					rad_out*[cos(t),sin(t),0]);}}
	       else{
		    parallelepiped(hei*[0,0,1],
				   rad_out*[1,0,0],
				   rad_out*[cos(t),sin(t),0]);}}}
     // If cut_tangent but no theta, then use the internal radius.
     if((cut_tangent) && (theta==undef)){
	  annulus(ro=rad_out,ri=rad_in,h=hei,center=center,
		  theta=2*asin(rad_in/rad_out),
		  cut_tangent=true,
		  cut_symmetric=cut_symmetric);}
     else if(theta!=undef){
	  difference(){
	       annulus(ro=rad_out,ri=rad_in,h=hei,center=center);
	       if(cut_tangent){
		    hull(){
			 wcylinder(r=rad_in,h=hei,center=center);
			 intersection(){
			      cutter(theta);
			      cylinder(r=rad_out,h=hei,center=center);}}
	       }
	       else{
		    cutter(theta);}}}
     else if(rad_in<0){
	  difference(){
	       cylinder(r=rad_out,h=hei,center=center);
	       wcylinder(r=rad_out+rad_in,h=hei,center=center);}}
     else{
	  difference(){
	       cylinder(r=rad_out,h=hei,center=center);
	       wcylinder(r=rad_in,h=hei,center=center);}}}

/*
 * A rectangle with a circular end.
 *
 * TODO: remake as outer_glue and annulus.
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
	  if(wi<0){
	       arch(r=rad,h=hei,t=th,w=r-wi);}
	  else{
	       difference(){
		    arch(r=rad,h=hei,t=th);
		    wcylinder(r=wi,h=th);}}}
     else{
	  cylinder(r=rad,h=th);
	  translate([0,-rad,0]){
	       cube([hei-rad,2*rad,th]);}}}
