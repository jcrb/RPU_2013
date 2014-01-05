Gériatrie
========================================================

**Date:** Sun Jan  5 20:30:57 2014

**Working directory:** /home/jcb/Documents/Resural/Stat Resural/RPU_2013/Analyse/Chapitres/Geriatrie
***

Variables globales:
-------------------

```
## [1] "Fichier courant: rpu2013d0111.Rda"
```

Nombre de dossiers: 301767


```r
g <- d1[d1$AGE > 74, ]
n_g <- nrow(g)
```

Les 75 ans et plus représentent $46534$ passages en 2013 soit $140$ passages par jour.

nombre de passages en fonctuin sde l'age
----------------------------------------

```r
pg <- table(as.factor(g$AGE))
plot(pg, main = paste("Nombre de passages en fonction de l'age en", an_c), ylab = "Fréquence", 
    xlab = "Age (années)", col = "blue")
```

![plot of chunk passages_geriatrie](figure/passages_geriatrie.png) 


