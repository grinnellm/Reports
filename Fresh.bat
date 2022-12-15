# Clean up the directory after a LaTeX build (Windows version)
del *.aux
del *.bbl
del *.blg
del *.dvi
del *.log
del *.lof
del *.lot
del *.nav
del *.out
del *.ps
del *.snm
del *.toc
del *.vrb
del *-concordance.tex
del *.synctex.gz*
del DataSummary-knitr.rnw
del DataSummary.tex
del DataSummary-knitr.tex
del DataSummary.pdf
del DataSummary-knitr.pdf
del Presentation.pdf
del Presentation.tex
del .Rhistory
rmdir /S /Q knitr-cache
rmdir /S /Q figure
rmdir /S /Q cache
