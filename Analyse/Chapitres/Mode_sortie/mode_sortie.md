Mode de sortie
========================================================

```r
getwd()
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU2013/Chapitres/Mode_sortie"
```

```r
source("../prologue.R")
d1 <- foo(path)
print(annee_courante)
```

```
## [1] 2013
```

```r
print(mois_courant)
```

```
## [1] 9
```

Trois items interviennent dans cette analyse:
- le mode de sortie
- la destination
- l'orientation

La destination
--------------
C'est l'item le plus simple et le RPU lui décrit 4 niveaux:
- mutation
- transfert (ces 2niveaux définissant l'hospitalisation)
- le décès
- le retour à domicile

```
##        NA  Mutation Transfert  Domicile     Décès      NA's 
##         0     48898      3665    159755         2     36719
```

```
##        NA  Mutation Transfert  Domicile     Décès      NA's 
##      0.00     19.63      1.47     64.15      0.00     14.74
```

```
## 
##        NA  Mutation Transfert  Domicile     Décès 
##         0     48898      3665    159755         2
```

```
## 
##        NA  Mutation Transfert  Domicile     Décès 
##      0.00     23.03      1.73     75.24      0.00
```



On dispose d'une population de n = 249039 RPU.

On forme un sous-groupe **ms** constitué des RPU dont l'item *DESTINATION* est renseigné
(non nul):
----------------------------------------------------------------------------------------

```r
ms <- d1[!is.na(d1$MODE_SORTIE), ]
non_renseigne <- nrow(d1) - nrow(ms)
prop_non_renseigne <- round(non_renseigne * 100/nrow(d1), 2)
```

On obtient un sous-groupe de 212320 RPU. Il y a donc 36719 RPU non renseignés soit 14.74 % de l'effectif.

Les MODE_SORTIE renseignés se répartissent ainsi:

```
##        NA  Mutation Transfert  Domicile     Décès 
##         0     48898      3665    159755         2
```

```
##        NA  Mutation Transfert  Domicile     Décès 
##      0.00     23.03      1.73     75.24      0.00
```

On forme le groupe **hosp** de tous les RPU de *ms* dont lespatients ont été hospitalisés
-----------------------------------------------------------------------------------------
(hosp = mutation + transfert):

```
##    NA   MCO   SSR   SLD   PSY   HAD   HMS  NA's 
##     0 51315    74    12   894     2     0   266
```

Les patients dont le MODE_SORTIE est l'hospitalisation (Mutation ou transfert), ont les DESTINATION suivantes:
- MCO: 51315
- SSR: 74
- SLD: 12
- PSY: 894
- NA: 266  
On relève 2 HAD qui devraient se trouver dans le groupe MODE_SORTIE = domicile.  

Si on analyse les ORIENTATION de ce groupe, on obtient:

```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##  5340     0    66    19 12341    71    10   689    22   983     0   947 
##  UHCD  NA's 
## 22492  9583
```

- CHIR: 5340
- MED: 12341
- UHCD: 22492
- OBST: 71
- REA: 689
- SC: 983
- SI: 947
- Non Renseigné: 9583

Pour les autres items de cette rubrique, on devrait trouver 0 car ils ne sont pas considérés comme une hospitalisation:
- FUGUE: 0
- PSA: 10
- REO: 22
- SCAM: 0

On forme le groupe **dom** de tous les RPU de *ms* dont les patients n'ont pas  été hospitalisés
-----------------------------------------------------------------------------------------
(dom = Domicile):

```
##     NA    MCO    SSR    SLD    PSY    HAD    HMS   NA's 
##      0    127      0      0      0      1     21 159606
```

On trouve normalement:
- HAD: 1
- HMS: 21
- NA: 159606 retours à domicile vrais.

Les champs suivants devrait être égaux  0 (sinon il y a erreur de codage):
- MCO: 127
- SSR: 0
- SLD: 0
- PSY: 0
- HAD: 1

En ce qui concerne l'ORIENTATION du groupe *dom*:

```
##   CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO     SC 
##     92    198     13      2     53      1   2284      9   1047      4 
##   SCAM     SI   UHCD   NA's 
##    386     22    196 155448
```

On trouve normalement:
- FUGUE: 198
- PSA: 2284
- REO: 1047
- SCAM: 386
- NA: 155448

Les champs suivants devrait être égaux  0 (sinon il y a erreur de codage):
- CHIR: 92
- HDT: 13
- HO: 2
- MED: 53
- OBST: 1
- REA: 9
- SC: 4
- SI:22
- UHCD: 196

On forme un sous-groupe *ms2* constitué des RPU dont l'item *DESTINATION* est NA (non renseigné)
----------------------------------------------------------------------------------------
On s'intéresse aux MODE_SORTIE non renseignés: 

```
##    NA   MCO   SSR   SLD   PSY   HAD   HMS  NA's 
##     0    16     0     0     6     0     0 36697
```

```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##   109     1    21     2   180     0    33    55     5    26     0    56 
##  UHCD  NA's 
##  1825 34406
```

La somme *ms + ms2* = 249039 doit être égale à *d1* (249039) - les décès.


Si le codage est exact toutes les rubriques doivent être à 0 car on ne paeut pas avoir une rubrique MODE_SORTIE non renseignée et des rubriques DESTINATION et ORIENTATION non vides.

La somme *hosp + dom + ms2* = 249037 doit être égale à *d1* (249039):
- hosp: hospitalisés
- dom: retour à domicile
- ms2: les NA (mode_sortie)



La destination
--------------
Cet item affine le MODE_SORTIE, en précisant:
- pour les patients hospitalisés, leur destination: MCO, SSR, SLD ou PSY
- et pour les patients non hospitalisés, 2 destinations qui ne sont ni l'hôpital, ni la maison à savoir HAD et HMS.
On suppose implicitement que les non réponses correspondent au retour à domicile.

Dans un premier groupe on à la DESTINATION lorsque MODE_SORTIE est renseigné (ms):

```
##     NA    MCO    SSR    SLD    PSY    HAD    HMS   NA's 
##      0  51442     74     12    894      3     21 159874
```

la destination n'est pas renseignées pour 159874 RPU ce qui peut correspondre à un retour à la maison où une non réponse.

Dans un premier temps on s'intéresse à l'ORIENTATION des RPU où MODE_SORTIE est renseigné mais DESTINATION n'est pas renseigné:

```
##   CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO     SC 
##     92    198     13      2     53      1   2284      9   1047      4 
##   SCAM     SI   UHCD   NA's 
##    386     22    206 155557
```

Dans ce sous-groupe, l'analyse de l'item ORIENTATION ne devrait retouner que des NA (retour à domicile) ou une ORIENTATION appartenant au sous ensemble {FUGUE, SCAM, PSA, REO}.  
En conclusion 



```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##  5340     0    66    19 12341    71    10   689    22   983     0   947 
##  UHCD  NA's 
## 22482  9476
```

Résumé
======

On croise MODE_SORTIE et DESTINATION en tenant compte des NA (Rajouter l'option exclude=FALSE sinon table ne tient pas compte des NA):


```
##            
##                 NA    MCO    SSR    SLD    PSY    HAD    HMS   <NA>
##   NA             0      0      0      0      0      0      0      0
##   Mutation       0  48411     49      5    289      0      0    144
##   Transfert      0   2904     25      7    605      2      0    122
##   Domicile       0    127      0      0      0      1     21 159606
##   Décès          0      0      0      0      0      0      0      2
##   <NA>           0     16      0      0      6      0      0  36697
```

```
##            
##               CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO
##   NA             0      0      0      0      0      0      0      0      0
##   Mutation    4967      0      3      6  11971     43      9    670     14
##   Transfert    373      0     63     13    370     28      1     19      8
##   Domicile      92    198     13      2     53      1   2284      9   1047
##   Décès          0      0      0      0      0      0      0      0      0
##   <NA>         109      1     21      2    180      0     33     55      5
##            
##                 SC   SCAM     SI   UHCD   <NA>
##   NA             0      0      0      0      0
##   Mutation     956      0    875  22394   6990
##   Transfert     27      0     72     98   2593
##   Domicile       4    386     22    196 155448
##   Décès          0      0      0      0      2
##   <NA>          26      0     56   1825  34406
```

```
##       
##          CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO
##   NA        0      0      0      0      0      0      0      0      0
##   MCO    5237      0     10      8  12143     71     10    681     21
##   SSR       0      0      0      0      7      0      0      2      0
##   SLD       0      0      0      0      4      0      0      0      0
##   PSY     108      0     57     11    199      0      0      6      1
##   HAD       0      0      0      0      0      0      0      0      0
##   HMS       0      0      0      0      0      0      0      0      0
##   <NA>    196    199     33      4    221      1   2317     64   1052
##       
##            SC   SCAM     SI   UHCD   <NA>
##   NA        0      0      0      0      0
##   MCO     973      0    947  22471   8886
##   SSR       0      0      0      4     61
##   SLD       0      0      0      0      8
##   PSY      10      0      0     11    497
##   HAD       0      0      0      0      3
##   HMS       0      0      0      0     21
##   <NA>     30    386     78   2027 189963
```

Les vrai retours à domicile sont au croisement Domicile/<NA>

Retour à domicile totaux (patients où MODE_SORTIE = Domicile et où Orientation et destination sont nuls):

```
## [1] 0.76
```



Motif de passage selon la structure
===================================

```
## $`3Fr`
## [1] NA NA NA NA NA NA
## 
## $Alk
## [1] NA     NA     NA     NA     "R600" NA    
## 
## $Col
## [1] "une crise d'asthme"                         
## [2] "un malaise avec PC"                         
## [3] "Autre"                                      
## [4] "un traumatisme oculaire: explosion d'un"    
## [5] "plaie pied gauche par p\xe9tard ; une plaie"
## [6] "une br\xfblre"                              
## 
## $Dia
## [1] "R060" "L039" "R060" "J029" NA     "Z480"
## 
## $Geb
## [1] NA NA NA NA NA NA
## 
## $Hag
## [1] NA                                                   
## [2] "Douleurs abdominales, autres et non pr\xe9cis\xe9es"
## [3] "Plaie ouverte d'autres parties de la jambe"         
## [4] "\xc9pilepsie, sans pr\xe9cision"                    
## [5] NA                                                   
## [6] NA                                                   
## 
## $Hus
## [1] NA NA NA NA NA NA
## 
## $Mul
## [1] "S37.0" "R05"   "R10.4" "R41.0" "R10.4" "J45.9"
## 
## $Odi
## [1] "T009" "Z609" "R21"  "L988" "T119" "R103"
## 
## $Sel
## [1] "GASTRO04"   "DIVERS23"   "TRAUMATO10" "TRAUMATO02" "OPHTALMO04"
## [6] "TRAUMATO09"
## 
## $Wis
## [1] "T009" "T119" "T009" "S008" "R11"  "R11" 
## 
## $Sav
## [1] NA NA NA NA NA NA
```

Diagnostic selon la structure
==============================

```
## $`3Fr`
## [1] "S018" "T140" "S010" "S610" "F410" "F100"
## 
## $Alk
## [1] "S200" "K088" NA     "M796" NA     "S300"
## 
## $Col
## [1] "J21.9"  "R53.+1" "T17.9"  "S05.6"  "S91.3"  "T23.2" 
## 
## $Dia
## [1] NA NA NA NA NA NA
## 
## $Geb
## [1] "Z028" "Z028" "T230" "T510" "K409" "S019"
## 
## $Hag
## [1] "S018" "R229" "S819" "G409" "G459" "J111"
## 
## $Hus
## [1] NA NA NA NA NA NA
## 
## $Mul
## [1] "S37.0" "R06.0" "N23"   "E51.2" "N23"   "J45.9"
## 
## $Odi
## [1] NA      "S008"  "L500"  "M2551" "S602"  NA     
## 
## $Sel
## [1] "R104" "J038" "S617" "M485" "T261" "S018"
## 
## $Wis
## [1] "S009"  "S610"  "S012"  "S0220" "A090"  "A099" 
## 
## $Sav
## [1] NA NA NA NA NA NA
```



