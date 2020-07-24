/**
 * Test the functions defined in <lib.scad>.
 */

use <lib.scad>

assert(sum([1,2,3,4])==10);
assert(sum([])==0);

assert(pop([1,2,3])==[2,3]);
assert(pop([1,1,2])==[1,2]);
assert(pop([1])==[]);
// catch pop([]);

assert(take(0,[1,2,3])==[]);
assert(take(1,[1,2,3])==[1]);
assert(take(2,[1,2,3])==[1,2]);
assert(take(2,[])==[undef,undef]);

assert(count_defined([])==0);
assert(count_defined([1])==1);
assert(count_defined([undef])==0);
assert(count_defined([1,0,0])==3);
assert(count_defined([undef,undef,1,undef])==1);

assert(any([])==undef);
assert(any([1])==1);
assert(any([undef])==undef);
assert(any([undef,1])==1);
assert(any([1,2,3])==1);

// catch unique([]);
assert(unique([1])==1);
// catch unique([undef]);
assert(unique([undef,1,undef])==1);
// catch [undef,1,undef,2]

echo("Success");
