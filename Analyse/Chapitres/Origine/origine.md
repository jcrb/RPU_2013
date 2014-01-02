Origine des patients
========================================================

```r
date()
```

```
## [1] "Thu Jan  2 13:05:03 2014"
```

```r
wd <- getwd()
wd
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU_2013/Analyse/Chapitres/Origine"
```

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
nrow(d1)
```

```
## [1] 301767
```


Données générales
-----------------

```r
x <- as.character(d1$CODE_POSTAL)
a <- x[substr(x, 1, 2) == "57"]
length(a)
```

```
## [1] 2827
```


Origine géographique des patients
---------------------------------
On récupère le no du département, puis on fait un summary trié par ordre croissant

```r
b <- as.factor(substr(x, 1, 2))
a <- sort(summary(b))

ap <- round(prop.table(a) * 100, 2)
c <- rbind(a, ap)
rownames(c) <- c("n", "%")
c
```

```
##   96 48 23 09 32 98 19 47 36 46 58 12 05 53 65 16 43 87 15 24 61 81    18
## n  1  4  5  8  8  8  9  9 10 10 10 11 12 12 12 13 13 14 15 15 15 15 18.00
## %  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0.01
##      85    17    20    82    86    07    40    04    26    03    22    37
## n 18.00 19.00 20.00 20.00 21.00 22.00 22.00 25.00 25.00 27.00 27.00 27.00
## %  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01
##      11    41    64    14    28    50    72    89    56    45    30    39
## n 28.00 29.00 30.00 31.00 32.00 32.00 32.00 32.00 33.00 34.00 35.00 35.00
## %  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01
##      49    52    79    10    08    27    84    73    00    42    80    55
## n 37.00 37.00 39.00 40.00 43.00 43.00 43.00 44.00 45.00 45.00 45.00 50.00
## %  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.02
##      35    66    02    44    31    83    97    60    01    71    33    51
## n 51.00 54.00 56.00 56.00 59.00 60.00 60.00 64.00 66.00 66.00 67.00 71.00
## %  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02
##      74    21    29    34    38    62    63     06     91     95     13
## n 78.00 79.00 79.00 79.00 86.00 89.00 90.00 102.00 104.00 104.00 115.00
## %  0.03  0.03  0.03  0.03  0.03  0.03  0.03   0.03   0.03   0.03   0.04
##       94     93     78     76     70     92     69     77     59     75
## n 118.00 127.00 130.00 143.00 153.00 154.00 174.00 183.00 256.00 282.00
## %   0.04   0.04   0.04   0.05   0.05   0.05   0.06   0.06   0.08   0.09
##      25    54     88     90      99      57        67        68
## n 300.0 305.0 491.00 560.00 1653.00 2827.00 124304.00 166458.00
## %   0.1   0.1   0.16   0.19    0.55    0.94     41.19     55.16
```

```r

org_als <- as.numeric(ap["67"] + ap["68"])
org_lim <- as.numeric(ap["57"] + ap["54"] + ap["88"] + ap["90"])
```

#### Patient domiciliés en Alsace: 96.35 %

#### Patient domicilés dans les départements voisins: 1.39 %

La majorité des passages aux urgences sont le fait de résidents alsaciens. La fréquentation hors région ne représente que 3.65 % des passages. La Moselle (57) est le département extra régional le plus représenté. Cette situation s'explique par les liens forts qui unissent l'Alsace-Moselle au travers du Concordat.

Passages en provenance des départements limitrophes
---------------------------------------------------
Moselle, Meurthe et Moselle, Vosges, Territoire de Belfort


```r
a <- x[substr(x, 1, 2) %in% c("57", "54", "88", "90")]
b <- as.factor(substr(a, 1, 2))
summary(b)
```

```
##   54   57   88   90 
##  305 2827  491  560
```

### TODO
- carte de France avec origines
- carte de la région + départements limitrophes
