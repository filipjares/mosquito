.PHONY: all gv

all: report3.pdf

gv: report.ps
	(gv $< &)

report.pdf: report.tex
	pdfcslatex $<; bibtex report; pdfcslatex $<; pdfcslatex $<

report.ps: report.dvi
	dvips $<

report.dvi: report.tex
	latex -output-format dvi $<; bibtex report; latex -output-format dvi $<; latex -output-format dvi $<

report2.pdf: report2.tex report.bib pics/schema_ridiciho_systemu.pdf pics/zpracovani_obrazu_z_kamery.pdf
	pdfcslatex $<; bibtex report2; pdfcslatex $<; pdfcslatex $<

report2.ps: report2.dvi
	dvips $<

report2.dvi: report2.tex
	latex -output-format dvi $<; bibtex report2; latex -output-format dvi $<; latex -output-format dvi $<

report3.pdf: report3.tex report.bib pics/schema_ridiciho_systemu.pdf pics/zpracovani_obrazu_z_kamery.pdf
	pdfcslatex $<; bibtex report3; pdfcslatex $<; pdfcslatex $<

report3.ps: report3.dvi
	dvips $<

report3.dvi: report3.tex
	latex -output-format dvi $<; bibtex report3; latex -output-format dvi $<; latex -output-format dvi $<

