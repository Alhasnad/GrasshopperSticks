library(lme4)

temp <- read.csv(file.choose(), header=TRUE) 
attach(temp)
head(temp)

#set id as fator
id<-as.factor(Stick)

#function to add a new column onto the data with scaled vars (with s before their name)
scaleVars <- function(df){
  newd <- plyr::numcolwise(scale)(df)
  names(newd) <- sapply(names(newd),function(x)paste0("s",x))
  cbind(df, newd)
}

#apply function
temp <- scaleVars(temp)

#model
TempModel  <-  lmer(Temperature  ~  sDOY  + sHeight + sDistance.to.stick.one + (1|id),data=temp)# + poly(sHeight,2)
summary(TempModel)

#run this if the above does not provide p-values
# extract coefficients
coefs <- data.frame(coef(summary(TempModel)))
# use normal distribution to approximate p-value
coefs$p.z <- 2 * (1 - pnorm(abs(coefs$t.value)))
coefs

# using subset function
time1 <- subset(temp, Time=="1") 
