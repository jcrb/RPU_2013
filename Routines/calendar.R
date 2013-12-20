#' Routines développées pour antoine

#'@title mjd modified julian date
#'@description calcule la date julienne d'un jour donné
#'@param day jour du mois
#'@param  month
#'@param year
#'@param hour
#'@return nombre de jours julien
#'@references Astronomy on the personal computer pp 12
#'
mdj<-function(day,month,year,hour=0.0){
  a<-10000.0*year+100.0*month+day
  if(month <=2){
    month<-month+12
    year<-year-1
  }
  if(a <= 15821004.1)
    b<--2*trunc((year+4716)/4)-1179
  else
    b<-trunc(year/400)-trunc(year/100)+trunc(year/4)
  a<-365.0*year-679004.0
  c<-a+b+trunc(30.6001*(month+1))+day+hour/24.0
  return(c)
}

#'@title caldate
#'@description trouve la date du calendrier civil pour une date julienne modifiée (mjd)
#'@param mjd
#'@param  month
#'@param year
#'@param hour
#'@return
#'@references Astronomy on the personal computer pp 13
#'
caldat<-function(mjd){
  jd<-mjd+2400000.5
  jd0<-trunc(jd+0.5)
  if(jd0 < 2299161.0)
    c<-jd0+1524.0
  else{
    b<-trunc((jd0-1867216.25)/36524.25)
    c<-jd0+(b-trunc(b/4))+1525.0
  }
  d<-trunc((c-122.1)/365.25)
  e<-365.0*d+trunc(d/4)
  f<-trunc((c-e)/30.6001)
  day<-trunc(c-e+0.5)-trunc(30.6001*f)
  month<-f-1-12*trunc(f/14)
  year<-d-4715-trunc((7+month)/10)
  hour<-24.0*(jd+0.5-jd0)
  rep<-c(day,month,year,hour)
  return(rep)
}


#'@title is_bisex
#'@author JcB
#'@description répond TRUE si une année est bisextile
#' une année est bisextile si elle est divisible par 400 ou 4 mais pas par 100
#' x%%1==0 retourne TRUE si x est entier et FALSE si x est fractionnaire
is_bisex<-function(year){
  if((year/400)%%1==0)
    return(TRUE)
  else
    if((year/4)%%1==0 & (year/100)%%1!=0)
      return(TRUE)
  return(FALSE)
}

#'@title
#'@author JcB
#'@description à partir de la date de naissance et de la date du jour calcule le temps écoulé
#'en années, mois et jour
#'@param year1,month1,day1 date de naissance
#'@param year2,month2,day2 date de point
#'@return temps écoulé
#'@todo inclure les années bisextiles et vérifier si le calcul est juste pour les personnes nées au mois
#'de décembre
#'
age2<-function(year1,month1,day1,year2,month2,day2){
  mois<-c(31,28,31,30,31,30,31,31,30,31,30,31)
  year<-year2-1-year1
  month<-12-month1+month2-1
  day<-mois[month1]-day1 + day2
  
  month<-month + trunc(day/30)
  day<-day%%30
  return(c(year,month,day))
}