$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

function add(list1,list2,sum=[])=
     assert(list1!=undef)
     assert(list2!=undef)
     assert(sum !=undef)
     len(list1)==0
     ?concat(sum,list2)
     :len(list2)==0
      ?concat(sum,list1)
      :add(pop(list1),pop(list2),concat(sum,[list1[0]+list2[0]]));

// TODO: While working on 139, I think I spotted a bug in this.  Make
// a ground truth ruler next to a slice to check.
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

module example_129(){
     width=125;
     length=160;
     height=60;
     thickness=10;
     module holes(){
	  inset=25;
	  translate(inset*(X+Y)){
	  grid([(width-inset*2)*Y,(length-inset*2)*X]){
	       wcylinder(h=thickness,r=10);}}}
     module plate(){
	  difference(){
	       plate_angle=atan(50/12.5);
	       plate_up_length=50/sin(plate_angle);
	       bent_plate([50,
			   plate_angle,plate_up_length,
			   -plate_angle,35,
			   -plate_angle,plate_up_length,
			   plate_angle,50],
			  thickness=thickness,
			  width=width,
			  sirface="top");
	       translate(width/2*Y+height/2*Z)
		    Cube([length,50,25],center=Y+Z);}}
     difference(){
	  plate();
	  holes();}
}

example_129();
