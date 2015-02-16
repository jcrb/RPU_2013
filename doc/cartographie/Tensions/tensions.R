# tensions.R

# Routines pour travailler avec les tensions hospitalières

#' @name Carte des tensions
#' @author jcb
#' @description dessine les zones de proximités d'Alsace assortie d'une couleur en fonction du niveau de tension
#' @param score dataframe contenant les niveau de tension. La colone 1 est de type Date (date de la mesure).
#'        Les 12 colonnes suivantes correspondent aux 12 zones dans l'ordre de czps
#' @param line ligne du fichier tension.csv utilisée pour définir le niveau de tension
#' @param czps objet de type spatialPolygons contenant la carte des 12 secteurs
#' @param ville dataframe contenant le nom des 12 villes avec leurs coordonnées
#' @note nécessite lubridate
#' @note nécéssite source("../../../Routines/mes_fonctions.R") pour le copyright
#' @details ordre des villes:
# 1 = Wissembourg
# 2 = Mulhouse
# 3 = Altkirch
# 4 = St Louis
# 5 = Haguenau
# 6 = Saverne
# 7 = Strasbourg
# 8 = Schirmeck
# 9 = Selestat
# 10 = Colmar
# 11 = Guebwiller
# 12 = Thann
#'@usage carte_tension(12, score, czps, d)
#'@usage score <- read.csv("doc/cartographie/Tensions/tensions.csv") # lecture du fichier des tensions
#'@usage load("doc/cartographie/RPU2013_Carto_Pop/zone_proximite.Rda")    # czps
#'@usage load("doc/cartographie/RPU2013_Carto_Pop/zp_villes.Rda")    # villes = d
#'

carte_tension <- function(ligne, score, czps, ville){
  date <- as.Date(score[ligne, 1]) # récupère la date (1ère colonne)
  s <- week(date) # détermine le n° de la semaine
  subtitle <- paste0("Semaine ", s, " (", date, ")")
  
  tension <- score[ligne, c(2:13)] # liste des tensions
  
  col <- rep("grey",12) # par défaut toutes les territoires sont gris
  for(i in 1:12){
    if(tension[i] == 1){
      col[i] = "green"}
    else if(tension[i] == 2){
      col[i] = "orange"}
    else if(tension[i] == 3){
      col[i] = "red"}
  }
  
  # dessin de la carte
  plot(czps, col=col, axes=F)
  
  # dessin des villes
  for(i in 1:nrow(d)){
    points(d[i,2], d[i,3], pch=19, col="blue")
    text(x=as.numeric(d[i,2]), y=as.numeric(d[i,3]), labels=d[i,1], cex=0.6, pos=d[i,4])
  }
  
  # rose des vents
  SpatialPolygonsRescale(layout.north.arrow(1), offset= c(950000,6850000), scale = 15000, col="grey",plot.grid=F)
  
  # échelle
  x_scale = 1075000
  SpatialPolygonsRescale(layout.scale.bar(), offset=c(x_scale,6750000), height = 0.05, scale=50000, fill=c("transparent","black"), plot.grid=F)
  text(x_scale,6750000 + 5000, "0", cex=0.6)
  text(x_scale + 50000, 6753387+2000, "50 km", cex=0.6)
  
  # Legende
  legend("topleft", legend=c("Pas de tension","Surcharge","Tension avérée","Pas d'informations"), col=c("green","orange","red","grey"), pch=15, bty="n")
  
  # title
  # subtitle <- format(Sys.time(), "%A %d %B %Y %H:%M:%S")
  # subtitle <- "Semaine n°__ (du __/__/____ au __/__/____)"
  
  title("Carte des tensions en Alsace", sub = subtitle)
  
  copyright(an ="2013-2015", line=-3)
}