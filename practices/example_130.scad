$fn=100;
mm=1; // define units
degrees=1;

include <../lib.scad>

module example_130(){
  length=250*mm;
  height=125*mm;
  width=75*mm;
  module body(){
    Cube([length,width,height],center=Y);}
  module bottom_slot(){
    depth=13;
    inset=8;
    t_width=35;
    cut_width=20;
    Cube([length,cut_width,inset],center=Y);
    translate(up(inset)){
      Cube([length,t_width,depth-inset],center=Y);}}
  module holes(){
    translate(35*X+50*Z){
      rotate(90*X){
	xpair(180,edge=true){
	  wcylinder(h=width,d=25,center=true);}}}}
  module slots(){
    outer_flat_width=35;
    inner_flat_width=40;
    module base(){
      hull(){
	translate(60*Z+length/2*X){
	  Cube([inner_flat_width,width,1],center=X+Y);}
	translate(height*Z){
	  translate(outer_flat_width*X){
	    Cube([1,width,1],center=Y);}
	  translate((length-inner_flat_width-1)*X){
	    Cube([1,width,1],center=Y);}}}}
    module inner_slot(){
      translate(length/2*X+42*Z){
	Cube([18,width,18],center=X+Y);}}
    module outer_slot(){
      depth=15;
      translate(length/2*X+(height-depth)*Z){
	xpair(length-35){
	  Cube([10,width,depth],center=X+Y);}}}
    base();
    inner_slot();
    outer_slot();}

  difference(){
    body();
    bottom_slot();
    holes();
    slots();}}

example_130();
