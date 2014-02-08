Etude de l'impact de l'arrêt de la PDSA
========================================================

Regarder d'une part 
1) l'activité pour chaque SU, avec pour le total des passages aux SU
- le nombre de CCMU 1
- le nombre de CCMU2
- en fonction des périodes horaires indiquées ci-dessous

En regardant l'évolution du chiffre par semaine, et par mois: une représentation par graphique pourrait être intéressante si cela est possible. Cette première étape vise à observer l'évolution du nombre de CCMU1 sur l'ensemble de l'année, par période horaire (avant/après minuit), sur le nombre total de passage aux urgence: par exemple, en figurant sur un premier graphique: une courbe des CCMU1 avant minuit avec une courbe du nombre de passage total aux SU, et sur un 2e graphique: une courbe des CCMU1 après minuit avec une courbe du nombre de passage total aux SU.
 
et d'autre part 

2) en croisant le nombre de CCMU1 selon la tranche horaire (avant minuit/après minuit) en fonction des territoires de PDSA dont viennent les patients (en utilisant le code postal des patients pour recoder la porvenance du territoire): la question étant= sur toutes les CCMU1 observées après minuit dans chaque SU, il y a-t-il significativement plus de patients en provenance des territoires où la PDSA s'est arrêtée?
Cette deuxième étape viserait à identifier plus finement si une éventuelle augmentation de CCMU1 peut être attribuée à la provenance des patients (territoire de PDSA).
 
L'autre fichier Excel fournit hier permettra d'interpréter les données en fonction des dates d'arrêt de PDSA après minuit dans certains territoires.

Initialisation
--------------
sam. 08 févr. 2014 (20:12:05)

On crée deux groupes:
- soirée (SR) dsr
- nuit profonde (NP) dnp


```r
library("lubridate", lib.loc = "/home/jcb/R/x86_64-pc-linux-gnu-library/3.0")
library("epicalc", lib.loc = "/usr/lib/R/site-library")
```

```
## Loading required package: foreign
## Loading required package: survival
## Loading required package: splines
## Loading required package: MASS
## Loading required package: nnet
```

```r
load("~/Documents/Resural/Stat Resural/RPU_2013/rpu2013d0112.Rda")
dx <- d1[, c("ENTREE", "FINESS", "GRAVITE")]
# groupe soirée
dsr <- dx[hour(dx$ENTREE) > 19 & hour(dx$ENTREE) < 24, ]
dsr$GRP <- "SR"
# groupe nuit profonde
dnp <- dx[hour(dx$ENTREE) >= 0 & hour(dx$ENTREE) < 8, ]
dnp$GRP <- "NP"
# synthèse des deux
dx2 <- rbind(dsr, dnp)
```

Nombre total de passages
------------------------


```r
n_tot <- nrow(d1)
n_soirnuit <- nrow(dx2)
```

- total des passages en 2013: 340338
- entre 20h et 8h: 96874 (28.46 %)
- dont
  - soirée (20h-0h): 59475 (17.48 %)
  - nuit profonde (0h-8h): 37399 (10.99 %)

Analyse CCMU
------------


```r
tab1(dx$GRAVITE, main = "2013 - Gravité (en unités CCMU)", ylab = "Fréquence", 
    xlab = "CCMU")
```

![plot of chunk ccmu](figure/ccmu1.png) 

```
## dx$GRAVITE : 
##         Frequency   %(NA+)   %(NA-)
## 1           38730     11.4     13.3
## 2          206434     60.7     70.8
## 3           40419     11.9     13.9
## 4            3561      1.0      1.2
## 5             868      0.3      0.3
## D              38      0.0      0.0
## P            1380      0.4      0.5
## NA's        48908     14.4      0.0
##   Total    340338    100.0    100.0
```

```r

tab1(dsr$GRAVITE, main = "2013 - Groupe soirée (20h - minuit)")
```

![plot of chunk ccmu](figure/ccmu2.png) 

```
## dsr$GRAVITE : 
##         Frequency   %(NA+)   %(NA-)
## 1            6380     10.7     14.4
## 2           31361     52.7     70.9
## 3            5618      9.4     12.7
## 4             480      0.8      1.1
## 5             115      0.2      0.3
## D              13      0.0      0.0
## P             242      0.4      0.5
## NA's        15266     25.7      0.0
##   Total     59475    100.0    100.0
```

```r

tab1(dnp$GRAVITE, main = "2013 - Groupe nuit profonde (0h - 8h)")
```

![plot of chunk ccmu](figure/ccmu3.png) 

```
## dnp$GRAVITE : 
##         Frequency   %(NA+)   %(NA-)
## 1            4180     11.2     12.2
## 2           23135     61.9     67.3
## 3            6170     16.5     18.0
## 4             557      1.5      1.6
## 5             175      0.5      0.5
## D               6      0.0      0.0
## P             146      0.4      0.4
## NA's         3030      8.1      0.0
##   Total     37399    100.0    100.0
```

```r

t <- table(dx2$GRP, dx2$GRAVITE)
t
```

```
##     
##          1     2     3     4     5     D     P
##   NP  4180 23135  6170   557   175     6   146
##   SR  6380 31361  5618   480   115    13   242
```

```r
# on permute les lignes pour que SR précède NP
a <- t[1, ]
b <- t[2, ]
t <- rbind(b, a)
rownames(t) <- c("SR", "NP")
pt <- round(prop.table(t, margin = 1) * 100, 2)
t
```

```
##       1     2    3   4   5  D   P
## SR 6380 31361 5618 480 115 13 242
## NP 4180 23135 6170 557 175  6 146
```

```r
pt
```

```
##        1     2     3    4    5    D    P
## SR 14.43 70.94 12.71 1.09 0.26 0.03 0.55
## NP 12.16 67.31 17.95 1.62 0.51 0.02 0.42
```

```r
barplot(pt, beside = TRUE, ylab = "pourcentage", xlab = "CCMU en soirée et nuit profonde", 
    main = "Comparaison des CCMU avant et après minuit")
legend("topright", legend = c("0h-24h", "24h-8h"), pch = 15, col = c("grey10", 
    "grey90"))
```

![plot of chunk ccmu](figure/ccmu4.png) 


Analyse des CCMU1 & 2 par mois et semaine
------------------------------------------
- dsr1: soirée, ccmu1
- dsr2: soirée, ccmu2
- dsrt: soirée, total (sans les NA)

- t_dsr1: soirée, ccmu1 par mois
- t_dsr2: soirée, ccmu2 par mois
- t_dsrt

- dnp1: nuit profonde, ccmu1
- dnp2: nuit profonde, ccmu2
- dnpt: nuit profonde, total (sans les NA)

- t_dnp1: nuit profonde, ccmu1 par mois
- t_dnp2: nuit profonde, ccmu2 par mois
- t_dnpt: nuit profonde, total par mois


```r

# soirée ----------
dsr1 <- dsr[!is.na(dsr$GRAVITE) & dsr$GRAVITE == 1, ]
dsr2 <- dsr[!is.na(dsr$GRAVITE) & dsr$GRAVITE == 2, ]
dsrt <- dsr[!is.na(dsr$GRAVITE), ]

t_dsr1 <- tapply(dsr1$GRAVITE, month(as.Date(dsr1$ENTREE)), length)
t_dsr2 <- tapply(dsr2$GRAVITE, month(as.Date(dsr2$ENTREE)), length)
t_dsrt <- tapply(dsr$GRAVITE, month(as.Date(dsr$ENTREE)), length)
sr <- rbind(t_dsr1, t_dsr2, t_dsrt)
barplot(sr, beside = T, ylab = "Freéquence", xlab = "Mois", main = "CCMU 2013 - Soirée")
legend("topleft", legend = c("CCMU 1", "CCMU 2", "Total RPU"), col = c("gray10", 
    "gray50", "gray90"), pch = 15, bty = "n")
```

![plot of chunk mois](figure/mois1.png) 

```r

plot(t_dsr1, type = "l", ylim = c(450, 3500), col = "green")
lines(t_dsr2, ylim = c(450, 3500), col = "blue")
```

![plot of chunk mois](figure/mois2.png) 

```r

# nuit profonde --------------

dnp1 <- dnp[!is.na(dnp$GRAVITE) & dnp$GRAVITE == 1, ]
dnp2 <- dnp[!is.na(dnp$GRAVITE) & dnp$GRAVITE == 2, ]
dnpt <- dnp[!is.na(dnp$GRAVITE), ]

t_dnp1 <- tapply(dnp1$GRAVITE, month(as.Date(dnp1$ENTREE)), length)
t_dnp2 <- tapply(dnp2$GRAVITE, month(as.Date(dnp2$ENTREE)), length)
t_dnpt <- tapply(dnp$GRAVITE, month(as.Date(dnp$ENTREE)), length)
sr <- rbind(t_dnp1, t_dnp2, t_dnpt)
barplot(sr, beside = T, ylab = "Freéquence", xlab = "Mois", main = "CCMU 2013 - Nuit profonde")
legend("topleft", legend = c("CCMU 1", "CCMU 2", "Total RPU"), col = c("gray10", 
    "gray50", "gray90"), pch = 15, bty = "n")
```

![plot of chunk mois](figure/mois3.png) 

```r

# essai de couleurs syntaxe brewer.pal(nb de couleurs,'nom de la palette'))

library(RColorBrewer)
col = brewer.pal(3, "Set2")
barplot(sr, beside = T, col = brewer.pal(3, "BuGn"))
```

![plot of chunk mois](figure/mois4.png) 

```r

barplot(sr, beside = T, col = brewer.pal(3, "YlOrRd"))
```

![plot of chunk mois](figure/mois5.png) 

```r

barplot(sr, beside = T, col = brewer.pal(3, "BuPu"))
```

![plot of chunk mois](figure/mois6.png) 

```r

barplot(sr, beside = T, col = brewer.pal(3, "GnBu"))
```

![plot of chunk mois](figure/mois7.png) 

```r

barplot(sr, beside = T, col = brewer.pal(3, "Greys"))
```

![plot of chunk mois](figure/mois8.png) 

```r

barplot(sr, beside = T, col = brewer.pal(3, "Oranges"))
```

![plot of chunk mois](figure/mois9.png) 

```r

barplot(sr, beside = T, col = brewer.pal(3, "Purples"))
```

![plot of chunk mois](figure/mois10.png) 

```r

col = brewer.pal(3, "Blues")
barplot(sr, beside = T, ylab = "Freéquence", xlab = "Mois", main = "CCMU 2013 - Nuit profonde", 
    col = col)
legend("topleft", legend = c("CCMU 1", "CCMU 2", "Total RPU"), col = col, pch = 15, 
    bty = "n")
```

![plot of chunk mois](figure/mois11.png) 

```r

# CCMU1 soirée et nuit profonde ==============================

YL <- c(min(min(t_dnp1), min(t_dsr1)), max(max(t_dnp1), max(t_dsr1)))
plot(t_dsr1, type = "l", ylim = YL, col = "green", ylab = "Fréquence", xlab = "Mois", 
    main = "CCMU1 2013 (avant et après minuit)")
lines(t_dnp1, col = "blue", ylim = YL)
abline(h = mean(t_dsr1), lty = 2, col = "green")
abline(h = mean(t_dnp1), lty = 2, col = "blue")
text(10, mean(t_dsr1) + 10, paste("moyenne", round(mean(t_dsr1), 2)), col = "green")
text(10, mean(t_dnp1) + 10, paste("moyenne", round(mean(t_dnp1), 2)), col = "blue")
legend("topleft", legend = c("soirée", "nuit profonde"), col = c("green", "blue"), 
    lty = 1)
```

![plot of chunk mois](figure/mois12.png) 

```r

# CCMU2 soirée et nuit profonde ==============================

YL <- c(min(min(t_dnp2), min(t_dsr2)), max(max(t_dnp2), max(t_dsr2)))
plot(t_dsr2, type = "l", ylim = YL, col = "green", ylab = "Fréquence", xlab = "Mois", 
    main = "CCMU2 2013 (avant et après minuit)")
lines(t_dnp2, col = "blue", ylim = YL)

abline(h = mean(t_dsr2), lty = 2, col = "green")
abline(h = mean(t_dnp2), lty = 2, col = "blue")

text(10, mean(t_dsr2) + 10, paste("moyenne", round(mean(t_dsr2), 2)), col = "green")
text(10, mean(t_dnp2) + 10, paste("moyenne", round(mean(t_dnp2), 2)), col = "blue")
legend("topleft", legend = c("soirée", "nuit profonde"), col = c("green", "blue"), 
    lty = 1)
```

![plot of chunk mois](figure/mois13.png) 


Comparaison passages totaux versus CCMU1 et 2
---------------------------------------------

```r
YL <- c(min(t_dsr1), max(t_dsrt))
plot(t_dsr1, type = "l", col = "green", ylim = YL, xlab = "Mois", ylab = "RPU", 
    main = "Comparaison passages totaux ~ CCMU 1 & 2 en soirée")
lines(t_dsrt, ylim = YL, col = "red")
lines(t_dsr2, ylim = YL, col = "blue")
legend("topleft", legend = c("total", "CCMU 1", "CCMU 2"), col = c("red", "green", 
    "blue"), lty = 1, bty = "n")
```

![plot of chunk soiree_tot_ccmu](figure/soiree_tot_ccmu1.png) 

```r

YL <- c(min(t_dnp1), max(t_dnpt))
plot(t_dnp1, type = "l", col = "green", ylim = YL, xlab = "Mois", ylab = "RPU", 
    main = "Comparaison passages totaux ~ CCMU 1 & 2 en Nuit profonde")
lines(t_dnpt, ylim = YL, col = "red")
lines(t_dnp2, ylim = YL, col = "blue")
legend("topleft", legend = c("total", "CCMU 1", "CCMU 2"), col = c("red", "green", 
    "blue"), lty = 1, bty = "n")
```

![plot of chunk soiree_tot_ccmu](figure/soiree_tot_ccmu2.png) 


