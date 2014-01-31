Demographie2
========================================================

Ce document utilise les fichiers newPop67, 68 et Alsace pour créer des constantes concernant la population Alsacienne. Ces données sont complétées par celles de l'INSEE. Toutes les données font référence au recensement du 1er janvier 2010.

Utilisation des fichiers newPop
-------------------------------
Création de groupes de population avec la fonction *cut*. Par défaut, la méthode cut crée des intervalles ouverts à gauche et fermés à droite.

- a[1] ou pop0: enfant de moins de 1 an
- a[2]: patients de 1 an à 14 ans inclus
- a[3]: patients de 15 à 74 ans (inclus)
- a[4]:patients de 75 ans à 84 ans (inclus) = personnes agées
- a[5] patients de 85 ans ou plus (personnes très agées)

- pop0: enfant de moins de 1 an = a[1]
- pop1_75: patients de 1 an (inclu) à 75 ans (exclus) = a[2]+a[3]
- pop75: patients de 75 ans et plus = a[4]+a[5]


```r
# Lecture des données source
load("newPopAlsace.Rda")
# Création des classes d'age
newPopAlsace$age <- cut(newPopAlsace$C_AGED10, breaks = c(-1, 0.99, 14, 74, 
    84, 110), labels = c("Moins de 1 an", "De 1 à 15 ans", "De 15 à 75 ans", 
    "de 75 à 85 ans", "Plus de 85 ans"))
a <- tapply(as.numeric(newPopAlsace$NB), newPopAlsace$age, sum)
sum(a)
```

[1] 1845687

```r
pop0 <- a[1]
pop1_75 <- a[2] + a[3]
pop75 <- a[4] + a[5]

# Création d'un dataframe appelé x

x <- data.frame(c("Moins de 1 an", "De 1 à 75 ans", "Plus de 75 ans", "Total"), 
    c("pop0", "pop1_75", "pop75", "pop_tot"), c(pop0, pop1_75, pop75, 0))
names(x) <- c("Tranche d'age", "Abréviation", "Effectif")
x$Pourcentage <- round(x$Effectif * 100/sum(x$Effectif), 2)
x[4, 3] <- sum(x$Effectif)
x
```

                Tranche d'age Abréviation Effectif Pourcentage
Moins de 1 an   Moins de 1 an        pop0    21655        1.17
De 1 à 15 ans   De 1 à 75 ans     pop1_75  1677958       90.91
de 75 à 85 ans Plus de 75 ans       pop75   146074        7.91
                        Total     pop_tot  1845687        0.00

```r
library("xtable")
xtable(x)
```

% latex table generated in R 3.0.2 by xtable 1.7-1 package
% Sat Oct  5 18:19:33 2013
\begin{table}[ht]
\centering
\begin{tabular}{rllrr}
  \hline
 & Tranche d'age & Abréviation & Effectif & Pourcentage \\ 
  \hline
Moins de 1 an & Moins de 1 an & pop0 & 21655.14 & 1.17 \\ 
  De 1 à 15 ans & De 1 à 75 ans & pop1\_75 & 1677958.12 & 90.91 \\ 
  de 75 à 85 ans & Plus de 75 ans & pop75 & 146073.74 & 7.91 \\ 
   & Total & pop\_tot & 1845687.00 & 0.00 \\ 
   \hline
\end{tabular}
\end{table}

```r

pop0
```

Moins de 1 an 
        21655 

```r
pop1_75
```

De 1 à 15 ans 
      1677958 

```r
pop75
```

de 75 à 85 ans 
        146074 

```r
a
```

 Moins de 1 an  De 1 à 15 ans De 15 à 75 ans de 75 à 85 ans Plus de 85 ans 
         21655         309641        1368317         108426          37647 


  
- population légale 2010: 
  - Alsace   1 845 687

N°  |  Département  |  nb.communes  |  Pop.municipale  |  Pop.totale
----|---------------|---------------|------------------|-------------
67 |  Bas-Rhin |  527 |  1 095 905 | 1 115 226 
68 |  Haut-Rhin | 377  | 749 782 | 765 634 
pop.als.2010.totale<-1115226 + 765634
pop.als.2010.municipale<-1095905 + 749782
pop.67.2010.municipale<-1095905
pop.68.2010.municipale<-749782
