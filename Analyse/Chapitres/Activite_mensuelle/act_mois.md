Répartition de l'activité
========================================================

```r
date()
```

```
## [1] "Tue Jun  3 10:11:26 2014"
```

```r
wd<-getwd()
wd
```

```
## [1] "/home/aphar/Documents/Resural/RPU_2013/Analyse/Chapitres/Activite_mensuelle"
```
Variables globales:
-------------------

```r
source("../prologue.R")
```

```
## Error: there is no package called 'rgrs'
```

```r
N <- nrow(d1)
```

```
## Error: objet 'd1' introuvable
```

```r
N
```

```
## Error: objet 'N' introuvable
```

```r
mois_f <- c("Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre")
mois_c <- c("Jan","Fév","Mar","Avr","Mai","Jui","Jul","Aou","Sep","Oct","Nov","Déc")
trimestre_f <- c("trim.1","trim.2","trim.3","trim.4")
semaine_f <- c("Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi","Dimanche")
```
Activité globale
----------------

```r
b <- as.Date(max(d1$ENTREE))
```

```
## Error: objet 'd1' introuvable
```

```r
a <- as.Date(min(d1$ENTREE))
```

```
## Error: objet 'd1' introuvable
```

```r
n_jours <- as.numeric(b-a)
```

```
## Error: objet 'b' introuvable
```

```r
moyenne_passages <- N/n_jours
```

```
## Error: objet 'N' introuvable
```









