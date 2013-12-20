Jours incomplets
========================================================


#### Jours manquants:a<-as.data.frame(a)

```r
load("rpu2013d0107.Rda")
d2 <- d0107
rm(d0107)

a <- table(as.Date(d2$ENTREE), d2$FINESS)
a <- as.data.frame.matrix(a)
head(a)
```

```
##            3Fr Alk Col Dia Geb Hag Hus Mul Odi Sel Wis Sav
## 2013-01-01  59   0 208  88  45 131 126   0  84 111  32   0
## 2013-01-02  38   0 197  89  42 112 125   0  69  80  49   0
## 2013-01-03  39   0 160  73  42  83 121   0  55  78  35   0
## 2013-01-04  42   0 170  93  30  92 121   0  67  65  24   0
## 2013-01-05  46   0 150  87  44 100 102   0  70  85  38   0
## 2013-01-06  38   0 167  77  43  90  93   0  79  68  36   0
```

```r
# liste par FINESS des jours où le nb de RPU est inférieur à 20: il faut
# ajouter une colonne date pour que cela fonctionne.
a$date <- seq(as.Date("2013-01-01"), as.Date("2013-07-30"), 1)
# On initialise une liste de 12 éléments,12 parce que 12 SU
b <- list(1:12)
# pour chacun des SU, les jours où le nombre de RPU < 20, on stocke la
# date (col.13) et le n° du SU
for (i in 1:12) {
    b[[i]] <- a[a[, i] < 20, c(13, i)]
}
str(b)
```

```
## List of 12
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ date: Date[1:1], format: "2013-07-30"
##   ..$ 3Fr : int 0
##  $ :'data.frame':	115 obs. of  2 variables:
##   ..$ date: Date[1:115], format: "2013-01-01" ...
##   ..$ Alk : int [1:115] 0 0 0 0 0 0 0 0 0 0 ...
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ date: Date[1:1], format: "2013-07-30"
##   ..$ Col : int 0
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ date: Date[1:1], format: "2013-07-30"
##   ..$ Dia : int 0
##  $ :'data.frame':	6 obs. of  2 variables:
##   ..$ date: Date[1:6], format: "2013-05-08" ...
##   ..$ Geb : int [1:6] 0 0 0 0 0 0
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ date: Date[1:1], format: "2013-07-30"
##   ..$ Hag : int 0
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ date: Date[1:1], format: "2013-07-30"
##   ..$ Hus : int 0
##  $ :'data.frame':	20 obs. of  2 variables:
##   ..$ date: Date[1:20], format: "2013-01-01" ...
##   ..$ Mul : int [1:20] 0 0 0 0 0 0 0 0 0 0 ...
##  $ :'data.frame':	1 obs. of  2 variables:
##   ..$ date: Date[1:1], format: "2013-07-30"
##   ..$ Odi : int 0
##  $ :'data.frame':	4 obs. of  2 variables:
##   ..$ date: Date[1:4], format: "2013-04-11" ...
##   ..$ Sel : int [1:4] 6 1 10 0
##  $ :'data.frame':	3 obs. of  2 variables:
##   ..$ date: Date[1:3], format: "2013-01-30" ...
##   ..$ Wis : int [1:3] 16 18 1
##  $ :'data.frame':	203 obs. of  2 variables:
##   ..$ date: Date[1:203], format: "2013-01-01" ...
##   ..$ Sav : int [1:203] 0 0 0 0 0 0 0 0 0 0 ...
```

```r
# dossier manquants pour guebwiller:
b[[5]]
```

```
##                  date Geb
## 2013-05-08 2013-05-08   0
## 2013-05-09 2013-05-09   0
## 2013-05-10 2013-05-10   0
## 2013-05-11 2013-05-11   0
## 2013-05-12 2013-05-12   0
## 2013-07-31 2013-07-30   0
```

```r
names(b[[5]])
```

```
## [1] "date" "Geb"
```

```r
b[[5]]$date
```

```
## [1] "2013-05-08" "2013-05-09" "2013-05-10" "2013-05-11" "2013-05-12"
## [6] "2013-07-30"
```

```r
# liste des SU incomplets:
for (i in 1:12) {
    n = length(b[[i]]$date)
    if (n > 0) {
        print(paste(i, names(b[[i]][2]), n, sep = " "))
    }
}
```

```
## [1] "1 3Fr 1"
## [1] "2 Alk 115"
## [1] "3 Col 1"
## [1] "4 Dia 1"
## [1] "5 Geb 6"
## [1] "6 Hag 1"
## [1] "7 Hus 1"
## [1] "8 Mul 20"
## [1] "9 Odi 1"
## [1] "10 Sel 4"
## [1] "11 Wis 3"
## [1] "12 Sav 203"
```

```r

rm(d2)
```

