Origine des patients
========================================================

```r
date()
```

```
## [1] "Mon Apr 28 15:21:40 2014"
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
nrow(d1)
```

```
## [1] 344073
```


Données générales
-----------------

```r
x <- as.character(d1$CODE_POSTAL)
a <- x[substr(x, 1, 2) == "57"]
length(a)
```

```
## [1] 3354
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
##   96 48 23 98 09 19 32 46 58 36 47 12 43 65 53 16 24 61    05    15    20
## n  1  4  5  8  9  9 10 10 10 11 11 12 14 14 15 16 16 17 18.00 19.00 22.00
## %  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0.01  0.01  0.01
##      81    85    18    82    87    86    04    07    17    40    22    03
## n 22.00 22.00 23.00 23.00 24.00 25.00 26.00 26.00 27.00 27.00 28.00 31.00
## %  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01
##      41    37    26    50    11    28    56    89    64    72    14    45
## n 32.00 33.00 34.00 35.00 36.00 37.00 37.00 37.00 38.00 38.00 39.00 39.00
## %  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01
##      79    49    52    10    80    00    08    30    39    42    27    73
## n 40.00 44.00 44.00 46.00 48.00 49.00 49.00 49.00 49.00 50.00 51.00 51.00
## %  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01  0.01
##      84    35    02    66    55    97    31    60    44    83    71    33
## n 53.00 55.00 62.00 63.00 64.00 67.00 68.00 68.00 70.00 73.00 74.00 81.00
## %  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02  0.02
##      01    51    29    74    21    63    34     62     91     06     38
## n 82.00 85.00 87.00 88.00 91.00 98.00 99.00 108.00 119.00 120.00 121.00
## %  0.02  0.02  0.03  0.03  0.03  0.03  0.03   0.03   0.03   0.03   0.04
##       95     94     93     13     78     76     70     92     69     77
## n 125.00 137.00 146.00 147.00 157.00 167.00 170.00 187.00 201.00 207.00
## %   0.04   0.04   0.04   0.04   0.05   0.05   0.05   0.05   0.06   0.06
##       59    75    54    25     88    90      99      57        67
## n 289.00 336.0 345.0 353.0 560.00 688.0 1888.00 3354.00 144478.00
## %   0.08   0.1   0.1   0.1   0.16   0.2    0.55    0.97     41.99
##          68
## n 186682.00
## %     54.26
```

```r

org_als <- as.numeric(ap["67"] + ap["68"])
org_lim <- as.numeric(ap["57"] + ap["54"] + ap["88"] + ap["90"])
```

#### Patient domiciliés en Alsace: 96.25 %

#### Patient domicilés dans les départements voisins: 1.43 %

La majorité des passages aux urgences sont le fait de résidents alsaciens. La fréquentation hors région ne représente que 3.75 % des passages. La Moselle (57) est le département extra régional le plus représenté. Cette situation s'explique par les liens forts qui unissent l'Alsace-Moselle au travers du Concordat.

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
##  345 3354  560  688
```

### TODO
- carte de France avec origines
- carte de la région + départements limitrophes
