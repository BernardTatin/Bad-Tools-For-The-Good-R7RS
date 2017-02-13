# ======================================================================
# Makefile
# ======================================================================
#

HTML = about.html good-tools.html

all: $(HTML)

%.html: %.scrbl
	scribble --html ++style local-style.css $<

clean:
	rm -f $(HTML) scribble*.css scribble*.js manual*.css manual*.js racket.css sigplan.css
