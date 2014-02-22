
#===========================================================================
# Constantes
#===========================================================================
#'@title Constantes
#'
pop.als.2010.totale<-1115226 + 765634
pop_als_2010_municipale<-1095905 + 749782
pop.67.2010.municipale<-1095905
pop.68.2010.municipale<-749782

pop0<-21655
pop1_75<-1677958
pop75<-146074
pop1_15<-309641
pop15_75<-1368317
pop75_85<-108426
pop85<-37647

#===========================================================================
# load_libraries
#===========================================================================
#'@title load_libraries
#'@description charge les librairies nécessaires
#'
load_libraries<-function(){
  library("gdata")
  library("rgrs")
  library("lubridate")
  library("rattle")
  library("epicalc")
  library("zoo")
  library("xts")
  library("xtable")
  library("plotrix")
  library("openintro")
  library("maptools")
}

#===========================================================================
# resume
#===========================================================================
#'@title resume
#'@description affiche un résummée de données continues
#'@param x vecteur de données
#'@return une matrice contenant moyenne, médiane, écart_type, min, max,n
#'
resume<-function (x)
{
  r<-NULL
  classe<-class(x)
  if(classe=="numeric"){
    name=c("moyenne","écart-type","médiane","min","max","n")
    m<-mean(x,na.remove=TRUE)
    e<-sd(x)
    r<-matrix(c(m,e,median(x),min(x),max(x),length(x)),1,6)
    colnames(r)<-name
    rownames(r)<-""
  }
  else if(classe=="factor"){
    r<-as.matrix(summary(x))
    #rownames(r)<-""
  }
  return(r)
}

#===========================================================================
# copyrigth
#===========================================================================
#'@title copyrigth
#'@author JcB
#'@description Place un copyright Resural sur un graphique. 
#'Par défaut la phrase est inscrite verticalement sur le bord droit de l'image
#'@param an (str) année du copyright (par défaut 2013)
#'@param side coté de l'écriture (défaut = 4)
#'@param line distance par rapport au bord. Défaut=-1, immédiatement à l'intérieur du cadre
#'@param cex taille du texte (défaut 0.8)
#'@return "© 2012 Resural"
#'@usage copyright()
#'
copyright<-function(an ="2013",side=4,line=-1,cex=0.8){
  titre<-paste("©",an,"Resural",sep=" ")
  mtext(titre,side=side,line=line,cex=cex)
}

#===========================================================================
# epigraphe
#===========================================================================
#'@title epigraphe
#'@author JcB
#'@description dessine une courbe épidémiologique du nombre de cas d'une maladie
#'par semaine. Nécessite le package epitools. dessine un histogramme du nombre de cas 
#'par semaine
#'@references dérive de epicurve.weeks
#'@param x variable à afficher en nombre de cas par semaine
#'@param strata vecteur catégoriel (character ou factor) permettant de stratifier x. 
#'Par exemple strata=c("H","F")
#'@param format format de date. Par défaut format = "%Y-%m-%d"
#'@param min.date date de début de la série. Doit correspondre à format.
#'@param max.date date de fin de la série. Doit correspondre à format. Si on ne la précise
#'pas elle est calculée automatiquement.
#'@param col couleur (seq3.r[3:1])
#'
#'
epigraphe<-function(x,format = "%Y-%m-%d", strata = NULL,
                    min.date, max.date,col,main=NULL,xlab=NULL,ylab=NULL,annee="2013"){
  if(!require("epitools")) {stop("Il manque le package 'epitools'")}
  
  xv<-epicurve.weeks(x,strata=strata,min.date=min.date,max.date=max.date,axisname=FALSE,col=col)
  legend("topright",bty="n",legend=names(summary(strata)),pch=15,col=col,cex=0.8)
  axis(1,at=xv$xvals,labels=xv$cweek,tick=FALSE,line=-0.5,cex.axis=0.8)
  axis(1,at=xv$xvals,labels=xv$cmonth,tick=FALSE,line=0.5,cex.axis=0.8)
  axis(1,at=median(xv$xvals),labels=xlab,tick=FALSE,line=1.5)
  title(main=main,ylab=ylab)
  copyright(an=annee)
  return(xv)
}

#===========================================================================
# summaries
#===========================================================================
# fonction summaries()

summaries<-function()
{

}

#===========================================================================
# passages
#===========================================================================
#'@title passages
#'@author JcB
#'@description dessine la fréquentationd'un service d'urgence sous la forme 
#'d'un graphique de type 'radar' de 24 heures.
#'@usage passages(hop,hop_mame="CH",main="",col="")
#'@param hop (character) = Finess de l'établissement
#'@param sens 1 = entrées, 2 = sorties, 3 = entrées et sorties
#'
passages<-function(hop,hop_name="CH",col="blue",sens=1,main="")
{
  require("lubridate")
  hop<-d1[d1$FINESS==hop,]
  if(main==""){main=hop_name}
  if(sens==1){
    e<-ymd_hms(hop$ENTREE)
    col="blue"
    t2<-as.integer(table(hour(e)))
    t4<-prop.table(t2)
    legende<-"Entrées"
  }
  else if(sens==2){
    e<-ymd_hms(hop$SORTIE)
    col="red"
    t2<-as.integer(table(hour(e)))
    t4<-prop.table(t2)
    legende<-"Sorties"
  }
  else if(sens==3){
    e<-ymd_hms(hop$ENTREE)
    s<-ymd_hms(hop$SORTIE)
    col<-c("red","blue")
    te<-as.integer(table(hour(e)))
    ts<-as.integer(table(hour(s)))
    t4<-rbind(prop.table(te),prop.table(ts))
    legende<-c("Entrées","Sorties")
  }

  clock24.plot(t4,clock.pos=1:24,rp.type="p",main=main,show.grid.labels=F,line.col=col,radial.lim=c(0,0.1))
  legend(0.09,-0.09,legende,col=col,lty=1,cex=0.8)
}

#===========================================================================
# mysql2resural
#===========================================================================
#'@title mysql2resural
#'@author
#'@description lit dans la base de données mySql les enregistrements correspondants à
#'un mois donné et produit le dataframe correspondant puis l'enregistre comme un fichier
#'.Rdata
#'@param an
#'@param mois
#'@TODO manque Saverne dans les Finess
#'
mysql2resural<-function(an,mois)
{
  first<-paste(an,mois,"01",sep="-")
  last<-paste(an,mois,"31",sep="-")
  query<-paste("SELECT * FROM RPU__ WHERE ENTREE BETWEEN '",first,"' AND '",last,"'",sep="")
  con<-dbConnect(MySQL(),group = "rpu")
  # rs<-dbSendQuery(con,"SELECT * FROM RPU__ WHERE ENTREE BETWEEN 2013-06-01 AND 2013-06-31")
  rs<-dbSendQuery(con,query)
  d06<-fetch(rs,n=-1,encoding = "UTF-8")
  # nettoyage
  d06<-d06[,-16]
  a<-d06$FINESS
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
  unique(a)
  d06$FINESS<-as.factor(a)
  rm(a)
  d06$CODE_POSTAL<-as.factor(d06$CODE_POSTAL)
  d06$COMMUNE<-as.factor(d06$COMMUNE)
  d06$SEXE<-as.factor(d06$SEXE)
  d06$TRANSPORT<-as.factor(d06$TRANSPORT)
  d06$TRANSPORT_PEC<-as.factor(d06$TRANSPORT_PEC)
  d06$GRAVITE<-as.factor(d06$GRAVITE)
  d06$ORIENTATION<-as.factor(d06$ORIENTATION)
  d06$MODE_ENTREE<-factor(d06$MODE_ENTREE,levels=c(0,6,7,8),labels=c('NA','Mutation','Transfe  rt','Domicile'))
  d06$PROVENANCE<-factor(d06$PROVENANCE,levels=c(0,1,2,3,4,5,8),labels=c('NA','MCO','SSR','SLD','PSY','PEA','PEO'))
  d06$MODE_SORTIE<-factor(d06$MODE_SORTIE,levels=c(0,6,7,8,4),labels=c('NA','Mutation','Transfert','Domicile','Décès'))
  d06$DESTINATION<-factor(d06$DESTINATION,levels=c(0,1,2,3,4,6,7),labels=c('NA','MCO','SSR','SLD','PSY','HAD','HMS'))
  # Création d'une variable AGE:
  d06$AGE<-floor(as.numeric(as.Date(d06$ENTREE)-as.Date(d06$NAISSANCE))/365)
  # Correction des ages supérieurs à 120 ans (3 cas) ou inférieur à 0 (2 cas)
  d06$AGE[d06$AGE > 120]<-NA
  d06$AGE[d06$AGE < 0]<-NA
  # sauvegarde
  write.table(d06,"rpu2013_06.txt",sep=',',quote=TRUE,na="NA")
  save(d06,file="rpu2013d06.Rda")
}

#===========================================================================
# Sex Ratio
#===========================================================================
#'@title sr
sr <- function(){
  sg <- table(g$SEXE)
  sg <- sg[-2] # retire les sexes indéterminés
  psg <- round(prop.table(sg)*100,2)
  b <- rbind(sg,psg)
  rownames(b) <- c("n","%")
  
  sex_ratio <- round(sg["M"]/sg["F"],2)
}

#===========================================================================
# Complétude des données
#===========================================================================
#
#' Calcule le taux de complétude des données contenue dans la dataframe d1
#'@param d1 dataframe
#'@return un vecteur de complétudes exprimé en pourcentage
#'
completude <- function(d1){
  # pour dessiner un radar
  library("plotrix")
  
  # nom des branches du radar:
  rpu.names <- c("Entrée","Sexe","Age","Commune","ZIP","Provenance","PEC Transport","Mode Transport","Mode entrée","CCMU",
                 "Motif","DP","Sortie", "Mode sortie","Orientation","Destination")
  
  # taux de complétude régional. 
  #----------------------------
  #Il est calculé en comptant le nombre de NA dans la base de données, puis en appliquant la méthode MEAN() qui affiche le pourcentage de non réponses. La fonction lapply appliquée sur les colonnes (2) permet de ventiler les résultats par items.
  a <- is.na(d1)
  b <- round(apply(a, 2, mean) * 100, 2)
  b <- cbind(b) # verticalise le vecteur
  colnames(b)<-"%"
  # completude ordonne le vecteur résultat pour qu'il soit rangé dans le même ordre que le vecteur rpu.name. Ainsi b[6] correspond à la date d'entrée.
  completude <- c(b[6],b[16],b[20],b[3],b[2],b[15],b[19],b[18],b[10],b[9],b[12],b[5],b[17],b[11],b[14],b[4])
  completude <- 100 - completude
  
  # **************  
  #  corrections *  
  # **************  
  # on corrrige destination et orientation (voir ch_wissembourg.Rmd)
  
  # Mode de sortie
  # --------------
  a<-summary(d1$MODE_SORTIE)
  hosp <- as.numeric(a["Mutation"] + a["Transfert"])
  
  a<-summary(as.factor(d1$DESTINATION))

  # delta = vrai non renseignés
  delta <- hosp - as.numeric(a["MCO"]+a["SSR"]+a["SLD"]+a["PSY"]+a["HAD"] +a["HMS"]) # -a["HMS"]

  # exhaustivité réelle pour la destination
  exhaustivite.destination <- round(100-(delta*100/hosp),2)
  completude[16] <- exhaustivite.destination
  
  # Orientation
  #------------
  
  #on supprime les NA
  a<-d1$ORIENTATION[!is.na(d1$ORIENTATION)]
  nb_orient <- length(a)
  sa <- summary(a)
  orient.hosp <- as.numeric(sa["HO"]+sa["HDT"]+sa["UHCD"]+sa["SI"]+sa["SC"]+sa["REA"]+sa["OBST"]+sa["MED"]+sa["CHIR"])
  orient.exhaustivite <- 100-round(100*(hosp - orient.hosp)/hosp,2)
  completude_hop[15] <- orient.exhaustivite
  
  return(completude)
  
}

#===========================================================================
# Radar de Complétude des données
#===========================================================================
#'
#'@description Dessine le radar de complétude des données. Dessine un ou 2 radar selon la valeur de Y. Par défaut le premier
#'radar est un polygone coloré, tandis que le second est transparent avec un périmètre coloré.
#'@param x vecteur de complétude
#'@param y second vecteur de complétude
#'@param rp.type="p" pour polygone
#'@param poly.col = "khaki" couleur du polygone
#'@param ch.names = "CH de Colmar"
#'@param line.col="goldenrod4" couleur du trait du second polygone
#'@usage radar_completude(region,a, ch.names = "CH Colmar") où region = completude(d1) et a = completude(d1[d1$FINESS=="Col",])
# dessin du premier radar correspondant à la statistique régionale
# 
radar_completude <- function(x, y = NULL, ch.names = "titre", rp.type="p", poly.col = "khaki",line.col="goldenrod4"){
  # nom des branches du radar:
  rpu.names <- c("Entrée","Sexe","Age","Commune","ZIP","Provenance","PEC Transport","Mode Transport","Mode entrée","CCMU",
                 "Motif","DP","Sortie", "Mode sortie","Orientation","Destination")
  
  radial.plot(x, labels = rpu.names, rp.type="p", radial.lim =c(0,100), 
              poly.col = "khaki", main=paste(ch.names,"- Taux de complétude des RPU"))
  if(!is.null(y)){
    radial.plot(y, labels = rpu.names , radial.lim =c(0,100), add=T,rp.type="p", line.col="goldenrod4", 
                main="Taux de complétude des RPU", lwd=2)
    legend("bottomleft", legend=c(ch.names,"Alsace"), col=c("goldenrod4","khaki"), lty=1, bty="n")
  }
  
}
