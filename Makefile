get_samples:
	mkdir samples -p
	cd samples
	wget "https://caddexpert.com/wp-content/uploads/2020/06/SOLIDWORKS-CATIA-NX-AUTOCAD-3D-DRAWINGS-PRACTICE-BOOKS-100-PDF-1"{01..99}".jpg"

include $(wildcard *.deps)

%.stl: %.scad
	openscad -m make -o ./$@ -d $@.deps $<
