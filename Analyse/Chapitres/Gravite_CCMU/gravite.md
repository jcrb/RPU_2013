Gravité - CCMU
========================================================

```r
date()
```

```
## [1] "Fri Jan  3 20:21:15 2014"
```

Variables globales:
-------------------
Charge le fichier source **d1**

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
## [1] "Fichier courant: rpu2013d0111.Rda"
```

```r
wd
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU_2013/Analyse/Chapitres/Gravite_CCMU"
```

```r
N <- nrow(d1)
N
```

```
## [1] 301767
```

Librairies nécessaires:
-----------------------

```r
load_libraries
```

```
## Error: objet 'load_libraries' introuvable
```

```r
gravite <- d1$GRAVITE
```


Analyse CCMU
-------------

```r

t <- table(gravite)
pt <- round(prop.table(t) * 100, 2)
g <- rbind(t, pt)
rownames(g) <- c("n", "%")
g
```

```
##          1      2        3       4      5     D       P
## n 34437.00 183174 35175.00 3157.00 794.00 34.00 1230.00
## %    13.35     71    13.63    1.22   0.31  0.01    0.48
```

```r

tx_urg <- sum(pt[3:5])
```

Taux d'urgences réelles: **15.16 %**

Analyse CCMU par département
----------------------------
On forme un dataframe de 3 colonnes, puis on réduit le cose postal à celui du département


```r
g <- d1[, c("GRAVITE", "FINESS")]
g$dep[g$FINESS %in% c("Wis", "Hag", "Sav", "Hus", "Sel", "Odi")] <- 67
g$dep[is.na(g$dep)] <- 68
t <- table(g$GRAVITE, g$dep)
pt <- round(prop.table(t) * 100, 2)
br <- sum(pt[3:5, 1])
hr <- sum(pt[3:5, 2])
br
```

```
## [1] 6.66
```

```r
hr
```

```
## [1] 8.5
```


