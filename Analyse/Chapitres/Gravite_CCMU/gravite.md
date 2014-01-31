Gravité - CCMU
========================================================

```r
date()
```

```
## [1] "Fri Jan 31 13:10:43 2014"
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
## [1] "Fichier courant: rpu2013d0112.Rda"
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
## [1] 340338
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


Analyse CCMU régionale
----------------------

```r

t <- table(gravite)
pt <- round(prop.table(t) * 100, 2)
g <- rbind(t, pt)
rownames(g) <- c("n", "%")
g
```

```
##          1         2        3       4     5     D       P
## n 38730.00 206434.00 40419.00 3561.00 868.0 38.00 1380.00
## %    13.29     70.83    13.87    1.22   0.3  0.01    0.47
```

```r

tx_urg <- sum(pt[3:5])
```

Taux d'urgences réelles: **15.39 %**

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
## [1] 7.15
```

```r
hr
```

```
## [1] 8.24
```

```r
a <- pt[3:5, ]
apply(a, 2, sum)
```

```
##   67   68 
## 7.15 8.24
```

Analyse par établissement
-------------------------

```r
t <- table(g$GRAVITE, g$FINESS)
pt <- round(prop.table(t, margin = 2) * 100, 2)
cbind(t, pt)
```

```
##     3Fr  Alk   Col   Dia   Geb   Hag  Hus   Mul   Odi   Sel   Wis  Sav
## 1  1431  264 21093    50   881  2885 1750  5388  1105  2717   828  338
## 2 13577 5372 32409 22435 14072 18727 9225 31403 23237 19759 10983 5235
## 3   102 1291  9039  5742    77  4756 4732  5389  1508  5648   608 1527
## 4     8    0   566    15    19   388  576  1277     7   492   141   72
## 5    10    0   186     2     3   170  132   274     0    58    33    0
## D     3    0     8     1     1    18    1     0     1     3     1    1
## P     1    2  1122     0    30     9    0     0     0   172    38    6
##     3Fr   Alk   Col   Dia   Geb   Hag   Hus   Mul   Odi   Sel   Wis   Sav
## 1  9.46  3.81 32.74  0.18  5.84 10.70 10.66 12.32  4.27  9.42  6.55  4.71
## 2 89.72 77.53 50.31 79.43 93.30 69.48 56.20 71.81 89.86 68.49 86.95 72.92
## 3  0.67 18.63 14.03 20.33  0.51 17.65 28.83 12.32  5.83 19.58  4.81 21.27
## 4  0.05  0.00  0.88  0.05  0.13  1.44  3.51  2.92  0.03  1.71  1.12  1.00
## 5  0.07  0.00  0.29  0.01  0.02  0.63  0.80  0.63  0.00  0.20  0.26  0.00
## D  0.02  0.00  0.01  0.00  0.01  0.07  0.01  0.00  0.00  0.01  0.01  0.01
## P  0.01  0.03  1.74  0.00  0.20  0.03  0.00  0.00  0.00  0.60  0.30  0.08
```


