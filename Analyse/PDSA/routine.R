#' Parse un fichier source et retourne un dataframe composé:
#' - en colonne des 12 mois de l'année
#' - en ligne les codes postaux d'alsace
#' Le fichier source est un dataframe formé d'observations appartenant au même groupe, par exeemple CCMU1 en soirée.
#' Ce dataframe doit comporter une colonne ENTREE.
#'@param source_file fichier source (ie dsr1: soirée, ccmu1 et dsr1 <- dsr[!is.na(dsr$GRAVITE) & dsr$GRAVITE==1,])
#'@usage ccmu1_soiree <- routine(dsr1)
#'
routine <- function(source_file){
  # le fichier source est divisé en mois
  mdsr1 <- split(source_file, month(source_file$ENTREE))
  # on forme un dataframe (a) d'une colonne correpondant aux codes postaux théorique du haut et bas-rhin
  a <- data.frame(as.character(c(67000:68999)))
  # on crée la première colonne du dataframe
  m <- as.data.frame(mdsr1[[1]]) # mois de janvier
  cp <- as.character(m$CODE_POSTAL)
  b<-table(cp)
  d <- cbind(names(b),b)
  c <- merge(a,d, all.x=TRUE,by.x=1,by.y=1)
  c$b <- as.integer(as.character(c$b)) # transforme la colonne b (janvier) en integer
  # on traite chaque mois
  for(i in 2:12){
    m <- as.data.frame(mdsr1[[i]])
    cp <- as.character(m$CODE_POSTAL)
    b<-table(cp)
    d <- cbind(names(b),b)
    c <- merge(c,d, all.x=TRUE,by.x=1,by.y=1)
    c[,i+1] <- as.integer(as.character( c[,i+1]))
  }
  names(c) <- c("CP","Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Décembre")
  c[is.na(c)]<-0
  return(c)
}

# extrait toute les communes du fichier source pour produire une liste des communes présentes
col_commune <- function(source_file){
  com <- sort(unique(source_file$COMMUNE))
  a <- as.data.frame(com)
  return(a)
}

# colonne unique pour les 6 fichiers
col_unique <- function(){
  a <- col_commune(dsr1)
  a <- rbind(a, col_commune(dsr2))
  a <- rbind(a, col_commune(dsrt))
  a <- rbind(a, col_commune(dnp1))
  a <- rbind(a, col_commune(dnp2))
  a <- rbind(a, col_commune(dnpt))
  b <- unique(a[,1])
  return(b)
}

# idem mais en utilisant le nom de la commune plutot que le CP

routine2 <- function(source_file, colcom=NULL){
  # le fichier source est divisé en mois
  c_dsr <- split(source_file$COMMUNE, month(as.Date(source_file$ENTREE)))
  
  # on forme un dataframe (a) d'une colonne correpondant aux communes présentes dans le fichier
  if(is.null(colcom)){
    com <- sort(unique(source_file$COMMUNE))
    a <- as.data.frame(com)
  }
  else{
    a <- colcom
  }
  
  # on crée la première colonne du dataframe
  m1 <- as.data.frame(c_dsr[[1]])
  b<-table(as.character(m1[,1]))
  d <- cbind(names(b),b)
  c <- merge(a,d, all.x=TRUE,by.x=1,by.y=1)
  c$b <- as.integer(as.character(c$b)) # transforme la colonne b (janvier) en integer
  
  # on traite chaque mois
  for(i in 2:12){
    m <- as.data.frame(c_dsr[[i]])
    b<-table(as.character(m[,1]))
    d <- cbind(names(b),b)
    c <- merge(c,d, all.x=TRUE,by.x=1,by.y=1)
    c[,i+1] <- as.integer(as.character( c[,i+1]))
  }
  names(c) <- c("COMMUNE","Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Aout","Septembre","Octobre","Novembre","Décembre")
  c[is.na(c)]<-0
  return(c)
}
