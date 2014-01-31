Demographie
========================================================

Ce document rassemble les données pertinentes concernant la population d'Alsace.

Les données source sont celles de l'INSEE. La date de référence est le 1er janvier 2010. 

On crée les fichiers newPop67, 68 et Alsace.  

NE PPAS MODIFIER CES FICHIERS. UTILISER DEMOGRAPHIE2.Rnw pour exploiter les données

Dernière compilation: 5/10/2013


Notes sur les populations
=========================
- utilisation du recensement 2010
- dossier stat Resural/carto&pop.rmd
  - pop67.rda
  - pop68.rda
- source INSEE
  - http://www.insee.fr/fr/ppp/bases-de-donnees/recensement/populations-legales/france-regions.asp?annee=2010
   - http://www.insee.fr/fr/ppp/bases-de-donnees/recensement/populations-legales/france
-departements.asp?annee=2010 (fichier excel)
  - http://www.insee.fr/fr/ppp/bases-de-donnees/recensement/populations-legales/departement.asp?dep=67&annee=2010
  - http://www.insee.fr/fr/ppp/bases-de-donnees/recensement/populations-legales/departement.asp?dep=68&annee=2010
  - Liste des cantons, communes, arrondissements, pays: http://www.insee.fr/fr/methodes/nomenclatures/cog/telechargement.asp
  
  
Création des fichiers newPop
----------------------------
  - Le fichier **BTT_TD_POP1B_2010.txt** dans le dossier *OpenData* contient les données du dernier recensement de la population (2010) par tranche d'age de 1 an, sexe et commune.Le source INSEE se trouve à la page *Accueil>Thèmes>Population>Évolution e...>Population et lieu de résidence antérieure - 2010 (Bases tableaux détaillés)* du site de l'Insee à l'adresse http://www.insee.fr/fr/themes/detail.asp?reg_id=99&ref_id=td-population-10

Le fichier *BTT_TD_POP1B_2010.txt* est une matrice de plus de 5 millions de lignes et 7 colonne. On en extrait les données propres à l'Alsace sous la forme de 3 fichiers:
- newPop67 pour le bas-Rhin
- newPop68 pour le haut-Rhin
- newPopAlsace pour la région


```r
library("xtable")
file <- "~/Documents/Open Data/Population 2008/BTT_TD_POP1B_2010.txt"
doc <- read.table(file, header = TRUE, sep = ";")
head(doc)
```

  NIVEAU CODGEO REG DEP C_AGED10 C_SEXE         NB
1    ARM  13201  93  13        0      1 306,366992
2    ARM  13201  93  13        0      2 254,458782
3    ARM  13201  93  13        1      1 312,109492
4    ARM  13201  93  13        1      2 269,472118
5    ARM  13201  93  13        2      1 246,121158
6    ARM  13201  93  13        2      2 262,231821

```r
str(doc)
```

'data.frame':	5255519 obs. of  7 variables:
 $ NIVEAU  : Factor w/ 2 levels "ARM","COM": 1 1 1 1 1 1 1 1 1 1 ...
 $ CODGEO  : Factor w/ 36722 levels "01001","01002",..: 4524 4524 4524 4524 4524 4524 4524 4524 4524 4524 ...
 $ REG     : int  93 93 93 93 93 93 93 93 93 93 ...
 $ DEP     : Factor w/ 100 levels "01","02","03",..: 13 13 13 13 13 13 13 13 13 13 ...
 $ C_AGED10: int  0 0 1 1 2 2 3 3 4 4 ...
 $ C_SEXE  : int  1 2 1 2 1 2 1 2 1 2 ...
 $ NB      : Factor w/ 788519 levels "0,302373","0,332376",..: 422726 353257 430875 369773 343175 361967 389945 381695 375561 377398 ...

```r
# population du bas-Rhin
newPop67 <- doc[as.character(doc$CODGEO) > "66999" & as.character(doc$CODGEO) < 
    "68000", ]
# remplacement de la virgule par le point décimal
newPop67$NB <- as.numeric(gsub(",", ".", newPop67$NB, fixed = TRUE))
sum(newPop67$NB)
```

[1] 1095905

```r
# idem pour les autres
newPop68 <- doc[as.character(doc$CODGEO) > "67999" & as.character(doc$CODGEO) < 
    "69000", ]
newPop68$NB <- as.numeric(gsub(",", ".", newPop68$NB, fixed = TRUE))
sum(newPop68$NB)
```

[1] 749782

```r
newPopAlsace <- rbind(newPop67, newPop68)
sum(newPopAlsace$NB)
```

[1] 1845687

```r
# ménage
rm(doc)

# Sauvegarde
save(newPop67, file = "newPop67.Rda")
save(newPop68, file = "newPop68.Rda")
save(newPopAlsace, file = "newPopAlsace.Rda")
```


