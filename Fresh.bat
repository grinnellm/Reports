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
del DataSummary.tex
del DataSummary.pdf
del Presentation.pdf
del Presentation.tex
del .Rhistory
del *knitr.*
rmdir /S /Q knitr-cache
rmdir /S /Q figure
rmdir /S /Q cache
