Répartition des passages par tranches d'age
========================================================

```r
date()
```

```
## [1] "Sat Jan  4 20:09:59 2014"
```

```r
wd <- getwd()
wd
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU_2013/Analyse/Chapitres/Tranches age"
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
N <- nrow(d1)
N
```

```
## [1] 301767
```


Données Age
-----------

```r
a <- summary(d1$AGE)
```

**Age moyen** 40.5  
**Age médian** 38  

Tranches d'age
--------------

La méthode **cut** permet de diviser le vecteur *age* en classes. Le résultat est un *factor*.

Syntaxe des intervalles:
- $[0,5] <=> 0 <= X <= 5 <=> 0, 1, 2, 3, 4, 5$
- $(0,5] <=> 0 <= X < 5 <=> 0, 1, 2, 3, 4$  cut(...., right = FALSE)
- $[0,5) <=> 0 < X <= 5 <=> 1, 2, 3, 4, 5$  cut(...., right = TRUE)

Intervalles pré-réglés:
- age1: 
- age2: 3 catégories (Pédiatrie, Adulte, Gériatrie)
- age3: intervalles de classe allant de 0 à 95 ans par tranches de 5 ans, borne sup de l'intervalle exclue. Le premier intervalle va de 0 à 4, le second de 5 à 9, le dernier va de 90 à 94. O ajoute un sernier intervalle pour toutes les valeurs supérieures ou égales à 95. Deux façons d'afficher les résultats:
- *table()* affiche les résultats groupés par catégories, mais pas les NA's.
- *summary()* idem + les NA's.

Le découpage en tranches d'age est le même que celui utilisé pour la population générale (voir demographie2.Rmd)


```r

age1 <- cut(d1$AGE, breaks = c(-1, 0.99, 14, 74, 84, 110), labels = c("Moins de 1 an", 
    "De 1 à 15 ans", "De 15 à 75 ans", "de 75 à 85 ans", "Plus de 85 ans"))
a <- tapply(d1$AGE, age1, length)
a
```

```
##  Moins de 1 an  De 1 à 15 ans De 15 à 75 ans de 75 à 85 ans Plus de 85 ans 
##           7865          54374         192994          27253          19241
```

```r
barplot(a, main = "Répartition des RPU par tranches d'age", ylab = "Nombre")
```

![plot of chunk tranche_age1](figure/tranche_age1.png) 

### Age2

```r
age2 <- cut(d1$AGE, breaks = c(-1, 17, 74, 110), labels = c("Pédiatrie", "Adulte < 75 ans", 
    "Gériatrie"))
t1 <- table(age2)
mp <- barplot(prop.table(t1) * 100, ylab = "Pourcentage de la population", main = "Répartition des consultants en 2013", 
    col = "lavender")
mtext(side = 1, at = mp, line = -2, text = paste(round(prop.table(t1) * 100, 
    0), "%", sep = ""), col = "blue")
```

![plot of chunk tranche_age2](figure/tranche_age2.png) 

```r

t2 <- round(prop.table(table(age2)) * 100, 2)
a <- rbind(t1, t2)
rownames(a) <- c("n", "%")
a
```

```
##   Pédiatrie Adulte < 75 ans Gériatrie
## n  72568.00       182665.00  46494.00
## %     24.05           60.54     15.41
```

- Pédiatrie: **24 %**
- Gériatrie: **15 %**

### Age3

```r
# age3 ------ construction du vecteur x des labels ('0-4','5-9', ...)  inc =
# incrément intervalle = no de l'intervalle (le premier vaut 1) i = borne
# inférieure de l'intervalle j = borne sup de l'intervalle x = vecteur des
# labels
inc <- 5
intervalle <- 1
lim_sup <- 100
i <- 0
j <- i + inc - 1
x <- 1
while (j < lim_sup) {
    x[intervalle] <- paste(i, "-", j, sep = "")
    i <- j + 1
    j <- i + inc - 1
    intervalle <- intervalle + 1
}
x[intervalle] <- "100+"
x
```

```
##  [1] "0-4"   "5-9"   "10-14" "15-19" "20-24" "25-29" "30-34" "35-39"
##  [9] "40-44" "45-49" "50-54" "55-59" "60-64" "65-69" "70-74" "75-79"
## [17] "80-84" "85-89" "90-94" "95-99" "100+"
```

```r
# construction du vecteur age3
brek <- c(seq(from = 0, to = lim_sup, by = 5), 120)
age3 <- cut(d1$AGE, breaks = brek, include.lowest = F, right = F, labels = x)
t_age3 <- table(age3)
# Affichage
barplot(t_age3, las = 2)
```

![plot of chunk tranche_age3](figure/tranche_age31.png) 

```r
barplot(round(prop.table(t_age3) * 100, 2), ylab = "% de la population", las = 2, 
    xlab = "", main = "Pourcentage de consultants par tranche d'age")
```

![plot of chunk tranche_age3](figure/tranche_age32.png) 

```r
# -------------------------------------------------------------------------
```


Recours aux urgences par age et par sexe
----------------------------------------
La table *ts* est reformatée pour supprimer la colonne *I* et pour mettre la colonne *H* en premier de manière à être cohérent avec la présentation de l'INSEE.


```r
ts <- table(age3, d1$SEXE)
ts <- cbind(ts[, 3], ts[, 1])
colnames(ts) <- c("H", "F")
ts
```

```
##           H     F
## 0-4   16408 12837
## 5-9    8965  7005
## 10-14  9290  7733
## 15-19  9597  8561
## 20-24 11201  9998
## 25-29 10962  8949
## 30-34 10465  8069
## 35-39  9229  7129
## 40-44  9955  7577
## 45-49  8978  7286
## 50-54  8276  7110
## 55-59  7679  6761
## 60-64  7603  6156
## 65-69  5964  4801
## 70-74  5657  5029
## 75-79  6083  6566
## 80-84  6173  8430
## 85-89  3976  7988
## 90-94  1702  4481
## 95-99   203   723
## 100+     72   126
```

Pyramide des ages des consultants
---------------------------------

```r
# graduations echelle des x: de 0 à 70000 par pas de 10000
rl <- seq(0, 17000, 1000)
# labels centraux
agelabels <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", 
    "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", 
    "80-84", "85-89", "90-94", "95-99", "100+")
# gap = écartement entre les colonnes en unité prop au graphique
pyramid.plot(lx = ts[, 1], rx = ts[, 2], labels = agelabels, top.labels = c("Hommes", 
    "Age", "Femmes"), gap = 1500, main = "Pyramide des ages des passages aux urgences", 
    unit = "nombre", labelcex = 0.8, laxlab = rl, raxlab = rl)
```

```
## [1] 5.1 4.1 4.1 2.1
```

```r

# en pourcentages

round(prop.table(ts) * 100, 2)
```

```
##          H    F
## 0-4   5.44 4.25
## 5-9   2.97 2.32
## 10-14 3.08 2.56
## 15-19 3.18 2.84
## 20-24 3.71 3.31
## 25-29 3.63 2.97
## 30-34 3.47 2.67
## 35-39 3.06 2.36
## 40-44 3.30 2.51
## 45-49 2.98 2.41
## 50-54 2.74 2.36
## 55-59 2.54 2.24
## 60-64 2.52 2.04
## 65-69 1.98 1.59
## 70-74 1.87 1.67
## 75-79 2.02 2.18
## 80-84 2.05 2.79
## 85-89 1.32 2.65
## 90-94 0.56 1.48
## 95-99 0.07 0.24
## 100+  0.02 0.04
```

```r

rl <- seq(0, 6, 1)
l <- ts[, 1] * 100/sum(ts)
r <- ts[, 2] * 100/sum(ts)
pyr.urg <- pyramid.plot(lx = l, rx = r, labels = agelabels, top.labels = c("Hommes", 
    "Age", "Femmes"), gap = 1, main = "Pyramide des ages des passages aux urgences", 
    unit = "%", labelcex = 0.8, laxlab = rl, raxlab = rl, add = TRUE)
```

![plot of chunk pyr_consult](figure/pyr_consult.png) 

```r
pyr.urg
```

```
## [1] 4 2 4 2
```



Taux de recours aux urgences par tranches d'age
-----------------------------------------------
Nécessite de connaître la répartition de la population par tranches d'age.

Todo: voir fichier population.

Centenaires
-----------


```r
centenaire <- d1$AGE[d1$AGE > 99]
n_centenaire <- length(centenaire)

centenaire <- d1[d1$AGE > 99, c("AGE", "SEXE")]
```

En 2013, **208 centenaires** ont été pris en charge par les services d'urgence (0.07 % des RPU).  
Le recensement 2010 fait état de **358** centenaires en Alsace. Le taux de recours aux urgences pour cette population particulière s'élève à 58.1 %.

Sex ratio
---------

```r
a <- table(d1$SEXE)
sex_ratio <- a["M"]/a["F"]

a <- table(d1$SEXE, as.factor(d1$AGE))
sr <- a[3, ]/a[1, ]
sr
```

```
##       0       1       2       3       4       5       6       7       8 
##  1.2255  1.2680  1.2906  1.3489  1.3010  1.3828  1.3367  1.2462  1.2471 
##       9      10      11      12      13      14      15      16      17 
##  1.1758  1.1786  1.0790  1.2675  1.2502  1.2434  1.0053  1.1245  1.2588 
##      18      19      20      21      22      23      24      25      26 
##  1.1357  1.0936  1.1271  1.0566  1.0831  1.1531  1.1861  1.1489  1.1754 
##      27      28      29      30      31      32      33      34      35 
##  1.2894  1.2189  1.3102  1.2800  1.3028  1.3001  1.2841  1.3207  1.2677 
##      36      37      38      39      40      41      42      43      44 
##  1.2740  1.3099  1.2422  1.3796  1.2725  1.3149  1.3587  1.2680  1.3587 
##      45      46      47      48      49      50      51      52      53 
##  1.2212  1.3013  1.3419  1.1661  1.1426  1.1520  1.2216  1.2001  1.1104 
##      54      55      56      57      58      59      60      61      62 
##  1.1423  1.0913  1.1074  1.2147  1.1329  1.1392  1.2077  1.2016  1.1799 
##      63      64      65      66      67      68      69      70      71 
##  1.3791  1.2206  1.2428  1.3027  1.3536  1.1646  1.1367  1.0953  1.1184 
##      72      73      74      75      76      77      78      79      80 
##  1.2232  1.1548  1.0500  1.0254  1.0788  0.9396  0.8527  0.7922  0.7834 
##      81      82      83      84      85      86      87      88      89 
##  0.8127  0.7273  0.7138  0.6337  0.5412  0.5756  0.4897  0.4410  0.4275 
##      90      91      92      93      94      95      96      97      98 
##  0.4359  0.3810  0.3737  0.2995  0.3754  0.3135  0.2775  0.3252  0.2537 
##      99     100     101     102     103     104     105     106     108 
##  0.2130  0.3333  0.2121  0.3846  0.3000  0.0000  0.0000  0.0000  0.0000 
##     109     110     111     112 
##     Inf     Inf     Inf 24.0000
```

```r
plot(sr[0:103], type = "l", xlab = "Age (années)", ylab = "Sex ratio", las = 2, 
    col = "green", lwd = 2)
abline(h = 1, col = "red")
abline(v = 77, col = "blue")
```

![plot of chunk sr](figure/sr.png) 

**Sex-ratio: 1.11**

Même calcul avec des tanches d'age de 5 ans

```r
d1$age3 <- cut(d1$AGE, breaks = brek, include.lowest = F, right = F, labels = x)
a <- table(d1$SEXE, d1$age3)
a
```

```
##    
##       0-4   5-9 10-14 15-19 20-24 25-29 30-34 35-39 40-44 45-49 50-54
##   F 12837  7005  7733  8561  9998  8949  8069  7129  7577  7286  7110
##   I     0     1     0     2     0     0     0     0     0     0     0
##   M 16408  8965  9290  9597 11201 10962 10465  9229  9955  8978  8276
##    
##     55-59 60-64 65-69 70-74 75-79 80-84 85-89 90-94 95-99  100+
##   F  6761  6156  4801  5029  6566  8430  7988  4481   723   126
##   I     0     0     0     0     0     1     0     0     0     0
##   M  7679  7603  5964  5657  6083  6173  3976  1702   203    72
```

```r
# NOTE: à quoi correspondent les NA ? Si on refait les calculs en ajoutant
# une rubrique entre -1 et 0, on réduit le nomfre de NA a 10 mais on ne
# modifie pas le npmbre de cas par catégorie: brek <- c( -1, seq(from = 0,
# to = 95, by = 5),120) d2 <- d1[,c('AGE','SEXE')] d2$age3 <- cut(d2$AGE,
# breaks = brek, include.lowest=F, right=F) summary(d2$age3)

sr <- a[3, ]/a[1, ]
plot(sr, type = "l", xlab = "Tranches d'Age (années)", ylab = "Sex ratio", 
    col = "green", lwd = 2)
abline(h = 1, col = "red")
```

![plot of chunk sr5](figure/sr5.png) 


Pyramide des ages
-----------------


```r
file <- "~/Documents/Resural/Stat Resural/population_alsace/pop_legale_2010/rp2010_POP1B_n1_REG-42.csv"
doc <- read.table(file, header = TRUE, sep = ",", skip = 9)
# on supprime la dernière ligne qui correspond au total
doc <- doc[-nrow(doc), ]
head(doc)
```

```
##                X Hommes Femmes Ensemble
## 1 Moins de 5 ans  55914  53240   109154
## 2      5 à 9 ans  56840  54235   111075
## 3    10 à 14 ans  56710  54357   111067
## 4    15 à 19 ans  58843  56599   115441
## 5    20 à 24 ans  58106  59818   117924
## 6    25 à 29 ans  57879  59193   117072
```

```r

# couleur du fond
par(bg = "#eedd55")
# graduations echelle des x: de 0 à 70000 par pas de 10000
rl <- seq(0, 70000, 10000)
# labels centraux
agelabels <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", 
    "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", 
    "80-84", "85-89", "90-94", "95-99", "100+")
# gap = écartement entre les colonnes en unité prop au graphique
pyramid.plot(lx = doc$Hommes, rx = doc$Femmes, labels = agelabels, top.labels = c("Hommes", 
    "Age", "Femmes"), gap = 6000, main = "Pyramide des ages en Alsace (INSEE 2010)", 
    unit = "nombre", labelcex = 0.8, laxlab = rl, raxlab = rl)
```

![plot of chunk pyramide](figure/pyramide1.png) 

```
## [1] 5.1 4.1 4.1 2.1
```

```r
par(bg = "white")

# en pourcentage
n <- sum(doc$Hommes, doc$Femmes)  # pop totale
rl <- seq(0, 6, 1)
r <- doc$Hommes * 100/n
l <- doc$Femmes * 100/n
pyr.regionale <- pyramid.plot(lx = r, rx = l, labels = agelabels, top.labels = c("Hommes", 
    "Age", "Femmes"), gap = 1, main = "Pyramide des ages en Alsace (INSEE 2010)", 
    unit = "%", labelcex = 0.8, laxlab = rl, raxlab = rl)
```

![plot of chunk pyramide](figure/pyramide2.png) 

```r
pyr.regionale
```

```
## [1] 4 2 4 2
```

On peut superposer les deux pyramides
--------------------------------------
pyr.regionale en premier puis pyr.urg

```r
myred <- adjustcolor("red", alpha.f = 0.3)
myblue <- adjustcolor("blue", alpha.f = 0.3)

n <- sum(doc$Hommes, doc$Femmes)  # pop totale
rl <- seq(0, 6, 1)
r <- doc$Hommes * 100/n
l <- doc$Femmes * 100/n
pyr.regionale <- pyramid.plot(lx = r, rx = l, labels = agelabels, top.labels = c("Hommes", 
    "Age", "Femmes"), gap = 1, main = "Pyramide des ages en Alsace (INSEE 2010)", 
    unit = "%", labelcex = 0.8, laxlab = rl, raxlab = rl, lxcol = myblue, rxcol = myblue)
pyr.regionale
```

```
## [1] 5.1 4.1 4.1 2.1
```

```r

rl <- seq(0, 6, 1)
l <- ts[, 1] * 100/sum(ts)
r <- ts[, 2] * 100/sum(ts)
pyr.urg <- pyramid.plot(lx = l, rx = r, labels = agelabels, top.labels = c("Hommes", 
    "Age", "Femmes"), gap = 1, main = "Pyramide des ages des passages aux urgences", 
    unit = "%", labelcex = 0.8, laxlab = rl, raxlab = rl, , lxcol = myred, rxcol = myred, 
    add = TRUE)
pyr.urg
```

```
## [1] 4 2 4 2
```

```r

legend("topleft", legend = c("Région", "Urgences"), col = c(myblue, myred), 
    pch = 15)
```

![plot of chunk teg_urg](figure/teg_urg.png) 


