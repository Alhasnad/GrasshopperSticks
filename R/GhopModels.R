##Set working directory (Ellen's computer)
setwd("C:/Users/elwel/OneDrive/Desktop/GrasshopperSticks")

################# load data
ghop <- read.csv("rawdata/GhopPresence_ResponsesDrivers.csv")
attach(ghop)
head(ghop)
dim(ghop)

####load library
library(lme4)
library(MuMIn)

#set transect and stick to factors
stick<-as.factor(Stick)
transect<-as.factor(Transect)

#function to add a new column onto the data with scaled vars (with s before their name)
scaleVars <- function(df){
  newd <- plyr::numcolwise(scale)(df)
  names(newd) <- sapply(names(newd),function(x)paste0("s",x))
  cbind(df, newd)
}
citation("effects")
#apply function
ghop <- scaleVars(ghop)

#model of height in response to time, doy, shade
ProxyModel  <-  lm(Height  ~ smilitaryTime + sShade + sDOY + sDistance.to.stick.one,data=ghop)#(1|transect:stick)
summary(ProxyModel)

#model of height in response to mean temp of the stick (same result with min/min)
HeightTempModel  <-  lm(Height  ~ MeanTemp,data=ghop)
summary(HeightTempModel)

#model of height in response to temp of the stick at point grasshopper was sitting- less good model which makes sense!
HeightTempModel  <-  lm(Height  ~ sTempAtPoint,data=ghop)
summary(HeightTempModel)

#interaction model of mean temp and variation plus distance to riparian
HeightTempModel  <-  lm(Height  ~ MeanTemp*SDTemp + Distance.to.stick.one,data=ghop)
summary(HeightTempModel)

##quick plots
plot(Height  ~ MeanTemp)
abline(lm(Height  ~ MeanTemp))
plot(Height  ~ SDTemp)
abline(lm(Height  ~ SDTemp))
plot(Height  ~ Distance.to.stick.one)
abline(lm(Height  ~ Distance.to.stick.one))

# interaction plot of temp and temp Standard Deviation

library(effects)

tiff(filename = "plots/Temp_interactionPlot.tiff", width = 6.5, height = 5.5, units = 'in', res = 600, compression = 'lzw')

TempSD <- SDTemp
HeightTempModel  <-  lm(Height  ~ MeanTemp*TempSD,data=ghop)
summary(HeightTempModel)
model_effects <- effect("MeanTemp*TempSD", HeightTempModel)#
plot(model_effects, cex.lab=10, main="", xlab = "Stick mean temperature (°C)",
ylab="Grasshopper height (cm)",multiline=TRUE,lwd=3,lty=c(1,5,2,3,4), 
key.args=list(x=0.2,y=0.9,corner=c(x=1, y=0.6)), ci.style="bands",ylim=c(0,100))

dev.off()

##
