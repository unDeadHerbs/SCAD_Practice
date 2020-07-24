include $(wildcard *.deps)

%.stl: %.scad
	openscad -m make -o ./$@ -d $@.deps $<

%.png: %.scad
	openscad -m make --render -o ./$@ -d $@.deps $<
