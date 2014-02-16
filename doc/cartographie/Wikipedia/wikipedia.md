---
layout: post
title: Liste des communes du Bas-Rhin
categorie: [leçons]
tag: [cartographie, R]
date: 2014-02-15
---

Récupérer la liste des communes du Bas-Rhin avec R et Wikipedia
===============================================================

Pour éviter un travail fastidieux de recopie, on souhaite récupérer la liste des communes du bas-Rhin à partir d'un tableau placé dans une page wikipedia. Le tableau se trouve à la [page](http://fr.wikipedia.org/wiki/Liste_des_communes_du_Bas-Rhin).


```r
library("XML")
library("knitr")

cla <- readHTMLTable("http://fr.wikipedia.org/wiki/Liste_des_communes_du_Bas-Rhin", 
    stringsAsFactors = FALSE)
# nombre de tableaux dans la page
length(cla)
```

```
[1] 6
```

```r
# mesure la taille des tableaux.
lapply(cla, dim)
```

```
$`Liste des 527 communes du Bas-Rhin.`
[1] 527   6

$`NULL`
[1] 18  3

$`NULL`
[1] 1 2

$`NULL`
[1] 6 2

$`NULL`
[1] 5 2

$`NULL`
[1] 4 2
```

```r
# Celui qui nous intéresse est le 1
br <- cla[[1]]
# head(br)
kable(head(br))
```

```
|Code Insee  |Code postal  |Commune       |Arrondissement       |Canton       |Intercommunalité                  |
|:-----------|:------------|:-------------|:--------------------|:------------|:---------------------------------|
|67001       |67204        |Achenheim     |Strasbourg-Campagne  |Mundolsheim  |C. de c. les Châteaux             |
|67002       |67320        |Adamswiller   |Saverne              |Drulingen    |C. de c. de l'Alsace Bossue       |
|67003       |67220        |Albé          |Sélestat-Erstein     |Villé        |C. de c. du canton de Villé       |
|67004       |67310        |Allenwiller   |Saverne              |Marmoutier   |C. de c. de la Sommerau           |
|67005       |67270        |Alteckendorf  |Strasbourg-Campagne  |Hochfelden   |C. de c. du Pays de la Zorn       |
|67006       |67490        |Altenheim     |Saverne              |Saverne      |C. de c. de la région de Saverne  |
```


On peut faire la même chose pour le haut-Rhin [page](http://fr.wikipedia.org/wiki/Communes_du_Haut-Rhin). On notera que la structure du tableau nest pas la même.


```r
file <- "http://fr.wikipedia.org/wiki/Communes_du_Haut-Rhin"
cla <- readHTMLTable(file, stringsAsFactors = FALSE)
length(cla)
```

```
[1] 6
```

```r
lapply(cla, dim)
```

```
$`NULL`
[1] 377   5

$`NULL`
[1] 18  3

$`NULL`
[1] 1 2

$`NULL`
[1] 6 2

$`NULL`
[1] 5 2

$`NULL`
[1] 4 2
```

```r
hr <- cla[[1]]
kable(head(hr))
```

```
|Code Insee  |Code postal  |Commune       |Toponymie allemande  |Population  |
|:-----------|:------------|:-------------|:--------------------|:-----------|
|68001       |68600        |Algolsheim    |                     |1 181       |
|68002       |68210        |Altenach      |                     |380         |
|68004       |68130        |Altkirch      |                     |5 761       |
|68005       |68770        |Ammerschwihr  |Ammerschweier        |1 839       |
|68006       |68210        |Ammerzwiller  |Ammerzweiler         |374         |
|68007       |68280        |Andolsheim    |                     |2 232       |
```


Pour la région alsace (al) on construit un taleau avec les 3 premières colonnes de chacun des tableaux précédents.


```r
al <- rbind(br[, 1:3], hr[, 1:3])
```

nombre de lignes: 904

