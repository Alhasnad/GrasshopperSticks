##Set working directory (Ellen's computer)
setwd("C:/Users/elwel/OneDrive/Desktop/GrasshopperSticks")

################# load data
ghop <- read.csv("rawdata/GhopPresence_ResponsesDrivers.csv")
attach(ghop)
head(ghop)
dim(ghop)

####load library
library(lme4)

#set transect and stick to factors
stick<-as.factor(Stick)
transect<-as.factor(Transect)

#function to add a new column onto the data with scaled vars (with s before their name)
scaleVars <- function(df){
  newd <- plyr::numcolwise(scale)(df)
  names(newd) <- sapply(names(newd),function(x)paste0("s",x))
  cbind(df, newd)
}

#apply function
ghop <- scaleVars(ghop)

#model of height in response to time, doy, stream distance
ProxyModel  <-  lm(Height  ~ smilitaryTime + sDOY + sDistance.to.stick.one,data=ghop)#(1|transect:stick)
summary(ProxyModel)

#model of height in response to mean temp of the stick (same result with min/min)
HeightTempModel  <-  lm(Height  ~ MeanTemp,data=ghop)
summary(HeightTempModel)

#model of height in response to temp of the stick at point grasshopper was sitting- less good model which makes sense!
HeightTempModel  <-  lm(Height  ~ sTempAtPoint,data=ghop)
summary(HeightTempModel)
