SpatialPolygons
========================================================

Analyse d'un objet spatialpolygons.  
Nécessite le package *sp*
Utilise le fichier *als_ts* qui contient l'objet *ctss*. Plot(ctss) affiche un fond de carte représentant l'Alsace découpée en 4 territoires de santé.

```r
load("als_ts.Rda")
slotNames(ctss)
```

```
## Loading required package: sp
```

```
## [1] "polygons"    "plotOrder"   "bbox"        "proj4string"
```

```r
slotNames(ctss@polygons[[1]])
```

```
## [1] "Polygons"  "plotOrder" "labpt"     "ID"        "area"
```

```r
ctss@polygons[[1]]@ID
```

```
## [1] "TERRITOIRE DE SANTE 1"
```

```r
ctss@polygons[[1]]@labpt
```

```
## [1] 1037465 6871311
```

```r
ctss@polygons[[1]]@area
```

```
## [1] 2.673e+09
```

```r

plot(ctss)

name <- ctss@polygons[[1]]@ID
x <- ctss@polygons[[1]]@labpt[1]
y <- ctss@polygons[[1]]@labpt[2]
text(x, y, name, cex = 0.6)

y <- ctss@polygons[[2]]@labpt[2]
x <- ctss@polygons[[2]]@labpt[1]
name <- ctss@polygons[[2]]@ID
text(x, y, name, cex = 0.6)

y <- ctss@polygons[[3]]@labpt[2]
x <- ctss@polygons[[3]]@labpt[1]
name <- "3"
text(x, y, name, cex = 0.8)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-11.png) 

```r

plot(ctss)
for (i in 1:4) {
    # name<-ctss@polygons[[i]]@ID
    name <- as.character(i)
    x <- ctss@polygons[[i]]@labpt[1]
    y <- ctss@polygons[[i]]@labpt[2]
    text(x, y, name, cex = 0.6)
}
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-12.png) 



