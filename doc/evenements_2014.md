Evènements remarquables 2014
========================================================

- tensions hospitalières
- pic de pollution: semaine 11 (10-16 mars, circulation alternée Paris le 17/3)

Principales fêtes de 2014
-------------------------


```r

library("timeDate")
library("lubridate")

year <- 2014

a <- NewYearsDay()
print(paste("Nouvel an:", wday(a, label = T), a))
```

```
## [1] "Nouvel an: Wed 2014-01-01"
```

```r

a <- Easter(year)
b <- EasterMonday(year)
c <- EasterSunday(year)
d <- GoodFriday(year)
print(paste("Vendredi Saint:", d))
```

```
## [1] "Vendredi Saint: 2014-04-18"
```

```r
print(paste("dimanche de Pâques:", c))
```

```
## [1] "dimanche de Pâques: 2014-04-20"
```

```r
print(paste("lundi de Pâques:", b))
```

```
## [1] "lundi de Pâques: 2014-04-21"
```

```r

a <- FRAllSaints(year)
print(paste("Tousaint:", wday(a, label = T), a))
```

```
## [1] "Tousaint: Sat 2014-11-01"
```

```r

a <- FRArmisticeDay(year)
print(paste("Armistice 1918:", wday(a, label = T), a))
```

```
## [1] "Armistice 1918: Tues 2014-11-11"
```

```r

a <- FRAscension(year)
print(paste("Ascencion:", wday(a, label = T), a))
```

```
## [1] "Ascencion: Thurs 2014-05-29"
```

```r

a <- FRAssumptionVirginMary(year)
print(paste("Assomption:", wday(a, label = T), a))
```

```
## [1] "Assomption: Fri 2014-08-15"
```

```r

a <- FRBastilleDay(year)
print(paste("14 juillet:", wday(a, label = T), a))
```

```
## [1] "14 juillet: Mon 2014-07-14"
```

```r

a <- FRAscension(year)
print(paste("Ascencion:", wday(a, label = T), a))
```

```
## [1] "Ascencion: Thurs 2014-05-29"
```

```r

a <- LaborDay(year)
print(paste("Fête du travail:", wday(a, label = T), a))
```

```
## [1] "Fête du travail: Thurs 2014-05-01"
```

```r

a <- Pentecost(year)
print(paste("Pentecote:", wday(a, label = T), a))
```

```
## [1] "Pentecote: Sun 2014-06-08"
```

```r

a <- PentecostMonday(year)
print(paste("Lundi de pentecote:", wday(a, label = T), a))
```

```
## [1] "Lundi de pentecote: Mon 2014-06-09"
```


