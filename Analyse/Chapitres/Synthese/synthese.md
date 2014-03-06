Synthèse
========================================================

Comparaison de l'activité des SU


```r
getwd()
```

```
## [1] "/home/jcb/Documents/Resural/Stat Resural/RPU_2013/Analyse/Chapitres/Synthese"
```

```r
source("../resume.R")
source("../prologue.R")
```

```
## [1] "Fichier courant: rpu2013d0112.Rda"
```

```r
su <- c("Wis", "Hag", "Sav", "Hus", "Odi", "Sel", "Col", "Geb", "Mul", "Dia", 
    "3Fr")
a <- resume_service(su[1], d1 = d1)
for (i in su[2:12]) {
    a <- rbind(a, resume_service(i, d1 = d1))
}
```

```
## Error: missing values in 'row.names' are not allowed
```

```r
a <- t(a)
head(a)
```

```
##           Wis                   Hag                  
## n         "12646"               "34414"              
## min_date  "2013-01-01 01:11:00" "2013-01-01 00:10:00"
## max_date  "2013-12-31 23:33:00" "2013-12-31 23:45:00"
## age_moyen "42.7"                "48.2"               
## age_sd    "26.98"               "25.81"              
## ped       " 3202"               " 5277"              
##           Sav                   Hus                  
## n         "12424"               "37018"              
## min_date  "2013-07-23 00:17:00" "2013-01-01 00:11:00"
## max_date  "2013-12-31 23:09:00" "2013-12-31 23:13:00"
## age_moyen "35.6"                "57.7"               
## age_sd    "28.29"               "22.72"              
## ped       " 4603"               " 1138"              
##           Odi                   Sel                  
## n         "25963"               "29534"              
## min_date  "2013-01-01 00:09:00" "2013-01-01 00:04:00"
## max_date  "2013-12-31 23:48:00" "2013-12-31 23:58:00"
## age_moyen "34.3"                "38.0"               
## age_sd    "21.75"               "26.51"              
## ped       " 7488"               " 9171"              
##           Col                   Geb                  
## n         "64758"               "15103"              
## min_date  "2013-01-01 00:19:00" "2013-01-01 01:00:00"
## max_date  "2013-12-31 23:56:00" "2013-12-31 21:35:00"
## age_moyen "35.6"                "37.2"               
## age_sd    "27.65"               "24.49"              
## ped       "23832"               " 4537"              
##           Mul                   Dia                  
## n         "56195"               "29469"              
## min_date  "2013-01-07 00:04:00" "2013-01-01 00:57:00"
## max_date  "2013-12-31 23:54:00" "2013-12-31 23:19:00"
## age_moyen "35.1"                "41.6"               
## age_sd    "27.95"               "24.70"              
## ped       "20181"               " 6304"              
##           3Fr                  
## n         "15688"              
## min_date  "2013-01-01 00:45:00"
## max_date  "2013-12-31 23:46:00"
## age_moyen "38.8"               
## age_sd    "24.37"              
## ped       " 3857"
```

```r
synt <- a[-2:-3, ]
save(synt, file = "Synthese.Rda")
```



