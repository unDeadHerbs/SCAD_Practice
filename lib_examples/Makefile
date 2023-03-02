PIC_CODE = $(wildcard pictures/*.scad)
PICTURES = $(PIC_CODE:.scad=.png)
ANI_CODE = $(wildcard animations/*.scad)
ANIMATIONS = $(ANI_CODE:.scad=.gif)
OPENSCAD = ~/build/openscad/build/openscad
SCAD = $(OPENSCAD) -m make --hardwarnings

all: README.org $(PICTURES) $(ANIMATIONS)

DEPDIR   := .dep.d
DEPFILES := $(wildcard $(DEPDIR)/*.d)
include $(DEPFILES)
%.d: ; mkdir $@

README.org: README.template $(PIC_CODE) $(ANI_CODE)
	'emacs' $< --batch --eval="(org-org-export-to-org)"

%.stl: %.scad
	$(SCAD) -o ./$@ -d $@.deps $<

%.gif: %.scad
	$(SCAD) --render --animate 300 --imgsize=1200,700 -d $@.deps $<
	convert 'frame*.png' -set delay 1x60 "$@"
	rm frame*.png

%.png: %.scad
	$(SCAD) --render --imgsize=1200,700 -o ./$@ -d $@.deps $<

include $(wildcard *.deps)

clean:
	-rm README.org
	-rm $(PICTURES)
	-rm $(ANIMATIONS)
