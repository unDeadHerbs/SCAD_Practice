$fn=100;
mm=1; // define units
degrees=1;

include <lib.scad>

function add(list1,list2,sum=[])=
     len(list1)==0
     ?concat(sum,list2)
     :len(list2)==0
      ?concat(sum,list1)
      :add(pop(list1),pop(list2),concat(sum,[list1[0]+list2[0]]));

module bent_plate(list,thickness,width,sirface="middle"){
     assert(sirface=="top","Other modes are TODO");
     assert(len(list)>0,"List needs to be an odd length.");
     T=unique([thickness],"Thickness required.");
     if(len(list)>1){
	  assert(len(list)>2,"Invalid input.");
	  I=sin(-list[1]);
	  r=T*(1-cos(list[1]));
	  O=I-r/tan(-list[1]);
	  L=r/sin(-list[1]);
	  if(list[1]>0){
	  translate((list[0]+O)*X){
	       rotate(-list[1]*Y){
		    bent_plate(add(pop(pop(list)),
				    [L]),
			       thickness,
			       width,
			       sirface);}}}}
     Cube([list[0],width,thickness]);
     }
	  

module example_129(){
     width=125;
     module holes(){}
     module plate(){
	  plate_angle=atan(50/12.5);
	  plate_up_length=50/sin(plate_angle);
	  bent_plate([50,
		      plate_angle,plate_up_length,
		      -plate_angle,35,
		      -plate_angle,plate_up_length,
		      plate_angle,50],
		     thickness=10,
		     width=width,
		     sirface="top");
     }
     plate();
}

example_129();

echo([1,2,3]+[2]);
