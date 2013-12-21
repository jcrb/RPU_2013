RPU Teste cartes
========================================================


```r
library("maptools")
```

```
## Loading required package: sp Checking rgeos availability: TRUE
```

```r
source("../mes_fonctions.R")
```



```r
load("../als_ts.Rda")
plot(ctss)
copyright(an = "2013", side = 4, line = -1, cex = 0.8)
```

![plot of chunk territoires_sante](figure/territoires_sante.png) 



```r
load("../tsvilles.Rda")
plot(ctss)
points(tsvilles[, 2] * 100, tsvilles[, 3] * 100, pch = 20, col = "blue")
text(tsvilles[, 2] * 100, tsvilles[, 3] * 100, tsvilles[, 1], cex = 0.6, pos = 4)
for (i in 1:4) {
    # name<-ctss@polygons[[i]]@ID
    name <- as.character(i)
    x <- ctss@polygons[[i]]@labpt[1]
    y <- ctss@polygons[[i]]@labpt[2]
    symbols(x, y, circles = 1, inches = 0.15, add = T, fg = "red")
    text(x, y, name, cex = 0.9, col = "red", font = 2)
    copyright(an = "2013", side = 4, line = -10, cex = 0.8)
}
title(main = "Secteur sanitaires d'Alsace")
```

![plot of chunk villes](figure/villes.png) 

#'@titre Service d'urgence en Alsace

```r
# fond de carte des territoires de santé
load("../als_ts.Rda")
mar <- par("mar")
par(mar = c(0, 0, 4.1, 0))
plot(ctss)
title(main = "Service d'urgences d'Alsace")
# surimpression des SAU
hopitaux <- "../Fichiers source/Hopitaux2lambert/hopitaux_alsace.csv"
h <- read.csv(hopitaux, header = TRUE, sep = ",")
for (i in 1:nrow(h)) {
    points(h$lam_lon[i], h$lam_lat[i], pch = 19, col = "red")
    text(h$lam_lon[i], h$lam_lat[i], labels = h$hopital[i], cex = 0.8, pos = h$pos[i])
}
copyright(an = "2013", side = 4, line = -10, cex = 0.8)
```

![plot of chunk sau](figure/sau.png) 

```r
par(mar = mar)
```



