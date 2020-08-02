install.packages("Hmisc","car","QuantPsyc")

library(Hmisc)
library(car)
library(QuantPsyc)

sugar<-c(5, 8, 9, 10, 15, 18, 14, 17, 20, 22, 24, 26, 30 ,30, 32, 35, 40, 20, 25, 35)
water<-c(1000, 1100, 900, 2000, 1800, 1100, 1400, 2200, 2600, 2400, 3200, 1900, 2050, 2100, 2200, 2200, 1100, 1300, 1900, 1400)
weight <- c(20, 30, 60, 70, 100, 95, 70, 83, 103, 112, 130, 80, 95, 130, 112, 100, 105, 84, 82, 91)

Data <- data.frame(sugar, water, weight)
head(Data)
plot(Data)

##Check Correlations
DataMatrix <- as.matrix(Data[, c("sugar", "water", "weight")])
rcorr(DataMatrix)

##Check Assumptions
#Type of Variables
class(Data$weight)
class(Data$water)
class(Data$sugar)
#Non-Zero Variance
plot(density(Data$weight))
plot(density(Data$water))
plot(density(Data$sugar))

##Model 1 (Simple Regression)
model <- lm(weight ~ sugar, Data)
model
summary(model)
AIC(model) ##181.7333
BIC(model) ##184.7205

##Model 2 (Simple Regression)
model2 <- lm(weight ~ water, Data)
model2
summary(model2)
AIC(model2) ##183.7389
BIC(model2) ##186.7261

##Model 3 (MultipleRegression)
model3 <- lm(weight ~ sugar + water, Data)
model3
summary(model3)
AIC(model3) ##172.1542
BIC(model3) ##176.1372

##Model 4 (Interaction Effect)
model4 <- lm(weight ~ sugar*water, Data)
model4
summary(model4)
AIC(model4) ##173.013
BIC(model4) ##177.9917

#Multicollinearity
#Variance inflation factor
#5-10 (Questionable) 10+ (Multicollinearity is present)
vif(model3)

##Compare models
anova(model, model2)
anova(model, model3)
anova(model2, model3)

##Standardized beta
lm.beta(model3)

##error
library("moments")
shapiro.test(model3$residuals)
plot(density(model3$residuals))

##outliner
cutoff <- 4/((nrow(data)-length(model$weight)-1))
plot(model, which=4, cook.levels=cutoff)
outlierTest(model)

###Stepwise Method
library(leaps)
library(caret)

models <- regsubsets(weight~., data = Data, nvmax = 2,method = "seqrep")
summary(models)

train.control <- trainControl(method = "cv", number = 10)
step.model <- train(weight ~., data = Data, method = "leapSeq",tuneGrid = data.frame(nvmax = 1:2),trControl = train.control)
summary(step.model)
step.model$results

step.model$bestTune


###Backward Method
train.control <- trainControl(method = "cv", number = 10)
step.model2 <- train(weight ~., data = Data, method = "leapBackward",tuneGrid = data.frame(nvmax = 1:2),trControl = train.control)
summary(step.model2)
step.model2$results

step.model2$bestTune

###Dummy Coding
DV <- c(8,10,9,11,12,15,8,9,10,11,15,16,14) ##Happiness
IV1 <- c(1,0,1,1,0,0,1,1,0,1,0,0,0) ##Gender
IV2 <- c(1,0,0,0,1,1,0,0,0,1,1,1,0) ##Marriage Status
data <- data.frame(DV, IV1, IV2)
data

Dmodel <- lm(DV ~ IV1, data)
summary(Dmodel)

Dmode2 <- lm(DV ~ IV2, data)
summary(Dmode2)

Dmode3 <- lm(DV ~ IV1 + IV2, data)
summary(Dmode3)

#In class practice
library(readxl)
cdata <- read_excel("C:/Users/WKao/Desktop/RegressionExample.xlsx")
cdata

cor(cdata$Rating, cdata$Ad, use = "complete.obs", method = "pearson")
cor.test(cdata$Rating, cdata$Ad, method = "pearson")

plot(density(cdata$Rating))

scatterplot(cdata$Age, cdata$Rating)


model <- lm(Rating ~ Ad*Age, cdata)
model
summary(model)
BIC(model)
VIF(model)

model2 <- lm(Rating ~ Ad, cdata)
model2
summary(model2)
BIC(model2)
VIF(model2)

model3 <- lm(Rating ~ Ad + Age, cdata)
model3
summary(model3)
BIC(model3)
vif(model3)

shapiro.test(model$residuals)

anova(model2, model3)








