# ======================================================================
# Makefile
# ======================================================================
#

HTML = about.html good-tools.html

all: $(HTML)

%.html: %.scrbl
	scribble --html ++xref-in setup/xref load-collections-xref --redirect-main "http://pre.plt-scheme.org/docs/html/" ++style local-style.css $<

about.html: about.scrbl
good-tools.html: good-tools.scrbl good-tools.rkt

clean:
	rm -f $(HTML) scribble*.css scribble*.js manual*.css manual*.js racket.css sigplan.css
