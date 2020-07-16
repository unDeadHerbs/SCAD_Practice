$fn=100;
mm=1; // define units
degrees=1;

use <lib.scad>;

module example_110(){
     top_width=160*mm;
     length=105*mm;
     top_height=80*mm;
     bottom_height=60*mm;
     bottom_width=210*mm;
     module top_half(){
	  module socket(){
	       socket_height=50*mm;
	       translate([0,top_width/2,top_height-socket_height]){
		    translate([0,-90/2,0])cube([length,90,30]);
		    translate([0,-40/2,0])cube([length,40,socket_height]);
		    translate([length/2,0,0])cylinder(r=37.5,h=socket_height);}}
	  difference(){
	       cube([length,top_width,top_height]);
	       socket();
	  }
     }
     module bottom_half(){
	  difference(){
	       cube([length,bottom_width,bottom_height]);
	       translate([0,bottom_width/2,0])rotate([0,90])cylinder(r=45,h=length);
	  }
     }
     module supports(){
	  translate([length/2,bottom_width/2,bottom_height]){
	       pair(top_width,90){
		    translate([0,-25/2,0]){
			 rotate([0,-90,-90]){
			      linear_extrude(25){
				   polygon([[0,0],[top_height,0],[0,25]]);}}}}}}
     translate([0,(bottom_width-top_width)/2,bottom_height])top_half();
     bottom_half();
     supports();
}

example_110();
