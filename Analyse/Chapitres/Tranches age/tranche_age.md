Répartition des passages par tranches d'age
========================================================

```r
date()
```

```
## [1] "Wed Nov 13 11:03:53 2013"
```

Variables globales:
-------------------

```r
source("../prologue.R")
```

```
## gdata: read.xls support for 'XLS' (Excel 97-2004) files ENABLED.
## 
## gdata: read.xls support for 'XLSX' (Excel 2007+) files ENABLED.
## 
## Attaching package: 'gdata'
## 
## L'objet suivant est masqué from 'package:stats':
## 
##     nobs
## 
## L'objet suivant est masqué from 'package:utils':
## 
##     object.size
## 
## Loading required package: questionr
## Loading required namespace: car
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
## Version 2.6.26 r77 Copyright (c) 2006-2013 Togaware Pty Ltd.
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
## [1] "Fichier courant: rpu2013d0110.Rda"
```

```r
d1 <- foo(path)
nrow(d1)
```

```
## [1] 276452
```

Activité régionale
-----------------------------

```r
wd <- getwd()
# setwd('~/Documents/Resural/Stat
# Resural/RPU2013/Chapitres/Activite_regionale')
source(paste(path, "mes_fonctions.R", sep = ""))
```

Librairies nécessaires:
-----------------------

```r
load_libraries()
```


Le découpage en tranches d'age est le même que celui utilisé pour la population générale (voir demographie2.Rmd)


```r
age <- cut(d1$AGE, breaks = c(-1, 0.99, 14, 74, 84, 110), labels = c("Moins de 1 an", 
    "De 1 à 15 ans", "De 15 à 75 ans", "de 75 à 85 ans", "Plus de 85 ans"))
a <- tapply(d1$AGE, age, length)
a
```

```
##  Moins de 1 an  De 1 à 15 ans De 15 à 75 ans de 75 à 85 ans Plus de 85 ans 
##           7151          50031         176834          24836          17576
```

```r
barplot(a, main = "Répartition des RPU par tranches d'age", ylab = "Nombre")
```

![plot of chunk tranches](figure/tranches.png) 

