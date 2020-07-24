EXAMPLES = $(wildcard *.scad)
PICTURES = $(EXAMPLES:.scad=.png)
SCAD = openscad -m make
RENDER = --autocenter --viewall --render

all: README.org $(PICTURES)

README.org: README.template *.scad
	'emacs' $< --batch --eval="(org-org-export-to-org)"

%.stl: %.scad
	$(SCAD) -o ./$@ -d $@.deps $<

annulus.png: annulus.scad
	$(SCAD) $(RENDER) -o ./$@ -d $@.deps $< \
	 --camera=36,57,26,35,0,87,401

%.png: %.scad
	$(SCAD) $(RENDER) -o ./$@ -d $@.deps $<

include $(wildcard *.deps)
