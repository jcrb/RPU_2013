CH Wissembourg
========================================================

Ligne 21 remplacer **Wis* par l'hôpital de son choix.


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
## Error: impossible d'ouvrir la connexion
```

```r
source("../../mes_fonctions.R")
```

```
## Error: impossible d'ouvrir la connexion
```

```r

date()
```

```
## [1] "Wed Jan  1 16:26:32 2014"
```

```r
pt <- nrow(d1)
```

```
## Error: objet 'd1' introuvable
```

```r
# population totale
pt
```

```
## function (q, df, ncp, lower.tail = TRUE, log.p = FALSE) 
## {
##     if (missing(ncp)) 
##         .External(C_pt, q, df, lower.tail, log.p)
##     else .External(C_pnt, q, df, ncp, lower.tail, log.p)
## }
## <bytecode: 0x594da80>
## <environment: namespace:stats>
```

Récupération des données
========================

```r
library("epicalc")
library("lubridate")
source("odds.R")
HOP <- d1[d1$FINESS == "Col", ]
```

```
## Error: objet 'd1' introuvable
```

```r
n <- nrow(HOP)
```

```
## Error: objet 'HOP' introuvable
```

### Passages en 2013: 

```

Error in eval(expr, envir, enclos) : objet 'n' introuvable

```



Mode de sortie
--------------

```r
a <- summary(HOP$MODE_SORTIE)
```

```
## Error: objet 'HOP' introuvable
```

```r
a
```

```
## [1] "0011"
```

```r
tab1(HOP$MODE_SORTIE)
```

```
## Error: objet 'HOP' introuvable
```

```r
hosp <- as.numeric(a["Mutation"] + a["Transfert"])
```

```
## Error: argument non numérique pour un opérateur binaire
```

```r
hosp
```

```
## Error: objet 'hosp' introuvable
```

```r
total <- as.numeric(hosp + a["Domicile"])
```

```
## Error: objet 'hosp' introuvable
```

```r
total
```

```
## Error: objet 'total' introuvable
```

```r
ratio_hosp <- round(hosp * 100/as.numeric(a["Domicile"]))
```

```
## Error: objet 'hosp' introuvable
```

```r
ratio_hosp
```

```
## Error: objet 'ratio_hosp' introuvable
```

```r
tx_hosp <- round(hosp * 100/total)
```

```
## Error: objet 'hosp' introuvable
```

```r
tx_hosp
```

```
## Error: objet 'tx_hosp' introuvable
```


Destination
-----------

```r
a <- summary(HOP$DESTINATION)
```

```
## Error: objet 'HOP' introuvable
```

```r
a
```

```
## [1] "0011"
```

```r
tab1(HOP$DESTINATION)
```

```
## Error: objet 'HOP' introuvable
```



Orientation
-----------

```r
summary(HOP$ORIENTATION)
```

```
## Error: objet 'HOP' introuvable
```

```r

# on supprime les NA
a <- HOP$ORIENTATION[!is.na(HOP$ORIENTATION)]
```

```
## Error: objet 'HOP' introuvable
```

```r
tab1(a, horiz = T, main = "Orientation des patients", xlab = "Nombre")
```

![plot of chunk orientation](figure/orientation.png) 

```
## a : 
##         Frequency Percent Cum. percent
## 0011            1     100          100
##   Total         1     100          100
```


Age
----


```r
age_local <- HOP$AGE
```

```
## Error: objet 'HOP' introuvable
```

```r
s <- summary(age_local)
```

```
## Error: objet 'age_local' introuvable
```

```r

c <- cut(age_local, breaks = c(-1, 1, 75, 150), labels = c("1 an", "1 à 75 ans", 
    "sup 75 ans"), ordered_result = TRUE)
```

```
## Error: objet 'age_local' introuvable
```

```r
a <- summary(c)
```

```
## Error: objet de type 'builtin' non indiçable
```

```r
a
```

```
## [1] "0011"
```

```r

c2 <- cut(age_local, breaks = c(-1, 19, 75, 120), labels = c("Pédiatrie", "Adultes", 
    "Gériatrie"))
```

```
## Error: objet 'age_local' introuvable
```

```r
b <- summary(c2)
```

```
## Error: objet 'c2' introuvable
```

```r
b
```

```
## Error: objet 'b' introuvable
```

### Age moyen: 

```

Error in eval(expr, envir, enclos) : objet 's' introuvable

```

  
### Pédiatrie: 

```

Error in eval(expr, envir, enclos) : objet 'b' introuvable

```

  (

```

Error in eval(expr, envir, enclos) : objet 'b' introuvable

```

 %)
### Gériatrie: 

```

Error in eval(expr, envir, enclos) : objet 'b' introuvable

```

  (

```

Error in eval(expr, envir, enclos) : objet 'b' introuvable

```

 %)


```r

# region: chiffre pour toute l'Alsace local: HOP
region <- d1$AGE
```

```
## Error: objet 'd1' introuvable
```

```r

hist(region, freq = F)
```

```
## Error: objet 'region' introuvable
```

```r
hist(age_local, add = T, col = "blue", freq = F, main = "Histogramme des ages")
```

```
## Error: objet 'age_local' introuvable
```

```r
abline(v = median(region, na.rm = T), col = "red")
```

```
## Error: objet 'region' introuvable
```

```r
abline(v = median(s, na.rm = T), col = "green")
```

```
## Error: objet 's' introuvable
```

```r
legend("topright", legend = c("médiane régionale", "médiane locale"), col = c("red", 
    "green"), lty = 1)
```

```
## Error: plot.new has not been called yet
```

```r

# moins de 1 an / total
local <- HOP$AGE[HOP$AGE < 1]
```

```
## Error: objet 'HOP' introuvable
```

```r
length(local) * 100/n
```

```
## Error: objet 'n' introuvable
```

```r
region <- d1$AGE[d1$AGE < 1]
```

```
## Error: objet 'd1' introuvable
```

```r
length(region) * 100/pt
```

```
## Error: objet 'region' introuvable
```

```r

# on forme une matrice carrée de 2 lignes et 2 colonnes: on saisi d'abord la
# colonne 1, puis 2 pour une saisie par ligne mettre byrow=TRUE
M1 <- matrix(c(length(a), n, length(region), pt), nrow = 2, byrow = FALSE)
```

```
## Error: objet 'n' introuvable
```

```r
M1
```

```
## Error: objet 'M1' introuvable
```

```r
chisq.test(M1)
```

```
## Error: objet 'M1' introuvable
```

```r
p <- M1[1, 1]/n
```

```
## Error: objet 'M1' introuvable
```

```r
q <- M1[1, 2]/pt
```

```
## Error: objet 'M1' introuvable
```

```r
or <- p * (1 - q)/q * (1 - p)
```

```
## Error: objet 'p' introuvable
```

```r
p
```

```
## Error: objet 'p' introuvable
```

```r
q
```

```
## function (save = "default", status = 0, runLast = TRUE) 
## .Internal(quit(save, status, runLast))
## <bytecode: 0x4c04c90>
## <environment: namespace:base>
```

```r
or
```

```
## Error: objet 'or' introuvable
```

```r

calcOddsRatio(M1, referencerow = 2)
```

```
## Error: objet 'M1' introuvable
```

```r
calcRelativeRisk(M1)
```

```
## Error: objet 'M1' introuvable
```

```r

# 75 ans et plus

a <- HOP$AGE[HOP$AGE > 74]
```

```
## Error: objet 'HOP' introuvable
```

```r
length(a) * 100/n  # % de la pop locale de 75 ans qui passa au SU
```

```
## Error: objet 'n' introuvable
```

```r
region <- d1$AGE[d1$AGE > 74]
```

```
## Error: objet 'd1' introuvable
```

```r
length(region) * 100/pt  # % de 75 ans dans la pop alsacienne qui consulte au SU
```

```
## Error: objet 'region' introuvable
```

```r

hist(a, main = "75 ans et plus", xlab = "age", col = "pink")
```

```
## Error: 'x' must be numeric
```

```r
summary(a)
```

```
##    Length     Class      Mode 
##         1 character character
```

```r
boxplot(a, col = "pink", main = "75 ans et plus", ylab = "Age (années)")
```

```
## Error: argument non numérique pour un opérateur binaire
```

```r

# calcul manuel de l'odds-ratio

M1 <- matrix(c(length(a), n - length(a), length(region), pt - length(region)), 
    nrow = 2, byrow = FALSE)
```

```
## Error: objet 'n' introuvable
```

```r
M1
```

```
## Error: objet 'M1' introuvable
```

```r
chisq.test(M1)
```

```
## Error: objet 'M1' introuvable
```

```r
p <- M1[1, 1]/n
```

```
## Error: objet 'M1' introuvable
```

```r
q <- M1[1, 2]/pt
```

```
## Error: objet 'M1' introuvable
```

```r
or <- (p * (1 - q))/(q * (1 - p))
```

```
## Error: objet 'p' introuvable
```

```r
p
```

```
## Error: objet 'p' introuvable
```

```r
q
```

```
## function (save = "default", status = 0, runLast = TRUE) 
## .Internal(quit(save, status, runLast))
## <bytecode: 0x4c04c90>
## <environment: namespace:base>
```

```r
or
```

```
## Error: objet 'or' introuvable
```

```r

# calcul del'OR et du risque relatif avec formules:

calcOddsRatio(M1, referencerow = 2)
```

```
## Error: objet 'M1' introuvable
```

```r
calcRelativeRisk(M1)
```

```
## Error: objet 'M1' introuvable
```

```r
chisq.test(M1)
```

```
## Error: objet 'M1' introuvable
```

```r
fisher.test(M1)
```

```
## Error: objet 'M1' introuvable
```

```r

# graphe de l'OR

odds <- calcOddsRatio(M1, referencerow = 2, quiet = TRUE)
```

```
## Error: objet 'M1' introuvable
```

```r
or <- odds[1]
```

```
## Error: objet 'odds' introuvable
```

```r
lower <- odds[2]
```

```
## Error: objet 'odds' introuvable
```

```r
upper <- odds[3]
```

```
## Error: objet 'odds' introuvable
```

```r
y <- 0.5
if (lower > 1) limiteInf <- 0.5 else limiteInf <- lower - 0.5
```

```
## Error: objet 'lower' introuvable
```

```r
plot(or, y, pch = 19, col = "darkblue", xlab = "odds-ratio", ylab = "", axes = FALSE, 
    main = "Patients de 75 ans et plus", xlim = c(limiteInf, upper + 0.5))
```

```
## Error: objet 'or' introuvable
```

```r
axis(1)
```

```
## Error: plot.new has not been called yet
```

```r
abline(v = 1, lty = "dashed")
```

```
## Error: plot.new has not been called yet
```

```r
lines(c(lower, upper), c(y, y), col = "royalblue")
```

```
## Error: objet 'lower' introuvable
```


sex ratio
-----------

```r
sexew <- HOP$SEXE
```

```
## Error: objet 'HOP' introuvable
```

```r
local <- summary(sexew)
```

```
## Error: objet 'sexew' introuvable
```

```r
local
```

```
## function (expr, envir = new.env()) 
## eval.parent(substitute(eval(quote(expr), envir)))
## <bytecode: 0x2716c38>
## <environment: namespace:base>
```

```r
srw <- round(local[3]/local[1], 3)
```

```
## Error: objet de type 'closure' non indiçable
```

```r

sexer <- d1$SEXE
```

```
## Error: objet 'd1' introuvable
```

```r
region <- summary(sexer)
```

```
## Error: objet 'sexer' introuvable
```

```r
region
```

```
## Error: objet 'region' introuvable
```

```r
srr <- round(region[3]/region[1], 3)
```

```
## Error: objet 'region' introuvable
```

```r

M1 <- matrix(c(local[3], local[1], region[3], region[1]), nrow = 2)
```

```
## Error: objet de type 'closure' non indiçable
```

```r
colnames(M1) <- c("Local", "Alsace")
```

```
## Error: objet 'M1' introuvable
```

```r
rownames(M1) <- c("Hommes", "Femmes")
```

```
## Error: objet 'M1' introuvable
```

```r
M1
```

```
## Error: objet 'M1' introuvable
```

```r
calcOddsRatio(M1, referencerow = 2)
```

```
## Error: objet 'M1' introuvable
```

```r
or <- calcOddsRatio(M1, referencerow = 2, quiet = TRUE)
```

```
## Error: objet 'M1' introuvable
```

```r

plot(or[1], 1, pch = 19, col = "darkblue", xlab = "odds-ratio", ylab = "", axes = FALSE)
```

```
## Error: objet 'or' introuvable
```

```r
axis(1)
```

```
## Error: plot.new has not been called yet
```

```r
abline(v = 1, lty = "dashed")
```

```
## Error: plot.new has not been called yet
```

```r
lines(c(or[2], or[3]), c(1, 1), col = "royalblue")
```

```
## Error: objet 'or' introuvable
```

sex-ratio local = 

```

Error in eval(expr, envir, enclos) : objet 'srw' introuvable

```

  
sex-ratio régional = 

```

Error in eval(expr, envir, enclos) : objet 'srr' introuvable

```

  
odds-ratio = 

```

Error in eval(expr, envir, enclos) : objet 'or' introuvable

```

 [

```

Error in eval(expr, envir, enclos) : objet 'or' introuvable

```

-

```

Error in eval(expr, envir, enclos) : objet 'or' introuvable

```

]

Le sex-ratio est légèrement inférieur à celui de la région mais pas signficativement différent

Horaires
---------

```r
e <- hour(HOP$ENTREE)
```

```
## Error: objet 'HOP' introuvable
```

```r
a <- cut(e, breaks = c(0, 7, 19, 23), labels = c("nuit profonde", "journée", 
    "soirée"))
```

```
## Error: objet 'e' introuvable
```

```r
b <- summary(a)
```


### Soirée 

```

Error in b["soirée"] * 100 : 
  argument non numérique pour un opérateur binaire

```

 %

### Nuit profonde 

```

Error in b["nuit profonde"] * 100 : 
  argument non numérique pour un opérateur binaire

```

 %

On fait la somme du vendredi 20 heures au lundi matin 8 heures. Dimanche = 1

```r
d <- HOP$ENTREE[wday(HOP$ENTREE) == 1 | wday(HOP$ENTREE) == 7 | (wday(HOP$ENTREE) == 
    6 & hour(HOP$ENTREE) > 19) | (wday(HOP$ENTREE) == 2 & hour(HOP$ENTREE) < 
    8)]
```

```
## Error: objet 'HOP' introuvable
```

```r
f <- summary(as.factor(wday(d)))
```

```
## Error: objet 'd' introuvable
```

### Week-end: 

```

Error in eval(expr, envir, enclos) : objet 'd' introuvable

```

 dossiers (

```

Error in eval(expr, envir, enclos) : objet 'd' introuvable

```

 %)

Gravité
--------

```r
d <- HOP$GRAVITE
```

```
## Error: objet 'HOP' introuvable
```

```r
a <- summary(d)
```

```
## Error: objet 'd' introuvable
```


### CCMU 1: 0011 (

```

Error in a[1] * 100 : argument non numérique pour un opérateur binaire

```

 %)

### CCMU 4 & 5: 

```

Error in a[4] + a[5] : argument non numérique pour un opérateur binaire

```

 (

```

Error in a[4] + a[5] : argument non numérique pour un opérateur binaire

```

 %)

Durée de prise en charge
-------------------------

```r
e <- ymd_hms(HOP$ENTREE)
```

```
## Error: objet 'HOP' introuvable
```

```r
s <- ymd_hms(HOP$SORTIE)
```

```
## Error: objet 'HOP' introuvable
```

```r

HOP$presence <- s - e
```

```
## Error: objet 's' introuvable
```

```r
HOP$presence[d1$presence < 0] <- NA
```

```
## Error: objet 'HOP' introuvable
```

```r

# HOP$presence est de type 'difftime' est peut s'exprimer en minutes ou en
# secondes. Si nécessaire on convertit les secondes en minutes:
if (units(HOP$presence) == "secs") HOP$presence <- HOP$presence/60
```

```
## Error: objet 'HOP' introuvable
```

```r

a <- summary(as.numeric(HOP$presence))
```

```
## Error: objet 'HOP' introuvable
```

```r

# on limite la durée de présence limitée à 1 jours
troisJours <- HOP[as.numeric(HOP$presence) < 1440 * 1, "presence"]
```

```
## Error: objet 'HOP' introuvable
```

```r
hist(as.numeric(troisJours), breaks = 40, main = "Durée de présence", xlab = "Temps (minutes)", 
    ylab = "Nombre", col = "green")
```

```
## Error: objet 'troisJours' introuvable
```

```r

# histogramme avec toutes les données:
hist(as.numeric(HOP$presence), breaks = 40, main = "Durée de présence", xlab = "Temps (minutes)", 
    ylab = "Nombre", col = "green")
```

```
## Error: objet 'HOP' introuvable
```

```r


q <- HOP$presence[as.numeric(HOP$presence) < 4 * 60]
```

```
## Error: objet 'HOP' introuvable
```

```r
h <- HOP[HOP$MODE_SORTIE == "Mutation" | HOP$MODE_SORTIE == "Transfert", "presence"]
```

```
## Error: objet 'HOP' introuvable
```

```r
sh <- summary(as.numeric(h))
```

```
## Error: objet 'h' introuvable
```

```r
sh
```

```
## Error: objet 'sh' introuvable
```

```r
dom <- HOP[HOP$MODE_SORTIE == "Domicile", "presence"]
```

```
## Error: objet 'HOP' introuvable
```

```r
sdom <- summary(as.numeric(dom))
```

```
## Error: objet 'dom' introuvable
```

### Moyenne: NA minutes

### Médiane: NA minutes

### % en moins de 4 heures: 1 (

```

Error in eval(expr, envir, enclos) : objet 'HOP' introuvable

```

 %)

### si hospitalisé: 

```

Error in eval(expr, envir, enclos) : objet 'sh' introuvable

```

 minutes

### si retour à domicile: 

```

Error in eval(expr, envir, enclos) : objet 'sdom' introuvable

```

 minutes

### Taux hospitalisation: 

```

Error in eval(expr, envir, enclos) : objet 'h' introuvable

```

 %

TOP 5 des pathologies
---------------------
### Médicales

### Traumatiques

```r
trauma <- HOP[substr(HOP$DP, 1, 3) >= "S00" & substr(HOP$DP, 1, 4) <= "T65", 
    ]
```

```
## Error: objet 'HOP' introuvable
```

```r
head(trauma$DP)
```

```
## Error: objet 'trauma' introuvable
```

```r
t <- summary(as.factor(trauma$DP))
```

```
## Error: objet 'trauma' introuvable
```

```r
head(sort(t, decreasing = T), 6)
```

```
## Error: 'x' must be atomic
```

traumato: 

```

Error in nrow(trauma) : objet 'trauma' introuvable

```

 soit 

```

Error in nrow(trauma) : objet 'trauma' introuvable

```

 %  
Lésions les plus fréquentes: 

```

Error in sort.int(x, na.last = na.last, decreasing = decreasing, ...) : 
  'x' must be atomic

```

  


### Chirurgicales
