$fn=100;
$vpt=[120,170,0];
$vpr=[60,0,0];
$vpd=810;
use <../../lib.scad>

tr=$t<.5?2*$t:1-2*($t-.5);
function segment(t,s,e) =
	t<s
	?0
	:t>e
	?1
	:(t-s)/(e-s);
function sigmoid(t) =
	t<1/2
	?2*t^2
	:-2*t^2+4*t-1;

bend_1=sigmoid(segment(tr,0/4,1/4));
bend_2=sigmoid(segment(tr,1/4,2/4));
bend_3=sigmoid(segment(tr,2/4,3/4));
bend_4=sigmoid(segment(tr,3/4,4/4));

length=160;
plate_up_length=50/sin(70);
bent_plate([50,
						bend_1*70,plate_up_length,
						bend_2*-70,35,
						bend_3*-70,plate_up_length,
						bend_4*70,50],
					 thickness=10,
					 width=100,
					 sirface="top");
