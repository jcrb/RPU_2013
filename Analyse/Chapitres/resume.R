# Fonction resume_service
# 
# Automatise un résumé des données d'activité pour un services donné. Le fichier source est ch_wissembiurg.Rmd


#' @title presence
#' @author JcB
#' @details 18/12/2013
#' @description Calcule la durée de présence par diddérence entrel'heure de sortie et d'entrée
#' @return un vecteur de dates
#' 
 presence <- function(hop, data = d1){
   e<-ymd_hms(data$ENTREE[data$FINESS == hop])
   s<-ymd_hms(data$SORTIE[data$FINESS == hop])
   t <- s - e
  t[t < 0]<-NA
  #  HOP$presence est de type "difftime" est peut s'exprimer en minutes ou en secondes.
  # Si nécessaire on convertit les secondes en minutes:
  if(units(t) == "secs")
    t <- t/60
  return(t)
}


#==============================================
#                                             #
#       resume_service                        #
#                                             #
#==============================================
#' @title resume_service
#' @author JcB
#' @details 17/12/2013
#' 
#' @param hop str nom de l'hopital
#' @param date année de l'analyse
#' @param d1 source des données
#' @param print imprime les résultats (FALSE par défaut)
#' 
#' @details min_date date de début
#' @details max_date date de fin
#' @details pt population totale
#' 
#' @details n_ccmu1 nombre de CCMU1
#' @details p_ccmu1 pourcentage de CCMU1
#' @details n_ccmu45 nombre de CCMU 4 et 5
#' @details p_ccmu45 pourcentage de CCMU 4 et 5
#' 
#' @return dataframe
#' 
resume_service <- function(hop, date = "2013", d1 = d1, print=FALSE){
  
  library("epicalc")
  library("lubridate")
#   source("./odds.R")
  
  # données de l'établissement hop
  HOP<-d1[d1$FINESS == hop,]
  # nombre de RPU
  n <- nrow(HOP)
  # étendue des enrgistrements
  min_date <- min(HOP$ENTREE)
  max_date <- max(HOP$ENTREE)
  # population totale
  pt <-nrow(d1)

# AGE
# ====================================================================================
  age_local<-HOP$AGE
  s_age <- summary(age_local)

  c <- cut(age_local,breaks=c(-1,1,75,150),labels=c("1 an","1 à 75 ans","sup 75 ans"),ordered_result=TRUE)
  s_a <- summary(c)
  c2 <- cut(age_local, breaks = c(-1,19,75,120), labels = c("Pédiatrie","Adultes","Gériatrie"))
  s_c2 <- summary(c2)

  # age moyen
  age_moyen <- s_age["Mean"]
  # ecart-type
  age_sd <- round(sd(HOP$AGE, na.rm=TRUE),2)

  # nb de rpu pédiatriques
  ped <- s_c2["Pédiatrie"]
  p_ped <- round(ped*100/n,2)

  # nd de rpu gériatriques
  ger <- s_c2["Gériatrie"]
  p_ger <- round(ger*100/n,2)

  age_region<-d1$AGE

  # moins de 1 an / total

  local<-HOP$AGE[HOP$AGE < 1]
  p_inf1an_local <- length(local) * 100 /n
  region <- d1$AGE[d1$AGE < 1]
  p_inf1an_region <- length(region) * 100 / pt
  # on forme une matrice carrée de 2 lignes et 2 colonnes:
  # on saisi d'abord la colonne 1, puis 2
  # pour une saisie par ligne mettre byrow=TRUE
  M1_ped <- matrix(c(p_inf1an_local, n, p_inf1an_region, pt), nrow = 2,byrow=FALSE)
  chisq.test(M1_ped)
  p<-M1_ped[1,1]/n
  q<-M1_ped[1,2]/pt
  or_inf1an <- p*(1-q)/q*(1-p)
  # nécessite la librairie odds
#   calcOddsRatio(M1_ped,referencerow=2)
#   calcRelativeRisk(M1_ped)

# Durée de prise en charge
# -------------------------

  e<-ymd_hms(HOP$ENTREE)
  s<-ymd_hms(HOP$SORTIE)

  HOP$presence <- s - e
  HOP$presence[HOP$presence < 0]<-NA

  #  HOP$presence est de type "difftime" est peut s'exprimer en minutes ou en secondes.
  # Si nécessaire on convertit les secondes en minutes:
  if(units(HOP$presence) == "secs")
    HOP$presence <- HOP$presence/60

  presence <- summary(as.numeric(HOP$presence))

  p4h <- HOP$presence[as.numeric(HOP$presence) < 4*60]
  h <- HOP[HOP$MODE_SORTIE=="Mutation" | HOP$MODE_SORTIE=="Transfert", "presence"]
  s_hosp <- summary(as.numeric(h))
  dom <- HOP[HOP$MODE_SORTIE=="Domicile", "presence"]
  s_dom <- summary(as.numeric(dom))

  p_mean <- presence["Mean"]
  p_median <- presence["Median"]
  p_4h <- length(p4h)
  pp_4h <- round(length(p4h)*100/length(HOP$presence))
  p_hosp_mean <- s_hosp["Mean"]
  p_dom_mean <- s_dom["Mean"]
  tx_hosp <- round(length(h)*100/n,2)

# Horaires
# ===========================================================================================
e<-hour(HOP$ENTREE)
a<-cut(e,breaks=c(0,7,19,23),labels=c("nuit profonde","journée","soirée"))
b <- summary(a)

p_soir <-  round(b['soirée']*100/length(e),2) # % de passages en soirée
p_nuitp <- round(b['nuit profonde']*100/length(e),2) # % en nuit profonde

# On fait la somme du vendredi 20 heures au lundi matin 8 heures. Dimanche = 1

d <-  HOP$ENTREE[wday(HOP$ENTREE)==1 | wday(HOP$ENTREE)==7 | (wday(HOP$ENTREE)==6 & hour(HOP$ENTREE)>19) | (wday(HOP$ENTREE)==2 & hour(HOP$ENTREE)<8)]
f<-summary(as.factor(wday(d)))

n_we <- length(d) # nb de dossiers Week-end
p_we <- round(length(d)*100/n,2)

# Gravité
# ===============================================================================================
d <-  HOP$GRAVITE
a <- summary(d)

n_ccmu1 <- a[1]
p_ccmu1 <- round(a[1]*100/sum(a),2)

n_ccmu45 <- a[4]+a[5]
p_ccmu45 <- round((a[4]+a[5])*100/sum(a),3)


# IMPRESSIONS
# ============
if(print==TRUE){
  print(hop)
  print(paste("RPU déclarés en ",date," : ", n, sep=""))
  print(min_date)
  print(max_date)
  
  print(paste("Age moyen: ", age_moyen, sep = ""))
  print(paste("Pédiatrie: ", ped," passages (", round(s_c2["Pédiatrie"]*100/n),  " %)", sep=""))
  print(paste("Gériatrie: ", ger," passages (", round(s_c2["Gériatrie"]*100/n),  " %)", sep=""))
              
  print(s_age)
  print(s_a)
  print(s_c2)


  print(paste("Durée de présence moyenne: ", p_mean, " mn", sep=""))
  print(paste("Durée de présence médiane: ", p_median, " mn", sep=""))
  print(paste("% en moins de 4 heures: ", p_4h, "(", pp_4h,") %", sep="" ))
  print(paste("si hospitalisé: ", p_hosp_mean, " mn", sep=""))
  print(paste("si retour à domicile: ", p_dom_mean, " mn", sep=""))
  print(paste("Taux d'hospitalisation: ", tx_hosp, " %", sep=""))
  print(paste("% passages en soirée: ", p_soir, " %", sep="" ))
  print(paste("% passages en nuit profonde: ", p_nuitp, " %", sep="" ))
  print(paste("Passages le WE: ", n_we, "(",p_we," %)", sep="" ))
  print(paste("CCMU 1: ", n_ccmu1, "(",p_ccmu1," %) ", sep="" ))
  print(paste("CCMU 4-5: ", n_ccmu45, "(",p_ccmu45," %)", sep="" ))
}



rep <- data.frame(n,as.character(min_date),max_date,age_moyen,age_sd,ped,p_ped,ger,p_ger,p_mean,p_median,p_4h,pp_4h,p_hosp_mean,
                  p_dom_mean,tx_hosp,p_soir,p_nuitp,n_we,p_we,n_ccmu1,p_ccmu1,n_ccmu45,p_ccmu45)
colnames(rep) <- c("n","min_date","max_date","age_moyen","age_sd","ped","p_ped","ger","p_ger","p_mean","p_median","p_4h","pp_4h",
                   "p_hosp_mean","p_dom_mean","tx_hosp","p_soir","p_nuitp","n_we","p_we","n_ccmu1","p_ccmu1","n_ccmu45","p_ccmu45")
rownames(rep) <- hop
return(rep)
}


presence_hist <- function(hop, data = d1){
  # vecteur des présence
  t <- presence(hop, data)
  # on limite la durée de présence limitée à 1 jours
  troisJours <- t[as.numeric(t) < 1440 * 1]
  hist(as.numeric(troisJours),breaks=40,main="Durée de présence",xlab="Temps (minutes)",ylab="Nombre",col="green")
  
  # histogramme avec toutes les données:
  # hist(as.numeric(HOP$presence),breaks=40,main="Durée de présence",xlab="Temps (minutes)",ylab="Nombre",col="green")
}