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


