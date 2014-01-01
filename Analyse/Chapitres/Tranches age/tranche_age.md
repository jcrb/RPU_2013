Répartition des passages par tranches d'age
========================================================

```r
date()
```

```
## [1] "Tue Dec 31 18:21:11 2013"
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

```
## Warning: impossible d'ouvrir le fichier compressé
## '../../rpu2013d0111.Rda', cause probable : 'Aucun fichier ou dossier de ce
## type'
```

```
## Error: impossible d'ouvrir la connexion
```

```r
d1 <- foo(path)
```

```
## Error: la promesse est déjà en cours d'évaluation : référence récursive
## d'argument par défaut ou problème antérieur ?
```

```r
nrow(d1)
```

```
## Error: objet 'd1' introuvable
```

Activité régionale
-----------------------------

```r
wd <- getwd()
# setwd('~/Documents/Resural/Stat
# Resural/RPU2013/Chapitres/Activite_regionale')
source(paste(path, "mes_fonctions.R", sep = ""))
```

```
## Warning: impossible d'ouvrir le fichier '../../mes_fonctions.R' : Aucun
## fichier ou dossier de ce type
```

```
## Error: impossible d'ouvrir la connexion
```

Librairies nécessaires:
-----------------------

```r
load_libraries()
```

```
## Error: impossible de trouver la fonction "load_libraries"
```

Données Age
-----------

```r
a <- summary(d1$AGE)
```

```
## Error: objet 'd1' introuvable
```

**Age moyen** NA  
**Age médian** NA  

Le découpage en tranches d'age est le même que celui utilisé pour la population générale (voir demographie2.Rmd)


```r
age1 <- cut(d1$AGE, breaks = c(-1, 0.99, 14, 74, 84, 110), labels = c("Moins de 1 an", 
    "De 1 à 15 ans", "De 15 à 75 ans", "de 75 à 85 ans", "Plus de 85 ans"))
```

```
## Error: objet 'd1' introuvable
```

```r

age2 <- cut(d1$AGE, breaks = c(-1, 17, 74, 110), labels = c("Pédiatrie", "Age moyen", 
    "Gériatrie"))
```

```
## Error: objet 'd1' introuvable
```

```r

a <- tapply(d1$AGE, age1, length)
```

```
## Error: objet 'age1' introuvable
```

```r
a
```

```
## [1] "0011"
```

```r
barplot(a, main = "Répartition des RPU par tranches d'age", ylab = "Nombre")
```

```
## Error: argument non numérique pour un opérateur binaire
```

