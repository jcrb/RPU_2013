#'
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



sum(ccmu1_soiree[2:13])