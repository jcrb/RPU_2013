Discussions
========================================================





Diaconat-Fonderie
-----------------




#### le taux de remonté GEMSA et CCMU ne peut être à 100%, en effet dans notre pratique les patients qui, lassés d’attendre repartent sans voir le médecin sont conservés dans Atalante mais aucune codification GEMSA et CCMU ne leur est, fort logiquement attribuée.

Oui et non. Si on examine le croisement des variables ORIENTATION et CCMU on obtient:


```
       
            1     2     3     4     5     D     P  <NA>
  CHIR      0    69    30     0     0     0     0     2
  FUGUE     1     6     0     0     0     0     0     5
  HDT       0     0     0     0     0     0     0     0
  HO        0     0     0     0     0     0     0     0
  MED       0    12     6     0     0     0     0     1
  OBST      0     0     0     0     0     0     0     0
  PSA       1   215    16     0     0     0     0   742
  REA       0     0     5     1     0     0     0     0
  REO      19    45     8     0     0     0     0    81
  SC        0     1     0     0     0     0     0     0
  SCAM      1    10     6     0     0     0     0     1
  SI        0     2     0     0     0     0     0     0
  UHCD      0    10     1     0     0     0     0     1
  <NA>     28 22065  5670    14     2     1     0   391
```

On voit qu'a la rubrique "Parti Sans Attendre" (PSA), 232 patients ont été coté et 742 ne l'on pas été (pour cela on peut présumer qu'ils sont CCMU 1).
La gravité en terme de CCMU se mesure dès l'admission et avant tout soins ou examen. Dans beaucoup d'endroit c'est l'IAO qui fixe la gravité. Pour une histoire qui a défrayé la chronique il y a quelques semaines, une patient décédée en salle d'attente était classée CCMU1-2, ce qui était exact.
Dans la même veine, vous noterez que certains patients réorientés (REO) sont coté en CCMU, d'autres non, ce qui pose un (potentiellement) un problème médico-légal.

#### le résultat relatif à l’item orientation me semble erroné, un contrôle aléatoire montre que son taux de remonté est identique aux autres items.

Nous avons échangé à ce sujet il y a quelques  jours. Je reprends mon argumentation: les rubriques MODE_SORTIE et ORIENTATION sont liées, la seconde précisant la première.

La rubrique MODE_SORTIE devrait être systématiquement remplie, tout patient qui n'a pas été hospitalisé (mutation + transfert) a quitté l’hôpital (domicile ou ce qui en tient lieu + décès):


```
       NA  Mutation Transfert  Domicile     Décès      NA's 
        0      2960       182     24222         0      2105 
```


L’exhaustivité sur cette rubrique est bonne: 92,8569%

La rubrique ORIENTATION donne une information plus précise sur le devenir exact de ces patients (notamment pour las sorties atypiques). Si on croise les rubriques MODE_SORTIE et Orientation on obtient ceci:


```
       
           NA Mutation Transfert Domicile Décès  <NA>
  CHIR      0       30        21       30     0    20
  FUGUE     0        0         0       12     0     0
  HDT       0        0         0        0     0     0
  HO        0        0         0        0     0     0
  MED       0        4         4        7     0     4
  OBST      0        0         0        0     0     0
  PSA       0       11         0      925     0    38
  REA       0        0         2        3     0     1
  REO       0       11         2      131     0     9
  SC        0        0         1        0     0     0
  SCAM      0        0         0       18     0     0
  SI        0        0         0        1     0     1
  UHCD      0        0         5        4     0     3
  <NA>      0     2904       147    23091     0  2029
```

Dans la colonne mutation (hospitalisation dans le même établissement que le SU) 30 patients sont allés en chirurgie, 4 en médecine et on se sait pas où sont allés 2904 patients. Le total de cette colonne est d'ailleurs supérieur au chiffre des mutations indiqué à MODE_SORTIE, même si tient compte des 11 PSA mais qui ont été hospitalisés quand même (défaut de détrompage du logiciel). Idem pur les REOrientation.

C'est cette non complétude qui explique le défaut d'exhaustivité.

#### La CCMU doit être faite par un médecin

Pour ce qui concerne la CCMU: il s'agit d'une classification assez ancienne, en tout cas antérieure à l'émergence des IAO. C'est donc historiquement une classification élaborée par des médecins pour être utilisée par un trieur qui était dans le contexte de l'époque, un médecin. D'où la notion implicite que le tri était médical, notion renforcée par le contexte de la médecine militaire ou de catastrophe. Sur le plan juridique on peut opposer le diagnostic médical et le diagnostic infirmier mais les arguments avancés relèvent souvent d'avantage d'une défense corporatiste que de l'intérêt du patient.
En pratique, l'IAO trie et oriente en fonction de l'urgence de la situation: on est bien dans l'esprit de la CCMU. Pour éviter tous ces difficultés, il est proposé soit d'utiliser une approche simplifiée strictement identique (1 = consultation simple, 2 = examens complémentaires ou gestes réalisables en ambulatoire - radio, biologie, sutures - 3 = hospitalisation en services conventionnels MCO, 4 = prise en charge urgente relevant de SI ou SC, 5 = très urgent relevant de la réa). On retrouve ce principe dans la classification CIMU (http://www.triage-urgence.com).


Commentaires CH Colmar
========================================================

Analyse de la rubrique __MOTIF__
--------------------------------

Les intitulés sont fournis par le logiciel CristalNet de Grenoble.


```r
col <- d1$MOTIF[d1$FINESS == "Col"]
head(col, 50)
```

```
##  [1] "une crise d'asthme"                               
##  [2] "un malaise avec PC"                               
##  [3] "Autre"                                            
##  [4] "un traumatisme oculaire: explosion d'un"          
##  [5] "plaie pied gauche par p\xe9tard ; une plaie"      
##  [6] "une br\xfblre"                                    
##  [7] "Perte d'audiion suite \xe0 explosion d'un p"      
##  [8] "une plaie main gauche due \xe0 un p\xe9tard"      
##  [9] "une br\xfblre"                                    
## [10] "un malaise avec PC, pas de notion d'alco"         
## [11] "une dyspn\xe9e"                                   
## [12] "une intoxication \xe9thylique"                    
## [13] "une toux ; des vertiges envoy\xe9 par Dr ga"      
## [14] "une intoxication \xe9thylique sur VP"             
## [15] "une plaie front et cr\xe2ne suite \xe0 une rix"   
## [16] "une plaie face interne l\xe8vre sup"              
## [17] "un traumatisme du membre sup\xe9rieur xx"         
## [18] "un traumatisme maxillo-facial ; des trau"         
## [19] "un traumatisme du membre sup\xe9rieur xx"         
## [20] "un malaise avec PC"                               
## [21] "BRULURE bras droit avec petard ; une br\xfb"      
## [22] "un traumatisme oculaire averc un petard"          
## [23] "une plaie levre sup"                              
## [24] "un malaise avec PC .vomissement alimenta"         
## [25] "un certificat de non hospitalisation"             
## [26] "un traumatisme maxillo-facial ;"                  
## [27] "un traumatisme maxillo-facial"                    
## [28] "une intoxication \xe9thylique"                    
## [29] "une intoxication \xe9thylique"                    
## [30] "chute en arri\xe8re douleur coude drt \n ;"       
## [31] "un vomissement avec pr\xe9sence de sang rou"      
## [32] "une rougeur oculaire avec saignement de"          
## [33] "une douleur abdominale"                           
## [34] "une douleur abdominale"                           
## [35] "une intoxication \xe9thylique"                    
## [36] "une plaie \xe9paule drte\nVAT dit etre \xe0 jo"   
## [37] "un traumatisme cr\xe2nien sans perte de con"      
## [38] "une intoxication m\xe9dicamenteuse volontai"      
## [39] "un certificat de non hospitalisation"             
## [40] "un traumatisme de la cheville gche"               
## [41] "une chute m\xe9canique ; un traumatisme max"      
## [42] "une agression ; une plaie, a recu des co"         
## [43] "une rhinite depuis 2 jours avec notion d"         
## [44] "Colique n\xe9phr\xe9tique hyperalgique adress\xe9"
## [45] "une chute du lit ; des traumatismes mult"         
## [46] "une chute m\xe9canique ; un traumatisme rac"      
## [47] "une chute m\xe9canique hier soir ; un malai"      
## [48] "un traumatisme oculaire G"                        
## [49] "une douleur au niveau de la gorge"                
## [50] "un traumatisme cr\xe2nien sans pc, trauma d"
```

```r
col <- gsub("\xe9", "é", col)
col <- gsub("\xfb", "û", col)
col <- gsub("\xe8", "è", col)
col <- gsub("\xe2", "â", col)
col <- gsub("\xe0", "à", col)
head(col, 50)
```

```
##  [1] "une crise d'asthme"                      
##  [2] "un malaise avec PC"                      
##  [3] "Autre"                                   
##  [4] "un traumatisme oculaire: explosion d'un" 
##  [5] "plaie pied gauche par pétard ; une plaie"
##  [6] "une brûlre"                              
##  [7] "Perte d'audiion suite à explosion d'un p"
##  [8] "une plaie main gauche due à un pétard"   
##  [9] "une brûlre"                              
## [10] "un malaise avec PC, pas de notion d'alco"
## [11] "une dyspnée"                             
## [12] "une intoxication éthylique"              
## [13] "une toux ; des vertiges envoyé par Dr ga"
## [14] "une intoxication éthylique sur VP"       
## [15] "une plaie front et crâne suite à une rix"
## [16] "une plaie face interne lèvre sup"        
## [17] "un traumatisme du membre supérieur xx"   
## [18] "un traumatisme maxillo-facial ; des trau"
## [19] "un traumatisme du membre supérieur xx"   
## [20] "un malaise avec PC"                      
## [21] "BRULURE bras droit avec petard ; une brû"
## [22] "un traumatisme oculaire averc un petard" 
## [23] "une plaie levre sup"                     
## [24] "un malaise avec PC .vomissement alimenta"
## [25] "un certificat de non hospitalisation"    
## [26] "un traumatisme maxillo-facial ;"         
## [27] "un traumatisme maxillo-facial"           
## [28] "une intoxication éthylique"              
## [29] "une intoxication éthylique"              
## [30] "chute en arrière douleur coude drt \n ;" 
## [31] "un vomissement avec présence de sang rou"
## [32] "une rougeur oculaire avec saignement de" 
## [33] "une douleur abdominale"                  
## [34] "une douleur abdominale"                  
## [35] "une intoxication éthylique"              
## [36] "une plaie épaule drte\nVAT dit etre à jo"
## [37] "un traumatisme crânien sans perte de con"
## [38] "une intoxication médicamenteuse volontai"
## [39] "un certificat de non hospitalisation"    
## [40] "un traumatisme de la cheville gche"      
## [41] "une chute mécanique ; un traumatisme max"
## [42] "une agression ; une plaie, a recu des co"
## [43] "une rhinite depuis 2 jours avec notion d"
## [44] "Colique néphrétique hyperalgique adressé"
## [45] "une chute du lit ; des traumatismes mult"
## [46] "une chute mécanique ; un traumatisme rac"
## [47] "une chute mécanique hier soir ; un malai"
## [48] "un traumatisme oculaire G"               
## [49] "une douleur au niveau de la gorge"       
## [50] "un traumatisme crânien sans pc, trauma d"
```

```r
nchar(col[5])
```

```
## [1] 40
```

- L'encodage ne prend pas en compte les caractères accentuée. Le RPU transmis devriat être au format UTF-8
- Après nettoyage on obtient une liste relativement normalisée où les champs sont tronqués à 40 caractères
- il semblerait que l'on puisse combiner plusieurs champs de nature différente sur la même ligne (ex. ligne 4, on a à la fois un motif et une circonstance)
- ce qui attendu pour cette rubrique est un transcodage CIM10 complet ou simplifié (thésaurus SFMU).

