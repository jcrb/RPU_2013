Diagnostic principal
========================================================
On récupère la colonne diagnostic principal DP. Contient le code CIM10 des DP. Certaines adaptations sont nécessaires:
- suppression du point décimal (K36.2 devient K362)
- suppression du symbole '+'
- correction de codes apparaissant en clair pyélonéphrite N11



Analyse spécifique de certains items:
- AVC
- AIT
- Asthme
- gastro-entérites


```r
#'@param dp liste brute des diagnostics
#'@param dpr liste des diag sans les NA. Les intitulés sont standardisés par suppression du point. Ainsi I60.9 devient I609 (méthode gsub)
#'@param ndp nombre de DP bruts (NA inclus)
#'@param ndpr nombre de DP renseignés

library("epicalc")
```

```
## Loading required package: foreign
## Loading required package: survival
## Loading required package: splines
## Loading required package: MASS
## Loading required package: nnet
```

```r
library("lubridate")

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
d1 <- foo(path, file)

# load('../../rpu2013d0107.Rda') d1<-d0107 rm(d0107)

dp <- d1$DP
ndp <- length(dp)
dpr <- dp[!is.na(dp)]
dpr <- d1[!is.na(d1$DP), c("DP", "CODE_POSTAL", "ENTREE", "FINESS", "GRAVITE", 
    "ORIENTATION", "MODE_SORTIE", "AGE", "SEXE", "TRANSPORT")]
dpr$DP <- gsub("\xe9", "é", dpr$DP)
dpr$DP <- gsub(".", "", dpr$DP, fixed = TRUE)

# dpr$DP<-gsub('.','',as.character(dpr$DP),fixed=TRUE)
dpr$DP <- gsub("+", "", dpr$DP, fixed = TRUE)
```

Nombre de diagnostics principaux (DP)

```r
ndpr <- nrow(dpr)
ndpr
```

```
## [1] 228524
```

Exhaustivité

```r
ex <- round(ndpr * 100/ndp, 2)
ex
```

```
## [1] 66.42
```

Nombre de diagnostic uniques:

```r
a <- length(unique(dpr$DP))
a
```

```
## [1] 4851
```

```r
a <- substr(dpr, 1, 1)
tab1(a, horiz = T, sort.group = "decreasing", main = "Classes dignostiques de la CIM10")
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

```
## a : 
##         Frequency Percent Cum. percent
## c              10     100          100
##   Total        10     100          100
```


Etude des AVC
-------------
Les AVC sont définis par la nomenclature *I60* à *I64*, *G45* Accidents ischémiques cérébraux transitoires (sauf G45.4 amnésie transitoire) et syndromes apparentés et *G46* Syndromes vasculaires cérébraux au cours de maladies cérébrovasculaires

La prévention et la prise en charge des accidents vasculaires cérébraux - Annexes -
juin 2009

Annexe : Liste exhaustive des codes CIM-10 d’AVC

- G450 Syndrome vertébro-basilaire
- G451 Syndrome carotidien (hémisphérique)
- G452 Accident ischémique transitoire de territoires artériels précérébraux multipleset bilatéraux
- G453 Amaurose fugace
- G454 Amnésie globale transitoire : NON RETENU
- G458 Autres accidents ischémiques cérébraux transitoires et syndromes apparentés
- G459 Accident ischémique cérébral transitoire, sans précision
- I600 Hémorragie sous-arachnoïdienne de labifurcation et du siphon carotidien
- I601 Hémorragie sous-arachnoïdienne de l'artère cérébrale moyenne
- I602 Hémorragie sous-arachnoïdienne de
- l'artère communicante antérieure
- I603 Hémorragie sous-arachnoïdienne del'artère communicante postérieure
- I604 Hémorragie sous-arachnoïdienne de l'artère basilaire
- I605 Hémorragie sous-arachnoïdienne de l'artère vertébrale
- I606 Hémorragie sous-arachnoïdienne d'autres artères intracrâniennes
- I607 Hémorragie sous-arachnoïdienne d'une ar
tère intracrânienne, sans précision
- I608 Autres hémorragies sous-arachnoïdiennes
- I609 Hémorragie sous-arachnoïdienne, sans précision
- I610 Hémorragie intracérébrale hémisphérique, sous-corticale
- I611 Hémorragie intracérébrale hémisphérique, corticale
- I612 Hémorragie intracérébrale hémisphérique, non précisée
- I613 Hémorragie intracérébrale du tronc cérébral
- I614 Hémorragie intracérébrale cérébelleuse
- I615 Hémorragie intracérébrale intraventriculaire
- I616 Hémorragie intracérébrale,localisations multiples
- I618 Autres hémorragies intracérébrales
- I619 Hémorragie intracérébrale, sans précision
- I620 Hémorragie sous-durale (aiguë) (non traumatique)
- I621 Hémorragie extradurale non traumatique
- I629 Hémorragie intracrânienne (non traumatique), sans précision
- I630 Infarctus cérébral dû à une thrombose des artères précérébrales
- I631 Infarctus cérébral dû à une embolie des artères précérébrales
- I632 Infarctus cérébral dû à une occlusion ou sténose des artères précérébrales,de mécanisme non précisé
- I633 Infarctus cérébral dû à une thrombose des artères cérébrales
- I634 Infarctus cérébral dû à une embolie des artères cérébrales
- I635 Infarctus cérébral dû à une occlusion ou sténose des artères cérébrales, demécanisme non précisé
- I636 Infarctus cérébral dû à une thrombose veineuse cérébrale, non pyogène
- I638 Autres infarctus cérébraux
- I639 Infarctus cérébral, sans précision
- I64 Accident vasculaire cérébral, non précisé comme étant hémorragique ou parinfarctus
- G460 Syndrome de l'artère cérébrale moyenne (I66.0) (1)
- G461 Syndrome de l'artère cérébrale antérieure (I66.1) (1)
- G462 Syndrome de l'artère cérébrale postérieure (I66.2) (1)
- G463 Syndromes vasculaires du tronc cérébral (I60-I67) (1)
- G464 Syndrome cérébelleux vasculaire (I60-I67) (1)
- G465 Syndrome lacunaire moteur pur (I60-I67) (1)
- G466 Syndrome lacunaire sensitif pur (I60-I67) (1)
- G467 Autres syndromes lacunaires (I60-I67) (1)
- G468 Autres syndromes vasculaires cérébraux au cours de maladies cérébrovasculaires (I60-I67) (1)
(1) : résumé à ne retenir que si présence d’un diagnostic associé significatif (DAS) des catégories I60 à I64


```r
#'@param avc liste des AVC
#'@param navc liste des codes Cim10 utilisés

avc <- dpr[substr(dpr$DP, 1, 3) >= "I60" & substr(dpr$DP, 1, 3) < "I65" | substr(dpr$DP, 
    1, 3) == "G46", ]
navc <- unique(avc)
summary(as.factor(avc$DP))
```

```
## G460 G462 G463 G464 G467 G468 I600 I601 I602 I606 I607 I608 I609 I610 I611 
##    6    1    1   13   16    3    2    5    3    1    2   36   21   80   27 
## I612 I613 I614 I615 I616 I618 I619 I620 I621 I629 I630 I631 I632 I633 I634 
##   21    2   10    6   22   16   22   19    2   78   13    1    4   27   14 
## I635 I636 I638 I639  I64 
##   21    1   66  637  853
```

```r

tab1(avc$DP, horiz = TRUE, sort.group = "decreasing", main = "AVC aux urgences (hors filière UNV", 
    missing = FALSE)
```

![plot of chunk avc](figure/avc.png) 

```
## avc$DP : 
##         Frequency Percent Cum. percent
## I64           853    41.6         41.6
## I639          637    31.0         72.6
## I610           80     3.9         76.5
## I629           78     3.8         80.3
## I638           66     3.2         83.5
## I608           36     1.8         85.3
## I633           27     1.3         86.6
## I611           27     1.3         87.9
## I619           22     1.1         89.0
## I616           22     1.1         90.1
## I635           21     1.0         91.1
## I612           21     1.0         92.1
## I609           21     1.0         93.1
## I620           19     0.9         94.1
## I618           16     0.8         94.8
## G467           16     0.8         95.6
## I634           14     0.7         96.3
## I630           13     0.6         96.9
## G464           13     0.6         97.6
## I614           10     0.5         98.1
## I615            6     0.3         98.3
## G460            6     0.3         98.6
## I601            5     0.2         98.9
## I632            4     0.2         99.1
## I602            3     0.1         99.2
## G468            3     0.1         99.4
## I621            2     0.1         99.5
## I613            2     0.1         99.6
## I607            2     0.1         99.7
## I600            2     0.1         99.8
## I636            1     0.0         99.8
## I631            1     0.0         99.9
## I606            1     0.0         99.9
## G463            1     0.0        100.0
## G462            1     0.0        100.0
##   Total      2052   100.0        100.0
```

# Etude des AVC+AIT

avc_ait<-dpr[substr(dpr$DP,1,3)>="I60" & substr(dpr$DP,1,3)<"I65" | substr(dpr$DP,1,3)=="G46" | substr(dpr$DP,1,3)=="G45"]

tab1(avc_ait,horiz=TRUE,sort.group="decreasing",main="AVC&AIT aux urgences (hors filière UNV",missing=FALSE)

# Création d'un dataframe DP



extraction d'un DF avc:

```r
AVC <- dpr[substr(dpr$DP, 1, 3) >= "I60" & substr(dpr$DP, 1, 3) < "I65" | substr(dpr$DP, 
    1, 3) == "G46" | substr(dpr$DP, 1, 3) == "G45", ]
```

Horaire des AVC  
à comparer avec
- les crises d'épilepsie
- la pression athmosphérique

![plot of chunk heure_avc](figure/heure_avc1.png) ![plot of chunk heure_avc](figure/heure_avc2.png) 

```
## h : 
##         Frequency Percent Cum. percent
## 0              45     1.6          1.6
## 1              38     1.4          3.0
## 2              35     1.2          4.2
## 3              29     1.0          5.2
## 4              17     0.6          5.9
## 5              26     0.9          6.8
## 6              25     0.9          7.7
## 7              49     1.8          9.4
## 8             100     3.6         13.0
## 9             173     6.2         19.2
## 10            238     8.5         27.7
## 11            246     8.8         36.5
## 12            200     7.1         43.6
## 13            175     6.2         49.9
## 14            201     7.2         57.0
## 15            172     6.1         63.2
## 16            181     6.5         69.6
## 17            197     7.0         76.7
## 18            171     6.1         82.8
## 19            129     4.6         87.4
## 20            150     5.4         92.8
## 21             80     2.9         95.6
## 22             68     2.4         98.0
## 23             55     2.0        100.0
##   Total      2800   100.0        100.0
```

Selon le jour de la semaine


```
## w
##   Sun   Mon  Tues   Wed Thurs   Fri   Sat 
##   323   467   457   399   396   408   350
```

```
## w
##   Sun   Mon  Tues   Wed Thurs   Fri   Sat 
## 11.54 16.68 16.32 14.25 14.14 14.57 12.50
```

![plot of chunk avc_semaine](figure/avc_semaine.png) 

Proportion théorique = 14.28% par jour de la semaine

AVC selon le mois
-----------------

```
## m
## Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
## 235 191 229 270 251 258 250 254 209 201 216 236
```

![plot of chunk avc_mois](figure/avc_mois1.png) ![plot of chunk avc_mois](figure/avc_mois2.png) 

```
## m : 
##         Frequency Percent Cum. percent
## Jan           235     8.4          8.4
## Feb           191     6.8         15.2
## Mar           229     8.2         23.4
## Apr           270     9.6         33.0
## May           251     9.0         42.0
## Jun           258     9.2         51.2
## Jul           250     8.9         60.1
## Aug           254     9.1         69.2
## Sep           209     7.5         76.7
## Oct           201     7.2         83.9
## Nov           216     7.7         91.6
## Dec           236     8.4        100.0
##   Total      2800   100.0        100.0
```

AVC par semaine
---------------
![plot of chunk avc_week](figure/avc_week.png) 



Age et AVC
----------

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     1.0    62.0    75.0    71.4    84.0   112.0
```

Le rapport de 2009 donne age moyen = 70.5 et age médian = 75 ans.

Sexe et AVC
-----------

```r
summary(AVC$SEXE)
```

```
##    F    I    M 
## 1476    0 1324
```

```r
hist(AVC$AGE, main = "Répartition des AVC", col = "pink", xlab = "Age en années")
```

![plot of chunk avc_sexe](figure/avc_sexe1.png) 

```r
t <- table(AVC$AGE)
barplot(t, main = "AVC - Répartition des ages")
```

![plot of chunk avc_sexe](figure/avc_sexe2.png) 

```r
t <- table(AVC$SEXE, AVC$AGE)
barplot(t, col = c("darkblue", "white", "red"), legend = TRUE)
```

![plot of chunk avc_sexe](figure/avc_sexe3.png) 

```r
barplot(t, col = c("yellow", "red"), legend = TRUE, beside = TRUE)
```

![plot of chunk avc_sexe](figure/avc_sexe4.png) 

Etude AIT
---------
Recommandations pour la sélection des données PMSI MCO concernant l’AVC (Juin 2009)
- G450 Syndrome vertébro-basilaire
- G451 Syndrome carotidien (hémisphérique)
- G452 Accident ischémique transitoire de territoires artériels précérébraux multiples et bilatéraux
- G453  Amaurose fugace
- G458  Autres accidents ischémiques cérébraux transitoires et syndromes apparentés
- G459  Accident ischémique cérébral transitoire, sans précision  

```r
ait <- dpr$DP[substr(dpr$DP, 1, 3) == "G45" & substr(dpr$DP, 1, 4) != "G454"]
tab1(ait, missing = FALSE)
```

![plot of chunk ait](figure/ait.png) 

```
## ait : 
##         Frequency Percent Cum. percent
## G450            4     0.6          0.6
## G451            7     1.0          1.6
## G452           20     2.8          4.4
## G453            7     1.0          5.4
## G458           52     7.4         12.7
## G459          617    87.3        100.0
##   Total       707   100.0        100.0
```


Asthme
======

J45.0 Asthme à prédominance allergique  
J45.1 Asthme non allergique  
J45.8 Asthme associé  
J45.9 Asthme, sans précision  
J46   Etat de mal asthmatique


```
## [1] 1398
```

```
## J450 J451 J458 J459  J46 
##  133  205    8  999   53
```

![plot of chunk asthme](figure/asthme1.png) 

```
## as.factor(asthme$DP) : 
##         Frequency Percent Cum. percent
## J450          133     9.5          9.5
## J451          205    14.7         24.2
## J458            8     0.6         24.7
## J459          999    71.5         96.2
## J46            53     3.8        100.0
##   Total      1398   100.0        100.0
```

![plot of chunk asthme](figure/asthme2.png) ![plot of chunk asthme](figure/asthme3.png) 

```
## table(s) : 
##         Frequency Percent Cum. percent
## 7               1     1.9          1.9
## 8               1     1.9          3.8
## 11              1     1.9          5.7
## 13              2     3.8          9.4
## 14              2     3.8         13.2
## 15              1     1.9         15.1
## 17              2     3.8         18.9
## 19              1     1.9         20.8
## 20              1     1.9         22.6
## 21              3     5.7         28.3
## 22              4     7.5         35.8
## 23              3     5.7         41.5
## 24              1     1.9         43.4
## 25              3     5.7         49.1
## 26              5     9.4         58.5
## 27              3     5.7         64.2
## 28              2     3.8         67.9
## 29              1     1.9         69.8
## 30              1     1.9         71.7
## 31              1     1.9         73.6
## 32              2     3.8         77.4
## 33              1     1.9         79.2
## 34              1     1.9         81.1
## 37              2     3.8         84.9
## 40              1     1.9         86.8
## 41              3     5.7         92.5
## 44              1     1.9         94.3
## 45              1     1.9         96.2
## 47              1     1.9         98.1
## 50              1     1.9        100.0
##   Total        53   100.0        100.0
```

```
##       DP             CODE_POSTAL     ENTREE              FINESS   
##  Length:1398        68000  :143   Length:1398        Mul    :454  
##  Class :character   68200  :105   Class :character   Col    :377  
##  Mode  :character   68100  : 98   Mode  :character   Sel    :171  
##                     67600  : 49                      Hag    : 87  
##                     68500  : 45                      Hus    : 74  
##                     67100  : 40                      3Fr    : 66  
##                     (Other):918                      (Other):169  
##     GRAVITE     ORIENTATION     MODE_SORTIE       AGE       SEXE   
##  2      :880   MED    :248   NA       :  0   Min.   : 0.0   F:693  
##  3      :325   UHCD   :126   Mutation :468   1st Qu.: 3.0   I:  0  
##  1      :150   SC     : 76   Transfert: 19   Median :13.0   M:705  
##  4      : 24   REA    : 11   Domicile :788   Mean   :22.9          
##  5      :  5   CHIR   :  5   Décès    :  0   3rd Qu.:39.0          
##  (Other):  0   (Other):  7   NA's     :123   Max.   :97.0          
##  NA's   : 14   NA's   :925                                         
##  TRANSPORT  
##  AMBU :131  
##  FO   :  1  
##  HELI :  1  
##  PERSO:949  
##  SMUR : 38  
##  VSAB :108  
##  NA's :170
```

```
##    1    2    3    4    5    D    P NA's 
##  150  880  325   24    5    0    0   14
```

![plot of chunk asthme](figure/asthme4.png) ![plot of chunk asthme](figure/asthme5.png) 

Gravité des crises: prédominance CCMU  2  et 3 et qulques 4 ou 5   
hospit = mutation+tranfert = 323+13=336  
taux hospit supérieur à 30% (336/1001)   
taux hospit en services chaud (SI+SC+Rea): 52/1001= 5.2% et 52/323= 16% des hospit   
age: moyenne 24 ans(médiane 14 ans)   
sex ratio: 0.98  

Crise asthme hospitalisée et lieu d'hospitalisation:

```r
table(asthme$DP, asthme$ORIENTATION)
```

```
##       
##        CHIR FUGUE HDT  HO MED OBST PSA REA REO  SC SCAM  SI UHCD
##   J450    0     0   1   0  12    1   0   2   0   0    0   0   18
##   J451    1     0   0   0  36    0   0   0   0  21    0   0    5
##   J458    0     0   0   0   5    0   0   1   0   0    0   0    0
##   J459    3     0   0   0 179    2   0   4   0  44    2   1  101
##   J46     1     0   0   0  16    0   0   4   0  11    0   0    2
```

#### Remarques INVS:
Ce bulletin (Le point épidémiologique du 24 octobre 2013 | Surveillance épidémiologique de la Cire Lorraine-Alsace) clôt la surveillance de l’asthme. Pour l’association SOS Médecins de Strasbourg,
l’activité liée à l’asthme a été particulièrement marqué de mi-avril (semaine 16) à fin mai
(semaine 22) puis en semaine 40. Concernant l’association de Mulhouse, seule une forte
augmentation en semaine 39 a été observée depuis début avril.

Intoxications par les champignons
=================================
CIM10 = T62


```r
champ <- dpr[substr(dpr$DP, 1, 3) == "T62", ]
summary(champ)
```

```
##       DP             CODE_POSTAL    ENTREE              FINESS  
##  Length:64          68200  : 7   Length:64          Mul    :15  
##  Class :character   67600  : 4   Class :character   Col    :11  
##  Mode  :character   68300  : 3   Mode  :character   Sel    :10  
##                     68720  : 3                      Geb    : 6  
##                     67100  : 2                      3Fr    : 5  
##                     67220  : 2                      Alk    : 5  
##                     (Other):43                      (Other):12  
##     GRAVITE    ORIENTATION    MODE_SORTIE      AGE       SEXE   TRANSPORT 
##  2      :39   UHCD   :11   NA       : 0   Min.   : 0.0   F:32   AMBU :13  
##  1      :14   CHIR   : 1   Mutation :13   1st Qu.:14.0   I: 0   FO   : 0  
##  3      :10   SC     : 1   Transfert: 0   Median :30.0   M:32   HELI : 0  
##  4      : 0   FUGUE  : 0   Domicile :45   Mean   :32.1          PERSO:37  
##  5      : 0   HDT    : 0   Décès    : 0   3rd Qu.:44.0          SMUR : 0  
##  (Other): 0   (Other): 0   NA's     : 6   Max.   :91.0          VSAB : 7  
##  NA's   : 1   NA's   :51                                        NA's : 7
```

Intoxication au CO
==================
CIM10 = T58


```r
co <- dpr[substr(dpr$DP, 1, 3) == "T58", ]
m <- month(co$ENTREE, label = T)
table(m)
```

```
## m
## Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
##   5  13  11   0   6   9   0   1   1   1  15   4
```

```r
barplot(table(m), main = "Intoxication au CO - 2013", xlab = "Mois")
```

![plot of chunk co](figure/co.png) 

Bronchiolite
============
Bronchiolite aiguë

Inclus:
    avec bronchospasme

J21.0 Bronchiolite aiguë due au virus respiratoire syncytial [VRS]
J21.8 Bronchiolite aiguë due à d'autres micro-organismes précisés
J21.9 Bronchiolite aiguë, sans précision


```r
bron <- dpr[substr(dpr$DP, 1, 3) == "J21", ]
m <- month(bron$ENTREE, label = T)
barplot(table(m), main = "Bronchiolites - 2013", xlab = "Mois")
```

![plot of chunk bron](figure/bron1.png) 

```r
s <- week(bron$ENTREE)
barplot(table(s), main = "Bronchiolites - 2013", xlab = "Semaines")
```

![plot of chunk bron](figure/bron2.png) 

```r
summary(bron)
```

```
##       DP             CODE_POSTAL     ENTREE              FINESS   
##  Length:567         68200  :107   Length:567         Mul    :460  
##  Class :character   68100  :100   Class :character   Sel    : 51  
##  Mode  :character   68270  : 26   Mode  :character   Col    : 20  
##                     68300  : 20                      Wis    : 17  
##                     67600  : 16                      3Fr    : 12  
##                     67160  : 12                      Geb    :  2  
##                     (Other):286                      (Other):  5  
##     GRAVITE     ORIENTATION     MODE_SORTIE       AGE       SEXE   
##  2      :301   MED    :128   NA       :  0   Min.   : 0.0   F:238  
##  3      :188   SC     :115   Mutation :250   1st Qu.: 0.0   I:  0  
##  1      : 66   REA    :  4   Transfert:  0   Median : 0.0   M:329  
##  4      :  6   UHCD   :  4   Domicile :271   Mean   : 1.1          
##  5      :  3   PSA    :  1   Décès    :  0   3rd Qu.: 0.0          
##  (Other):  0   (Other):  1   NA's     : 46   Max.   :93.0          
##  NA's   :  3   NA's   :314                                         
##  TRANSPORT  
##  AMBU : 13  
##  FO   :  0  
##  HELI :  0  
##  PERSO:495  
##  SMUR :  0  
##  VSAB :  3  
##  NA's : 56
```

Surreprésentation de Mul  
taux hospitalisation: 50%

Gastro-entérites
================
CIM10 A09 : Diarrhée et gastro-entérite d'origine présumée infectieuse

Note:

    Dans les pays où les affections énumérées en A09 sans précision supplémentaire peuvent être présumées d'origine non infectieuse, les classer en K52.9.

Inclus:
    Catarrhe intestinal

        Colite
        Entérite
        Gastro-entérite
        SAI
        hémorragique
        septique

    Diarrhée:

        SAI
        dysentérique
        épidémique

    Maladie diarrhéique infectieuse SAI

Excl.:
    diarrhée non infectieuse (K52.9)

        néonatale (P78.3) 

    maladies dues à des bactéries, des protozoaires, des virus et d'autres agents infectieux précisés (A00-A08)  
    

```r
ge <- dpr[substr(dpr$DP, 1, 3) == "A09", ]
summary(ge)
```

```
##       DP             CODE_POSTAL      ENTREE              FINESS    
##  Length:2681        68200  : 329   Length:2681        Mul    :1411  
##  Class :character   68100  : 304   Class :character   Col    : 363  
##  Mode  :character   68300  : 157   Mode  :character   3Fr    : 228  
##                     68000  : 142                      Wis    : 170  
##                     68500  :  81                      Geb    : 150  
##                     67160  :  70                      Sel    : 123  
##                     (Other):1598                      (Other): 236  
##     GRAVITE      ORIENTATION      MODE_SORTIE        AGE        SEXE    
##  2      :1797   MED    : 248   NA       :   0   Min.   :  0.0   F:1346  
##  1      : 589   UHCD   : 129   Mutation : 439   1st Qu.:  1.0   I:   0  
##  3      : 261   SC     :  31   Transfert:   3   Median :  5.0   M:1335  
##  4      :  14   CHIR   :   4   Domicile :1989   Mean   : 17.5           
##  5      :   0   HO     :   1   Décès    :   0   3rd Qu.: 27.0           
##  (Other):   0   (Other):   5   NA's     : 250   Max.   :100.0           
##  NA's   :  20   NA's   :2263                                            
##  TRANSPORT   
##  AMBU : 245  
##  FO   :   0  
##  HELI :   0  
##  PERSO:2129  
##  SMUR :  10  
##  VSAB :  63  
##  NA's : 234
```

```r
table(ge$FINESS, ge$DP)
```

```
##      
##        A09 A090 A099
##   3Fr    0   50  178
##   Alk    0   15   35
##   Col  302   43   18
##   Dia    0    0    0
##   Geb    0   27  123
##   Hag    0   40   21
##   Hus    0   46   31
##   Mul 1411    0    0
##   Odi    0   13   35
##   Sel    0   61   62
##   Wis    0   81   89
##   Sav    0    0    0
```

```r
hist(ge$AGE, main = "Gasto-entérites - 2013", xlab = "Age (années)", ylab = "nombre", 
    col = "gray90")
```

![plot of chunk ge](figure/ge1.png) 

```r
boxplot(ge$AGE, col = "yellow", main = "Gastro-entérite", ylab = "age (années)")
```

![plot of chunk ge](figure/ge2.png) 

```r
m <- month(ge$ENTREE, label = T)
x <- barplot(table(m), main = "Gestro-entérites - 2013", xlab = "Mois")
lines(x = x, y = table(m), col = "red")
```

![plot of chunk ge](figure/ge3.png) 

#### NOTE TECHNIQUE: tracer une ligne joignant les sommets des barres du barplot. On utilise lines avec les valeurs suivantes:
- x = abcisse des colonnes. Elles sont contenues dans l'objet barplot. On peut les recueillir eplicitement par la fonction *str* (str(x)).
- y = ordonnées des barres, récupérées avec la fonction *table* qui agglomère les données par mois
Voir aussi: http://www.ats.ucla.edu/stat/r/faq/barplotplus.htm

#### calculs à la manière de l'INVS

nombre de diagnostics de GE / nb total de diagnostics par semaine:

```r
mge <- month(ge$ENTREE, label = T)
mtot <- month(dpr$ENTREE, label = T)
summary(mtot)
```

```
##   Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec 
## 18392 18052 19523 20302 19207 20772 20387 19275 18272 18519 17387 18436
```

```r
summary(mge)
```

```
## Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec 
## 306 240 264 282 181 168 173 219 174 165 149 360
```

```r
a <- round(summary(mge) * 100/summary(mtot), 2)
a
```

```
##  Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec 
## 1.66 1.33 1.35 1.39 0.94 0.81 0.85 1.14 0.95 0.89 0.86 1.95
```

```r
barplot(a)
```

![plot of chunk invs](figure/invs.png) 

dpt: tous les cas de traumato (S00 à T98)  
dpnp:tous lescas de médecine  

dpt<-dpr[substr(dpr$DP,1,3)>="S00" & substr(dpr$DP,1,3)<"T99", ]  
dpnt<-dpr[substr(dpr$DP,1,3) < "S00" | substr(dpr$DP,1,3)>"T98", ]  
mnt<-month(dpnt$ENTREE,label=T)  
a<-round(summary(mge)*100/summary(mnt),2)  
a  

Qualité des données DP
======================
Certains logiciels ne contôlent pas la cohérence du code CIM 10. Si on prend les DP de janvier à septembre 2013 inclus, on relève les éléments suivants:
- nombre total de RPU: 249 039
- nombre de RPU où le DP est renseigné: 167 419
- taux de complétude: 67.22 %
On s'intéresse aux codes CIM10 renseignés. Pour celà on trace l'histogramme des DP en fonction de la longueur du code utilisé:

```r
a <- nchar(dpr$DP)
summary(a)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.00    4.00    4.00    4.01    4.00   19.00
```

```r
b <- summary(as.factor(a))
b
```

```
##      1      3      4      5      6      7     11     12     14     15 
##      9  21631 182833  23622    302    118      1      1      1      2 
##     16     18     19 
##      1      1      2
```

```r
barplot(b)
```

![plot of chunk length_DP](figure/length_DP1.png) 

```r
barplot(log(b))
```

![plot of chunk length_DP](figure/length_DP2.png) 

```r
dpr[nchar(dpr$DP) > 6, c("FINESS", "DP")]
```

```
##        FINESS                  DP
## 22395     Mul         JJ449) BPCO
## 32891     Mul        PW199) Chute
## 49760     Mul             S2250B6
## 55395     Mul NN10) Pyelonéphrite
## 69971     Mul      HR060) Dyspnée
## 97650     Mul  NC61) Néo prostate
## 107027    Mul NN10) Pyelonéphrite
## 109184    Mul             S2250B6
## 178125    Mul             S2250B6
## 188273    Mul     HH819) Vertiges
## 196313    Mul             S2250B6
## 198071    Mul             S2250B6
## 205698    Mul     KK297) Gastrite
## 207226    Mul    SY099) Agression
## 257288    Hag             S422 02
## 259057    Hag             S223 01
## 259068    Hag             S011 02
## 260853    Hag             S400 01
## 260863    Hag             S810 01
## 260864    Hag             S810 01
## 260870    Hag             S525 02
## 260893    Hag             S800 01
## 260897    Hag             S800 01
## 261535    Hag             S202 02
## 262527    Hag             S422 01
## 262543    Hag             S823 01
## 262546    Hag             S929 01
## 263914    Hag             S422 01
## 263916    Hag             S711 01
## 264205    Hag             S400 01
## 264210    Hag             S521 02
## 264212    Hag             S223 02
## 265378    Hag             T150 01
## 266155    Hag             S826 02
## 266209    Hag             S929 01
## 266211    Hag             S510 01
## 266215    Hag             S711 02
## 267287    Hag             J189 02
## 267302    Hag             I800 02
## 267308    Hag             S724 02
## 267344    Hag             S431 02
## 267391    Hag             R073 01
## 268055    Hag             S223 01
## 268127    Hag             J189 02
## 268143    Hag             S823 01
## 268373    Hag             S834 01
## 268422    Hag             S525 02
## 268447    Hag             S834 02
## 268452    Hag             S424 01
## 270174    Hag             S810 02
## 271100    Hag             S521 01
## 272290    Hag             R073 01
## 272324    Hag             H920 02
## 274628    Hag             G560 02
## 275030    Hag             S821 02
## 276715    Hag             S910 01
## 278035    Hag             G580 02
## 279108    Hag             G580 02
## 279191    Hag             H920 02
## 282149    Hag             S531 02
## 282682    Hag             S826 01
## 282735    Hag             S929 02
## 284949    Hag             S824 01
## 284972    Hag             S531 01
## 286689    Hag             S801 02
## 286690    Hag             T159 01
## 286695    Hag             S801 02
## 287533    Hag             G580 01
## 287558    Hag             R073 01
## 288501    Hag             S923 01
## 288524    Hag             H609 01
## 289357    Hag             T159 02
## 289380    Hag             H919 01
## 290523    Hag             S836 01
## 292002    Hag             S422 02
## 292094    Hag             S521 02
## 293714    Hag             N832 02
## 294353    Hag             S526 01
## 294415    Hag             S929 01
## 294418    Hag             J189 01
## 295587    Hag             S059 02
## 296666    Hag             R073 01
## 297790    Hag             S521 01
## 298656    Hag             S934 01
## 299669    Hag             S701 02
## 301875    Hag             S860 01
## 301917    Hag             T150 01
## 302887    Hag             H669 01
## 302915    Hag             S903 02
## 303988    Hag             S523 02
## 304059    Hag             S531 01
## 304657    Hag             T150 01
## 305244    Hag             S826 02
## 305245    Hag             S700 02
## 305253    Hag             S834 01
## 305305    Hag             S522 01
## 307072    Hag             S826 02
## 307888    Hag             S860 01
## 309767    Hag             S011 02
## 309797    Hag             S821 01
## 309819    Hag             S810 01
## 312181    Hag             S525 02
## 313741    Hag             S801 01
## 314682    Hag             M751 02
## 314860    Hag             S721 02
## 316774    Hag             S500 02
## 316837    Hag             S011 02
## 316855    Hag             S923 01
## 318401    Hag             S924 02
## 318730    Hag             G510 01
## 318760    Hag             S820 01
## 318801    Hag             S824 01
## 319968    Hag             S011 02
## 320068    Hag             S422 02
## 320113    Hag             S301 02
## 320117    Hag             S934 02
## 322472    Hag             S525 01
## 324609    Hag             S202 01
## 327156    Hag             C780 02
## 327164    Hag             C780 02
## 328886    Hag             R073 02
## 330467    Hag             S800 01
## 330468    Hag             S525 02
## 330484    Hag             S525 01
## 330520    Hag             H612 02
## 330521    Hag             S526 01
## 330533    Hag             S011 02
```

La Dixième Révision (CIM10) utilise un code alphanumérique avec une lettre en
première position et des chiffres en seconde, troisième et quatrième position.
Le quatrième caractère est précédé par un point. Les possibilités de codage
vont de ce fait de A00.0 à Z99.9. La lettre U n'est pas utilisée. Il en résulte qu'après suppression du point décimal, le code DP ne peut être constitué que de 2, 3 ou 4 caractères.

Wissembourg


```r
cw <- dpr[dpr$FINESS == "Wis", "DP"]
head(cw)
```

```
## [1] "S009"  "S610"  "S012"  "S0220" "A090"  "A099"
```

```r
a <- nchar(cw)
summary(a)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    3.00    4.00    4.00    4.04    4.00    6.00
```

```r
summary(as.factor(a))
```

```
##    3    4    5    6 
##  835 9256 1302   10
```

```r
cw[nchar(cw) > 5]
```

```
##  [1] "M62890" "I21900" "F10241" "M62800" "I21100" "M62890" "M62890"
##  [8] "M62890" "M62890" "M62890"
```

Le code M62890 (PMSI ?) correspond à la rhabdomyolyse, en CIM10 M62.8 (présent 5 fois sous ceete forme et 7 fois au total: "M62890" "M62800" "M6286"  "M62890" "M62890" "M62890" "M6285")

