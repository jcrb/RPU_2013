Comparaison RPU recensés versus RPU déclarés
=============================================

Ce travail compare le nombre de RPU transmis à Résural versus le nombre de RPU officiellement déclarés par les directions hospitalières. Les hôpitaux sont interrogés officiellment par Résural. Les résultats sont colligés dans le fichier __doc/attente chiffres RPU officiels.csv__.


```r
getwd()
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU_2013/doc/Chiffres_officiels"
```

```r
file <- "attente chiffres RPU officiels.csv"
x <- read.table(file, header = TRUE, sep = ",")
names(x)
```

```
## [1] "établissement"      "ville"              "nom.du.directeur"  
## [4] "chiffres.officiels" "chiffre.RESURAL"
```

```r

a <- rbind(x$chiffres.officiels, x$chiffre.RESURAL)
a[is.na(a)] <- 100
rownames(a) <- c("Etablissement", "RESURAL")

or <- par()$mar
print(or)
```

```
## [1] 5.1 4.1 4.1 2.1
```

```r
par(mar = c(9, 4, 2, 0))
barplot(a, beside = TRUE, col = c("darkblue", "red"), names.arg = x$établissement, 
    las = 2, main = "2013 - Comparaison Passages au SU et RPU déclarés")
legend(1, 115000, legend = rownames(a), col = c("darkblue", "red"), pch = 15, 
    pt.cex = 2)
```

![plot of chunk compare](figure/compare.png) 

```r
par(mar = c(5.1, 4.1, 4.1, 2.1))
```


![wzq](../Analyse/Chapitres/CH_Wissembourg/figure/completude_hop_als1.png)


