Mode de sortie
========================================================

```r
getwd()
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU_2013/Analyse/Chapitres/Mode_sortie"
```

```r
source("../prologue.R")
```

```
## [1] "Fichier courant: rpu2013d0112.Rda"
```

```r
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
## [1] 12
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
##         0     65579      4876    212436         2     47701
```

```
##        NA  Mutation Transfert  Domicile     Décès      NA's 
##      0.00     19.84      1.47     64.26      0.00     14.43
```

```
## 
##        NA  Mutation Transfert  Domicile     Décès 
##         0     65579      4876    212436         2
```

```
## 
##        NA  Mutation Transfert  Domicile     Décès 
##      0.00     23.18      1.72     75.09      0.00
```



On dispose d'une population de n = 330594 RPU.

On forme un sous-groupe **ms** constitué des RPU dont l'item *DESTINATION* est renseigné
(non nul):
----------------------------------------------------------------------------------------

```r
ms <- d1[!is.na(d1$MODE_SORTIE), ]
non_renseigne <- nrow(d1) - nrow(ms)
prop_non_renseigne <- round(non_renseigne * 100/nrow(d1), 2)
```

On obtient un sous-groupe de 282893 RPU. Il y a donc 47701 RPU non renseignés soit 14.43 % de l'effectif.

Les MODE_SORTIE renseignés se répartissent ainsi:

```
##        NA  Mutation Transfert  Domicile     Décès 
##         0     65579      4876    212436         2
```

```
##        NA  Mutation Transfert  Domicile     Décès 
##      0.00     23.18      1.72     75.09      0.00
```

On forme le groupe **hosp** de tous les RPU de *ms* dont lespatients ont été hospitalisés
-----------------------------------------------------------------------------------------
(hosp = mutation + transfert):

```
##    NA   MCO   SSR   SLD   PSY   HAD   HMS  NA's 
##     0 68824   102    17  1160     5     0   347
```

Les patients dont le MODE_SORTIE est l'hospitalisation (Mutation ou transfert), ont les DESTINATION suivantes:
- MCO: 68824
- SSR: 102
- SLD: 17
- PSY: 1160
- NA: 347  
On relève 5 HAD qui devraient se trouver dans le groupe MODE_SORTIE = domicile.  

Si on analyse les ORIENTATION de ce groupe, on obtient:

```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##  7095     0    86    25 16787    92    13   929    33  1384     0  1287 
##  UHCD  NA's 
## 29653 13071
```

- CHIR: 7095
- MED: 16787
- UHCD: 29653
- OBST: 92
- REA: 929
- SC: 1384
- SI: 1287
- Non Renseigné: 13071

Pour les autres items de cette rubrique, on devrait trouver 0 car ils ne sont pas considérés comme une hospitalisation:
- FUGUE: 0
- PSA: 13
- REO: 33
- SCAM: 0

On forme le groupe **dom** de tous les RPU de *ms* dont les patients n'ont pas  été hospitalisés
-----------------------------------------------------------------------------------------
(dom = Domicile):

```
##     NA    MCO    SSR    SLD    PSY    HAD    HMS   NA's 
##      0    128      0      0      0      1     21 212286
```

On trouve normalement:
- HAD: 1
- HMS: 21
- NA: 212286 retours à domicile vrais.

Les champs suivants devrait être égaux  0 (sinon il y a erreur de codage):
- MCO: 128
- SSR: 0
- SLD: 0
- PSY: 0
- HAD: 1

En ce qui concerne l'ORIENTATION du groupe *dom*:

```
##   CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO     SC 
##    127    254     15      2     71      2   3014     10   1394      6 
##   SCAM     SI   UHCD   NA's 
##    510     26    283 206722
```

On trouve normalement:
- FUGUE: 254
- PSA: 3014
- REO: 1394
- SCAM: 510
- NA: 206722

Les champs suivants devrait être égaux  0 (sinon il y a erreur de codage):
- CHIR: 127
- HDT: 15
- HO: 2
- MED: 71
- OBST: 2
- REA: 10
- SC: 6
- SI:26
- UHCD: 283

On forme un sous-groupe *ms2* constitué des RPU dont l'item *DESTINATION* est NA (non renseigné)
----------------------------------------------------------------------------------------
On s'intéresse aux MODE_SORTIE non renseignés: 

```
##    NA   MCO   SSR   SLD   PSY   HAD   HMS  NA's 
##     0    20     0     0     8     0     0 47673
```

```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##   156     1    24     4   240     0    39    66     9    35     0    75 
##  UHCD  NA's 
##  2378 44674
```

La somme *ms + ms2* = 330594 doit être égale à *d1* (330594) - les décès.


Si le codage est exact toutes les rubriques doivent être à 0 car on ne paeut pas avoir une rubrique MODE_SORTIE non renseignée et des rubriques DESTINATION et ORIENTATION non vides.

La somme *hosp + dom + ms2* = 330592 doit être égale à *d1* (330594):
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
##      0  68952    102     17   1160      6     21 212635
```

la destination n'est pas renseignées pour 212635 RPU ce qui peut correspondre à un retour à la maison où une non réponse.

Dans un premier temps on s'intéresse à l'ORIENTATION des RPU où MODE_SORTIE est renseigné mais DESTINATION n'est pas renseigné:

```
##   CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO     SC 
##    127    254     15      2     71      2   3014     11   1394      6 
##   SCAM     SI   UHCD   NA's 
##    510     26    299 206904
```

Dans ce sous-groupe, l'analyse de l'item ORIENTATION ne devrait retouner que des NA (retour à domicile) ou une ORIENTATION appartenant au sous ensemble {FUGUE, SCAM, PSA, REO}.  
En conclusion 



```
##  CHIR FUGUE   HDT    HO   MED  OBST   PSA   REA   REO    SC  SCAM    SI 
##  7095     0    86    25 16787    92    13   928    33  1384     0  1287 
##  UHCD  NA's 
## 29637 12891
```

Résumé
======

On croise MODE_SORTIE et DESTINATION en tenant compte des NA (Rajouter l'option exclude=FALSE sinon table ne tient pas compte des NA):


```
##            
##                 NA    MCO    SSR    SLD    PSY    HAD    HMS   <NA>
##   NA             0      0      0      0      0      0      0      0
##   Mutation       0  64937     68      5    386      0      0    183
##   Transfert      0   3887     34     12    774      5      0    164
##   Domicile       0    128      0      0      0      1     21 212286
##   Décès          0      0      0      0      0      0      0      2
##   <NA>           0     20      0      0      8      0      0  47673
```

```
##            
##               CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO
##   NA             0      0      0      0      0      0      0      0      0
##   Mutation    6597      0      4      7  16285     60     12    901     21
##   Transfert    498      0     82     18    502     32      1     28     12
##   Domicile     127    254     15      2     71      2   3014     10   1394
##   Décès          0      0      0      0      0      0      0      0      0
##   <NA>         156      1     24      4    240      0     39     66      9
##            
##                 SC   SCAM     SI   UHCD   <NA>
##   NA             0      0      0      0      0
##   Mutation    1345      0   1186  29508   9653
##   Transfert     39      0    101    145   3418
##   Domicile       6    510     26    283 206722
##   Décès          0      0      0      0      2
##   <NA>          35      0     75   2378  44674
```

```
##       
##          CHIR  FUGUE    HDT     HO    MED   OBST    PSA    REA    REO
##   NA        0      0      0      0      0      0      0      0      0
##   MCO    6962      0     15     12  16525     92     13    919     31
##   SSR       0      0      0      0      7      0      0      2      0
##   SLD       0      0      0      0      4      0      0      0      1
##   PSY     139      0     72     13    265      0      0      7      1
##   HAD       0      0      0      0      0      0      0      0      0
##   HMS       0      0      0      0      0      0      0      0      0
##   <NA>    277    255     38      6    297      2   3053     77   1403
##       
##            SC   SCAM     SI   UHCD   <NA>
##   NA        0      0      0      0      0
##   MCO    1373      0   1285  29616  12129
##   SSR       0      0      0      5     88
##   SLD       0      0      0      0     12
##   PSY      11      0      2     22    636
##   HAD       0      0      0      0      6
##   HMS       0      0      0      0     21
##   <NA>     41    510    101   2671 251577
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



