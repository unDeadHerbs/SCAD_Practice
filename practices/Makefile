include $(wildcard *.deps)

%.stl: %.scad
	openscad -m make -o ./$@ -d $@.deps $<

%.png: %.scad
	openscad -m make --render -o ./example_101.png -d $@.deps example_101.scad
