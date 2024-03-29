/*
 * Sum all of the elements in a vector.
 */
function sum(x, i = 0) =
     len(x) <= i?0:
     x[i]+sum(x, i + 1);

/*
 * Pop one element off of the front of a list.
 */
function pop(list) =
     assert(len(list)>0)
     len(list)==1?[]:
     [for(i=[1:len(list)-1])
	       list[i]];

/*
 * Return the requested number of elements off of the front of a list.
 */
// TODO: Take negative for off of the back.
function take(count,list) =
     assert(count<=len(list))
     count==0?[]:
     [for(i=[0:count-1])
	       list[i]];

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
// TODO: This may be faster to return early in the case of large
// lists, how large?
function any(list) =
     [for(e=list)
	 if(e!=undef)
	    e
     ][0];
/*
 * Assert that exactly one element is non-undef and return it.
 */
function unique(list,message="") =
     assert(count_defined(list)==1,message)
     any(list);


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
     outer_glue(){
	  children();}
     difference(){
	  hull(){
	       outer_glue(){
		    children();}}
	  for(c=[0:$children-1]){
	       hull(){
		    children(c);}}}}



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
 * @param mirrored Make the left a mirror of the right instead of a
 *                rotation.
 * @param center The refrence locaiton for the pair.
 */
module pair(split,rot,edge=false,mirrored=true,
     radius,r,diameter,d,theta,center){
	rad=unique([split==undef?undef:split/2,radius,r,diameter,d==undef?undef:d/2],
		"Distance required.");
     angle=any([rot,theta,0]);
     module center(){
	  if(edge){
	       translate([abs(rad),0,0]){
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
     if(center!=undef){
	  translate(center){
	       pair(split,rad,theta=theta){
		    translate(-center){
			 children();}}}}
     else{
	  rotate([0,0,angle]){
	       center(){
		    translate([rad,0,0]){
			 children();}
		    translate([-rad,0,0]){
			 flip(){
			      children();}}}}}}

module xpair(split,rot=0,edge=false){
     pair(split,rot,edge){
	  children();}}
module ypair(split,rot=0,edge=false){
     rotate(90){
	  pair(split,rot,edge){
	       rotate(-90){
		    children();}}}}

module zpair(split,rot=0,edge=false){
     rotate(-90*Y){
	  pair(split,rot,edge){
	       rotate(90*Y){
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
// TODO: Add a theta for rotation offset.
module set(count,radius,
	   c,r,diameter,d){
     cnt=unique([count,c],
		"Count required.");
     rad=unique([radius,r,diameter==undef?undef:diameter/2,d==undef?undef:d/2],
		"Radius required.");
     for(i=[0:cnt]){
	  rotate([0,0,360/cnt*i]){
	       translate([rad,0,0]){
		    children();}}}}

// TODO: allow for the directions to be separate to the distance.
// TODO: Add a centered option?
module grid(directions,times=[2,2]){
     module itter(d,t){
     for(i=[0:t-1]){
	  translate(d*i){
	       children();}}}
     if(len(directions)==1){
	  itter(directions[0],times[0])children();}
	  else{
	       itter(directions[0],times[0]){
		    grid(pop(directions),pop(times)){
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
// TODO: Mark this as internal with an underscore?
module wcylinder(h,r,r1,r2,d,d1,d2,center){
     fix_delta=1;
     if(h<0){
	  mirror(Z){
	       wcylinder(h=-h,
			r=r,r1=r1,r2=r2,
			d=d,d1=d1,d2=d2);}}
     else if(center){
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
     else if(len(s)==undef){ // TODO: This warns, fix.
	  Cube([s,s,s],center);}
     else{
	  if(s[0]<0){
	       assert(center==false || center[0]==0,
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
     hull() // TODO: Fix the face turning order.
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
// TODO: Take an optional second center and make a slot.
// TODO: Make the cut mode a string and add a third mode for cut
// parallel to X axis.
		 module annulus(outer_radius,inner_radius,height,
										radius_outer,radius_inner,
										or,ro,od,ir,ri,id,h,thickness,t,center=false,
										theta,cut_tangent=false,cut_symmetric=false){
			 rad_out=unique([outer_radius,radius_outer,or,ro,od==undef?undef:od/2],
											"Outer radius required.");
			 rad_in=unique([inner_radius,radius_inner,ir,ri,id==undef?undef:id/2],
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
	    window_radius,w,ri,
     bottom_edge=false){
     rad=unique([radius,r],
		"Radius required.");
     hei=unique([height,h],
		"Height required.");
     th=unique([thickness,t],
	       "Thickness required.");
     wi=any([window_radius,w,ri]);
     module flip(){
	  if(bottom_edge){
	       translate((hei-rad)*X){
		    rotate(180*Z){
			 children();}}}
	  else{
	       children();}}
     flip(){
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
		    cube([hei-rad,2*rad,th]);}}}}


module ramp(length,height,width,center=false){
  // assert numbers
  translate((center?-width/2:0)*Y){
    polyhedron([[0,0,0],[length,0,0],[0,0,height],
		[0,width,0],[length,width,0],[0,width,height]],
	       [[2,1,0],[3,4,5],[0,1,4,3],[0,3,5,2],[1,2,5,4]]);}}

/*
 * This is an experimental section.
 */
module Square(size,center){
}

module thin(){
     linear_extrude(1/$fn){
	  children();}}

module CircleT(r){
     thin(){
	  circle(r);}}

module loft(){
     for(c=[0:$children-2]){
	  hull(){
	       children(c);
	       children(c+1);}}}

module camshaft(list){
     // assert (len(list)-1)%2=0,"Invalid camshaft.");
     if(len(list)>3){
	  translate(list[1]){
	       camshaft(pop(pop(list)));}
	  camshaft(take(3,list));}
     else if(len(list)==3){
	  //assert [0,2] numbers
	  assert(len(list[1])==3,"Invalid offset.");
	  // TODO: let the faces be more than circles?
	  //       Shapes can't be parameters
	  if(list[1]!=[0,0,0]){ // clip out empty spacers
	       loft(){
		    CircleT(list[0]);
		    translate(list[1]){
			 CircleT(list[2]);}}}}
     else{
	  assert(false,"That's just a cylinder.");}}


// TODO: I think I spotted a bug in this.  Make a ground truth ruler
// next to a slice to check.
module bent_plate(list,thickness,width,sirface="middle"){
     assert(sirface=="top","Other modes are TODO");
     assert(len(list)>0,"List needs to be an odd length.");
     T=unique([thickness],"Thickness required.");
     if(len(list)>1){
	  assert(len(list)>2,"Invalid input.");
	  assert(list[1]<=90 && list[1]>=-90,"Angles larger than 90 are TODO.");
	  // TODO: Turn the paper workings into some documenation for this.
	  I=sin(abs(list[1]))*T;
	  r=T*(1-cos(list[1]));
	  O=I-r/tan(abs(list[1]));
	  L=r/sin(abs(list[1]));
	  if(list[1]>0){
	       translate((list[0]+O)*X){
		    rotate(-list[1]*Y){
			 bent_plate(add(pop(pop(list)),
					[L]),
				    thickness,
				    width,
				    sirface);}}
	       Cube([list[0]+O,width,thickness]);}
	  else{
	       translate(r*Z-I*X){
		    translate(list[0]*X){
			 rotate(-list[1]*Y){
			      bent_plate(pop(pop(list)),
					 thickness,
					 width,
					 sirface);}}}
	       Cube([list[0],width,thickness]);}}
     else{
	  Cube([list[0],width,thickness]);}}

function add(list1,list2,sum=[])=
     assert(list1!=undef)
     assert(list2!=undef)
     assert(sum !=undef)
     len(list1)==0
     ?concat(sum,list2)
     :len(list2)==0
      ?concat(sum,list1)
      :add(pop(list1),pop(list2),concat(sum,[list1[0]+list2[0]]));
