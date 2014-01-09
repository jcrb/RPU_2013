
#' prologue
#' =-=-=-=-=-=-=-=-=-=
#' Proloue.R est unr librairie permettant de charger les bibliothèques, fonctions et fichier maitre
#' nécessaire au fonctionnement des classes .Rmd contenues dans le dossier Chapitres
#' Derniere mise a jour: 13/11/2013
#' Auteur: JcB
#' 
#library("gdata")
library("rgrs")
library("lubridate")
library("rattle")
library("epicalc")
library("zoo")
library("xts")
library("xtable")
library("plotrix")
library("openintro")


#'@name foo
#'=-=-=-=-=-=-=-=-=-=-=-=
#'@description retourne d1, ensemble de toutes les observations
#'@usage d1<-foo(path,file)
#'@param path chemin d'accès au fichier d01
#'@param file nom de fichier courant
#'
foo<-function(path="",file=file){
  if(!exists("d1")) {
    load(paste(path,file,sep=""))
    #       d1<-d0109
    #       rm(d0109)
  }
  #     d1<-d1[d1$ENTREE<"2013-10-01",]
  return (d1)
}

#' Variables globales:
#' -------------------

mois_courant <- 12
annee_courante <- 2013
path <- "../../../../"
a=paste("00",mois_courant,sep="")
a
mois<-substr(a,nchar(a)-1,nchar(a))
mois
file<-paste("rpu",annee_courante,"d01",mois,".Rda",sep="")

print(paste("Fichier courant: ",file,sep=""))
d1<-foo(path="../../../",file=file)

source(paste(path,"mes_fonctions.R",sep=""))

wd<-getwd()


