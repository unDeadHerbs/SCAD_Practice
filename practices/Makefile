include $(wildcard *.deps)
SCAD = ~/build/openscad/build/openscad

%.stl: %.scad
	$(SCAD) -m make -o ./$@ -d $@.deps $<

%.png: %.scad
	$(SCAD) -m make --render -o ./$@ -d $@.deps $<
