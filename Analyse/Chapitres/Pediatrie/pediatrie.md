Pédiatrie
========================================================

**Date:** Sun Mar  2 11:20:48 2014
**Working directory:** /home/jcb/Documents/Resural/Stat Resural/RPU_2013/Analyse/Chapitres/Pediatrie
***

Variables globales:
-------------------

```r
source("../prologue.R")
```

```
## Loading required package: questionr
## 
## Attaching package: 'rgrs'
## 
## Les objets suivants sont masqués from 'package:questionr':
## 
##     copie, copie.default, copie.proptab, cprop, cramer.v,
##     format.proptab, freq, lprop, print.proptab, prop, quant.cut,
##     renomme.variable, residus, wtd.mean, wtd.table, wtd.var
## 
## Rattle : une interface graphique gratuite pour l'exploration de données avec R.
## Version 3.0.2 r169 Copyright (c) 2006-2013 Togaware Pty Ltd.
## Entrez 'rattle()' pour secouer, faire vibrer, et faire défiler vos données.
## Loading required package: foreign
## Loading required package: survival
## Loading required package: splines
## Loading required package: MASS
## Loading required package: nnet
## 
## Attaching package: 'zoo'
## 
## Les objets suivants sont masqués from 'package:base':
## 
##     as.Date, as.Date.numeric
## 
## Please visit openintro.org for free statistics materials
## 
## Attaching package: 'openintro'
## 
## L'objet suivant est masqué from 'package:MASS':
## 
##     mammals
## 
## L'objet suivant est masqué from 'package:datasets':
## 
##     cars
```

```
## [1] "Fichier courant: rpu2013d0112.Rda"
```

```r
an_c <- "2013"
n_jours <- as.numeric(max(as.Date(d1$ENTREE)) - min(as.Date(d1$ENTREE)))
N <- nrow(d1)
```

Nombre de dossiers: 340338


```r
p <- d1[d1$AGE < 18, ]
n_p <- nrow(p)
```

Les moins de 18 ans représentent $82650$ passages en 2013 soit $228$ passages par jour.

