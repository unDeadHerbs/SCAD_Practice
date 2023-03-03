$fn=100;
$vpt=[85,70,0];
$vpr=[60,0,0];
$vpd=400;
use <../../lib.scad>

length=160;
plate_up_length=50/sin(70);
bent_plate([50,
						70,plate_up_length,
						-70,35,
						-70,plate_up_length,
						70,50],
					 thickness=10,
					 width=100,
					 sirface="top");
