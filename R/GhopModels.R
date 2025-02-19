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

#apply function
ghop <- scaleVars(ghop)

#interaction model of mean temp and variation plus distance to riparian
HeightTempModel  <-  lmer(Height  ~ sMeanTemp*sSDTemp + sDistance.to.stick.one+ (1|transect:stick),data=ghop)
summary(HeightTempModel)
r.squaredGLMM(HeightTempModel)

#run this if the above does not provide p-values
# extract coefficients
coefs <- data.frame(coef(summary(HeightTempModel)))
# use normal distribution to approximate p-value
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs

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

#model of height in indirect response to time, doy, shade
ProxyModel  <-  lmer(Height  ~ smilitaryTime + sShade + sDOY + sDistance.to.stick.one+ (1|transect:stick),data=ghop)#
summary(ProxyModel)

