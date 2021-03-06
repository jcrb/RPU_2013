Fichier RPU quotdien
========================================================

Depuis février 2014, Alsace e-sante transmet quotidiennement un fichier contenant les RPU des 7 derniers jours (j-7 à j-1). Les données correspondant à J-7 sont considérées comme consolidées. Elles peuvent être extraites et stockées. Les données sont transmises de manière habituelle, c'est à dire un fichier .sql qu'il faut transcoder en R pour le nettoyer avant stockage.

1. Le fichier des données est récupéré sur le serveur de test des HUS. Il st déposé dans le dossier de stockage (**/home/jcb/Documents/Resural/Stat Resural/Archives_Sagec/dataQ**) et dézippé.

2. le nom du fichier est construit de la manière suivante:
  - date.jour <- "2014-02-21"
  - file <- paste0("rpu_", date.jour, "_dump.sql")
  - *date.jour est du type AAAA-MM-JJ*

2. le fichier est ensuite transféré dans la base de données **archives** dans la table **RPU__** via R
  - il est important que le répertoire de travail temporaire soit positionné dans le dossier *dataQ*
    - wd <- getwd()
    - setwd("~/Documents/Resural/Stat Resural/Archives_Sagec/dataQ")
    - system(paste0("mysql -u root -pmarion archives < ", file))
    - setwd(wd)

3. Lecture des données dans R
  - library("RMySQL")
  - con<-dbConnect(MySQL(),group = "archives")
  - rs<-dbSendQuery(con,paste("SELECT * FROM RPU__ ",sep=""))
  - dx<-fetch(rs,n=-1,encoding = "UTF-8")
  - max(dx$ENTREE)
  - min(dx$ENTREE)

4. nettoyage des données
  - suppression de la colonne 16: dx<-dx[,-16]
  - transcodage des FINESS (vérification nombre hôpitaux)
  - transformation en facteurs
  - création  d'une colonne AGE (alertes age < 0 et age > 120)
  
5. sauvegarde des données
  - jour à sauvegarder: jour <- as.Date(min(dx$ENTREE))
  - dday <- dx[as.Date(dx$ENTREE) == jour,]
  - fichier du jour: write.table(dday, paste0(date.jour,".csv"), sep=',', quote=TRUE, na="NA", row.names=FALSE,col.names=TRUE)
  - fichier général: write.table(dday, "RPU2014.csv", sep=',', quote=TRUE, na="NA", append = TRUE, row.names=FALSE,col.names=TRUE)

6. fonctions helpers

source("quot_utils.R") ou source("Preparation/RPU Quotidiens/quot_utils.R") en mode console.

- **rpu_jour**: fonction principale. En entrée on donne la date ISO souhaitée et en sortie retourne un dataframe avec les données correspondantes. Le WD doit pointer sur le dossier contenant le fichier .sql correspondant. Ce fichier doit être dézippé.
- **finess2hop**: transforme le code FINESS en nom court d'hopital
- **parse_rpu**: 

séquence:

- date.jour <- "2014_02"
- dx <- parse_rpu(date.jour)
- dx$FINESS <- as.factor(finess2hop(dx$FINESS))
- summary(dx$FINESS) fait un décompte des RPU par établissement sur la période => permet de vérifier si anomalies quantitatives. Suppose de disposer d'un historique moyenne, écart-type par type de jour.
- dx <- rpu2factor(dx)

#' Méthode générale
#' Préalable: disposer d'une base de donnée MySql avec une table appelée "archives". Cette base doit être référencée dans le fichier .my.conf
#'@ data date.jour nom du fichier. Pour une utilisation courante il s'agit de la date du jour au format ISO
parse_rpu <- function(date.jour){
  library("RMySQL")
  file <- paste0("rpu_", date.jour, "_dump.sql")
  wd <- getwd()
  setwd("~/Documents/Resural/Stat Resural/Archives_Sagec/dataQ")
  system(paste0("mysql -u root -pmarion archives < ", file))
  con<-dbConnect(MySQL(),group = "archives")
  rs<-dbSendQuery(con,paste("SELECT * FROM RPU__ ",sep=""))
  dx<-fetch(rs,n=-1,encoding = "UTF-8")
  dx<-dx[,-16]
  dx$FINESS <- as.factor(finess2hop(dx$FINESS))
  
  dx$AGE<-floor(as.numeric(as.Date(dx$ENTREE)-as.Date(dx$NAISSANCE))/365)
  
  dx$EXTRACT <- as.Date(dx$EXTRACT)
  setwd(wd)
}

#' Transformation du code Finess et nom court d'hôpital
finess2hop <- function(a){
  # a<-dx$FINESS
  a[a=="670000397"]<-"Sel"
  a[a=="680000684"]<-"Col"
  a[a=="670016237"]<-"Odi"
  a[a=="670000272"]<-"Wis"
  a[a=="680000700"]<-"Geb"
  a[a=="670780055"]<-"Hus"
  a[a=="680000197"]<-"3Fr"
  a[a=="680000627"]<-"Mul"
  a[a=="670000157"]<-"Hag"
  a[a=="680000320"]<-"Dia"
  a[a=="680000395"]<-"Alk"
  a[a=="670000165"]<-"Sav"
  a[a=="680000494"]<-"Ros"
  a[a=="670780162"]<-"Dts"
  a[a=="670780212"]<-"Ane"
  a[a=="680000601"]<-"Tan"
  return(a)
}

# controles quotidiens
- nlevels(dx$FINESS) si différent de 14 => problème
- nb moyen et ecart-type de RPU par établissement et par jour


```r
date1 <- "2014-03-01"
date2 <- "2014-03-05"
p <- seq(as.Date(date1), as.Date(date2), 1)
for (i in 1:length(p)) {
    x <- parse_rpu(p[i])
    table(x$FINESS, as.Date(x$ENTREE))
}
```

```
## Error: impossible de trouver la fonction "parse_rpu"
```

Commentaires:
-------------

```r
r <- table(as.Date(a$ENTREE), a$FINESS)
```

```
## Error: objet 'a' introuvable
```

```r
r <- r[, -13]  # supprime la colonne 13 qui est totalement vide ?
```

```
## Error: objet 'r' introuvable
```

```r
r
```

```
## Error: objet 'r' introuvable
```


- altkirch: toujours des trous inexpliqués: 1/1, 5/1, 11 et 12/1, 16/1, 18/1, 2/3
- mulhouse: 15/1, 7/2, 5-6-7/3 zéro rpu
- ste odile: 16 au 31/1 pas de rpu
- sélestat: 22 et 23/2 pas de RPU
- diaconat strasbourg: 1-2-3-4/3 puis plus rien
- roosvelt: depuis le 5/2 OK
