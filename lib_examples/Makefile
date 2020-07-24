include $(wildcard *.deps)

EXAMPLES = $(wildcard *.scad)
PICTURES = $(EXAMPLES:.scad=.png)
SCAD = openscad -m make
RENDER = --autocenter --viewall --render

all: $(PICTURES)

%.stl: %.scad
	$(SCAD) -o ./$@ -d $@.deps $<

annulus.png: annulus.scad
	$(SCAD) $(RENDER) -o ./$@ -d $@.deps $< \
	 --camera=36,57,26,35,0,87,401

%.png: %.scad
	$(SCAD) $(RENDER) -o ./$@ -d $@.deps $<
