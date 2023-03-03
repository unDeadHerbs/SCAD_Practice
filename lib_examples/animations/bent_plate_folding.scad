$fn=100;
$vpt=[120,170,0];
$vpr=[60,0,0];
$vpd=810;
use <../../lib.scad>

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

tr=sigmoid($t<.5?2*$t:1-2*($t-.5));

// length_1=sigmoid(segment(tr,0/8,1/8));
// bend_1  =sigmoid(segment(tr,1/8,2/8));
// length_2=sigmoid(segment(tr,2/8,3/8));
// bend_2  =sigmoid(segment(tr,3/8,4/8));
// length_3=sigmoid(segment(tr,4/8,5/8));
// bend_3  =sigmoid(segment(tr,5/8,6/8));
// length_4=sigmoid(segment(tr,6/8,7/8));
// bend_4  =sigmoid(segment(tr,7/8,8/8));

length_1=        segment(tr, 0/9,     2/9                              );
bend_1  =sigmoid(segment(tr,      1/9,    3/9                         ));
length_2=        segment(tr,          2/9,    4/9                      );
bend_2  =sigmoid(segment(tr,              3/9,    5/9                 ));
length_3=        segment(tr,                  4/9,    6/9              );
bend_3  =sigmoid(segment(tr,                      5/9,    7/9         ));
length_4=        segment(tr,                          6/9,        9/9  ); // Looks smoother when the sliding finishes at the end.
bend_4  =sigmoid(segment(tr,                              7/9,    9/9 ));

plate_up_length=50/sin(70);
bent_plate([50,
						bend_1*70,plate_up_length*length_1,
						bend_2*-70,35*length_2,
						bend_3*-70,plate_up_length*length_3,
						bend_4*70,50*length_4],
					 thickness=10,
					 width=100,
					 sirface="top");
