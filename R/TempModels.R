##Set working directory (Ellen's computer)
setwd("C:/Users/elwel/OneDrive/Desktop/GrasshopperSticks")
##Set working directory (Nadia's computer)

################# load data
temp <- read.csv("rawdata/temp_sticks.csv") #all temperature data
#temp <- read.csv(file.choose(), header=TRUE) 
attach(temp)
head(temp)
dim(temp)

####load libraries
library(lme4)
library(MuMIn)

#set transect and stick to factors
stick<-as.factor(Stick)
transect<-as.factor(Transect)
#TOD <- as.factor(TOD)

#function to add a new column onto the data with scaled vars (with s before their name)
scaleVars <- function(df){
  newd <- plyr::numcolwise(scale)(df)
  names(newd) <- sapply(names(newd),function(x)paste0("s",x))
  cbind(df, newd)
}

#apply function
temp <- scaleVars(temp)

#model
TempModel  <-  lmer(Temperature  ~  poly(sDOY,2)  + poly(sTOD,2) + sHeight + sShade + sDistance.to.stick.one + (1|transect:stick),data=temp)
summary(TempModel)
r.squaredGLMM(TempModel)

#run this if the above does not provide p-values
# extract coefficients
coefs <- data.frame(coef(summary(TempModel)))
# use normal distribution to approximate p-value
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs

##########################################################
################# load data for temp variation model
tempv <- read.csv("outputs/Temp_stickLevel.csv") #all temperature data
attach(tempv)
head(tempv)
dim(tempv)

#set transect and stick to factors
stick<-as.factor(Stick)
transect<-as.factor(Transect)
tempv$TOD <- militaryTime

#function to add a new column onto the data with scaled vars (with s before their name)
scaleVars <- function(df){
  newd <- plyr::numcolwise(scale)(df)
  names(newd) <- sapply(names(newd),function(x)paste0("s",x))
  cbind(df, newd)
}

#apply function
tempv <- scaleVars(tempv)

#model
TempVModel  <-  lmer(SDTemp  ~  poly(sDOY,2)  + poly(sTOD,2) + sShade + sDistance.to.stick.one + (1|transect:stick),data=tempv)
summary(TempVModel)
r.squaredGLMM(TempVModel)

#run this if the above does not provide p-values
# extract coefficients
coefs <- data.frame(coef(summary(TempVModel)))
# use normal distribution to approximate p-value
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs

boxplot(tempv$SDTemp~tempv$TOD)
boxplot(tempv$SDTemp~tempv$Shade)
##########################################################

# using subset function
shaded <- subset(temp, Shade=="1") 
shade5 <- subset(temp, Shade=="0.5")
shade0 <- subset(temp, Shade=="0")
plot(shaded$Temperature ~ shaded$DOY, col=4)
points(shade5$Temperature ~ shade5$DOY, col=3)
points(shade0$Temperature ~ shade0$DOY, col=2)