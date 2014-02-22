Gravité - CCMU
========================================================

```r
date()
```

```
## [1] "Wed Feb 19 09:20:26 2014"
```

Variables globales:
-------------------
Charge le fichier source **d1**

```r
source("../prologue.R")
```

```
## Loading required package: questionr
```

```
## Error: package 'questionr' could not be loaded
```

```r
wd
```

```
## Error: objet 'wd' introuvable
```

```r
N <- nrow(d1)
```

```
## Error: objet 'd1' introuvable
```

```r
N
```

```
## Error: objet 'N' introuvable
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

```
## Error: objet 'd1' introuvable
```


Analyse CCMU régionale
----------------------

```r

t <- table(gravite)
```

```
## Error: objet 'gravite' introuvable
```

```r
pt <- round(prop.table(t) * 100, 2)
```

```
## Error: 'type' (closure) de l'argument incorrect
```

```r
g <- rbind(t, pt)
```

```
## Error: cannot coerce type 'closure' to vector of type 'list'
```

```r
rownames(g) <- c("n", "%")
```

```
## Error: objet 'g' introuvable
```

```r
g
```

```
## Error: objet 'g' introuvable
```

```r

tx_urg <- sum(pt[3:5])
```

```
## Error: objet de type 'closure' non indiçable
```

Taux d'urgences réelles: **

```

Error in eval(expr, envir, enclos) : objet 'tx_urg' introuvable

```

 %**

Analyse CCMU par département
----------------------------
On forme un dataframe de 3 colonnes, puis on réduit le cose postal à celui du département


```r
g <- d1[, c("GRAVITE", "FINESS")]
```

```
## Error: objet 'd1' introuvable
```

```r
g$dep[g$FINESS %in% c("Wis", "Hag", "Sav", "Hus", "Sel", "Odi")] <- 67
```

```
## Error: objet 'g' introuvable
```

```r
g$dep[is.na(g$dep)] <- 68
```

```
## Error: objet 'g' introuvable
```

```r
t <- table(g$GRAVITE, g$dep)
```

```
## Error: objet 'g' introuvable
```

```r
pt <- round(prop.table(t) * 100, 2)
```

```
## Error: 'type' (closure) de l'argument incorrect
```

```r
br <- sum(pt[3:5, 1])
```

```
## Error: objet de type 'closure' non indiçable
```

```r
hr <- sum(pt[3:5, 2])
```

```
## Error: objet de type 'closure' non indiçable
```

```r
br
```

```
## Error: objet 'br' introuvable
```

```r
hr
```

```
## Error: objet 'hr' introuvable
```

```r
a <- pt[3:5, ]
```

```
## Error: objet de type 'closure' non indiçable
```

```r
apply(a, 2, sum)
```

```
## Error: objet 'a' introuvable
```

Analyse par établissement
-------------------------

```r
t <- table(g$GRAVITE, g$FINESS)
```

```
## Error: objet 'g' introuvable
```

```r
pt <- round(prop.table(t, margin = 2) * 100, 2)
```

```
## Error: 'x' is not an array
```

```r
cbind(t, pt)
```

```
##      t pt
## [1,] ? ?
```

On note des disparités importantes entre établissements.

