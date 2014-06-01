Analyse des données Par Territoire de santé (ex.secteur sanitaires)
===================================================================

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
library("gplots")
```

```
## Loading required package: gtools
## Loading required package: gdata
## gdata: read.xls support for 'XLS' (Excel 97-2004) files ENABLED.
## 
## gdata: read.xls support for 'XLSX' (Excel 2007+) files ENABLED.
## 
## Attaching package: 'gdata'
## 
## L'objet suivant est masqué from 'package:questionr':
## 
##     duplicated2
## 
## L'objet suivant est masqué from 'package:stats':
## 
##     nobs
## 
## L'objet suivant est masqué from 'package:utils':
## 
##     object.size
## 
## Loading required package: caTools
## Loading required package: grid
## Loading required package: KernSmooth
## KernSmooth 2.23 loaded
## Copyright M. P. Wand 1997-2009
## 
## Attaching package: 'gplots'
## 
## L'objet suivant est masqué from 'package:plotrix':
## 
##     plotCI
## 
## L'objet suivant est masqué from 'package:stats':
## 
##     lowess
```

```r
library("multcomp")
```

```
## Loading required package: mvtnorm
## Loading required package: TH.data
```

entrées par Territoire de santé
-------------------------------
On creé une colonne supplémentaire *secteur* qui indique à quel secteur sanitaire correspond le RPU:

Nombre de RPU par secteur de santé

```r
tapply(d1$ENTREE,d1$secteur,length)
```

```
##      1      2      3      4 
##  59484  62981 109395 112213
```
Remarques:
- en 2013: secteur 2, manque St Anne, pediatrie HTP, une partie des RPU HUS adultes. Secteur 4, manque CH Thann.
- en 2014: en cours d'année apparaissent St Anne, pédiatrie HUS (avril 2014), Diaconat Roosvelt (), Diaconat Strasbourg (). La clinique des 3 frontières deveint propriété du CH de Mulhouse et change de Finess (Mai 2014). CH Thann en attente absobtion par Mulhouse (2015) ne fornit pas de RPU.

Age moyen
----------

```r
tapply(d1$AGE,d1$secteur,mean, na.rm=TRUE)
```

```
##     1     2     3     4 
## 44.44 48.05 36.47 37.97
```

```r
tapply(d1$AGE,d1$secteur,sd, na.rm=TRUE)
```

```
##     1     2     3     4 
## 27.06 25.10 26.95 26.58
```

```r
tapply(d1$AGE,d1$secteur,median, na.rm=TRUE)
```

```
##  1  2  3  4 
## 43 47 32 35
```

```r
boxplot(d1$AGE ~ d1$secteur)
```

![plot of chunk age](figure/age1.png) 

```r
age <- d1$AGE
territoire <- d1$secteur
mod <- aov(age ~ territoire)
mod
```

```
## Call:
##    aov(formula = age ~ territoire)
## 
## Terms:
##                 territoire Residuals
## Sum of Squares     7009240 241978093
## Deg. of Freedom          3    344059
## 
## Residual standard error: 26.52
## Estimated effects may be unbalanced
## 10 observations deleted due to missingness
```

```r
summary(mod)
```

```
##                 Df   Sum Sq Mean Sq F value Pr(>F)    
## territoire       3 7.01e+06 2336413    3322 <2e-16 ***
## Residuals   344059 2.42e+08     703                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 10 observations deleted due to missingness
```

```r
plotmeans(age ~ territoire, ylab="Age moyen",  p=0.9999999, xlab="Territoire de santé", main = "Age moyen selon le territoire de santé\n(avec intervalle de confiance à 99%)")
```

![plot of chunk age](figure/age2.png) 

```r
TukeyHSD(mod)
```

```
##   Tukey multiple comparisons of means
##     95% family-wise confidence level
## 
## Fit: aov(formula = age ~ territoire)
## 
## $territoire
##        diff     lwr     upr p adj
## 2-1   3.607   3.218   3.997     0
## 3-1  -7.972  -8.320  -7.625     0
## 4-1  -6.474  -6.819  -6.128     0
## 3-2 -11.580 -11.920 -11.239     0
## 4-2 -10.081 -10.420  -9.742     0
## 4-3   1.499   1.209   1.788     0
```

```r
par(las=2)
par(mar=c(5,8,4,2))
plot(TukeyHSD(mod))
```

![plot of chunk age](figure/age3.png) 

```r
tuk <- glht(mod, linfct=mcp(territoire="Tukey"))
par(las=1)
plot(cld(tuk, levels=0.05), col="lightgray")
```

![plot of chunk age](figure/age4.png) 

L'intervalle de confiance a été augmenté à  p=0.9999999 pour qu'il soit visible. A p = 0.95 on ne les voit âs car inférieurs à 1 et des messages d'avertissement sont générés. La méthode __plotCI__ fait la même chose (voir notamment le premier exemple de cette méthode).

Age moyen des adultes
---------------------

Une critique de l'analyse précédente est que l'absence de la pédiatrie strasbourgeoise explique la moyenne d'age plus élevée dans le secteur 2. On refait la même analyse uniquement avec les 18 ans et plus:


```r
age <- d1$AGE[d1$AGE > 17]
territoire <- d1$secteur[d1$AGE > 17]

tapply(d1$AGE,d1$secteur,mean, na.rm=TRUE)
```

```
##     1     2     3     4 
## 44.44 48.05 36.47 37.97
```

```r
tapply(d1$AGE,d1$secteur,sd, na.rm=TRUE)
```

```
##     1     2     3     4 
## 27.06 25.10 26.95 26.58
```

```r
tapply(d1$AGE,d1$secteur,median, na.rm=TRUE)
```

```
##  1  2  3  4 
## 43 47 32 35
```

```r
boxplot(d1$AGE ~ d1$secteur)
```

![plot of chunk adultes](figure/adultes1.png) 

```r
mod <- aov(age ~ territoire)
mod
```

```
## Call:
##    aov(formula = age ~ territoire)
## 
## Terms:
##                 territoire Residuals
## Sum of Squares      608272 124526395
## Deg. of Freedom          3    260614
## 
## Residual standard error: 21.86
## Estimated effects may be unbalanced
## 10 observations deleted due to missingness
```

```r
summary(mod)
```

```
##                 Df   Sum Sq Mean Sq F value Pr(>F)    
## territoire       3 6.08e+05  202757     424 <2e-16 ***
## Residuals   260614 1.25e+08     478                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 10 observations deleted due to missingness
```

```r
plotmeans(age ~ territoire, ylab="Age moyen",  p=0.95, xlab="Territoire de santé", main = "Age moyen selon le territoire de santé\n(avec intervalle de confiance à 95%)")
```

![plot of chunk adultes](figure/adultes2.png) 

```r
TukeyHSD(mod)
```

```
##   Tukey multiple comparisons of means
##     95% family-wise confidence level
## 
## Fit: aov(formula = age ~ territoire)
## 
## $territoire
##        diff     lwr     upr  p adj
## 2-1 -0.3167 -0.6658  0.0323 0.0910
## 3-1 -3.0743 -3.4027 -2.7459 0.0000
## 4-1 -3.4467 -3.7694 -3.1239 0.0000
## 3-2 -2.7576 -3.0713 -2.4438 0.0000
## 4-2 -3.1299 -3.4378 -2.8220 0.0000
## 4-3 -0.3723 -0.6566 -0.0881 0.0043
```

```r
par(las=2)
par(mar=c(5,8,4,2))
plot(TukeyHSD(mod))
```

![plot of chunk adultes](figure/adultes3.png) 

```r
tuk <- glht(mod, linfct=mcp(territoire="Tukey"))
par(las=1)
plot(cld(tuk, levels=0.05), col="lightgray")
```

![plot of chunk adultes](figure/adultes4.png) 

