###Logistic Regression Application
##Check file load
head(LogisticData)
install.packages("car")
library(car)

##Check complete predictors & variation
with(LogisticData, table(TimeOfDay, Ad, ClickThrough))
#OR
xtabs(~TimeOfDay, Ad, data=LogisticData)
xtabs(~TimeOfDay, ClickThrough, data=LogisticData)

##Check assumptions
scatterplot(LogisticData$Ad, LogisticData$ClickThrough)

##Check data variables
str(LogisticData)
class(LogisticData$Ad)
class(LogisticData$ClickThrough)

LogisticData$ClickThrough <- factor(LogisticData$ClickThrough)
LogisticData$Ad <- factor(LogisticData$Ad)
LogisticData$TimeOfDay <- factor(LogisticData$TimeOfDay)

str(LogisticData)

##Model Build
model <- glm(ClickThrough~Ad, data = LogisticData, family = "binomial")
summary(model)

##Test Model
modelchi <- model$null.deviance-model$deviance
cdf <- model$df.null-model$df.residual
chisqp <- 1 - pchisq(modelchi, cdf)
chisqp

##Check Parameters
R2.hl <- modelchi/model$null.deviance
R2.hl

##Odds Ratio
model$coefficients
exp(model$coefficients)
exp(confint(model))

##Perform different models
model2 <- glm(ClickThrough~Ad+TimeOfDay, data = LogisticData, family = "binomial")
model3 <- glm(ClickThrough~Ad+Age, data = LogisticData, family = "binomial")

##Model test with Chi-Square
anova(model, model3, test = "Chisq")

##Multicollinearity (Note need more than one predictor)
vif(model3)

##Probabilities
head(LogisticData[,c("ClickThrough", "Ad", "Age", "predicted.probabilities")])

probabilities <- model %>% predict(LogisticData, type = "response")
head(probabilities)

contrasts(LogisticData$ClickThrough)

predicted.clickthrough <- ifelse(probabilities > 50, "yes", "no")
head(predicted.clickthrough)

##Linearity of Logit
logage <- log(LogisticData$Age)*LogisticData$Age
modeltest <- glm(ClickThrough~Ad + Age + logage, data = LogisticData, family = "binomial")
summary(modeltest)

###Multinomial Logistic Regression
##Clean Data
install.packages("mlogit")
library(mlogit)

##Transfer data to needed R data format
Newdata <-mlogit.data(LogisticData, choice = "ES", shape = "wide")

##Build regression
model <- mlogit(ES~ 1|Ad + TimeOfDay+Age:TimeOfDay + Age:Age, data = Newdata, reflevel = 2)

exp(model$coefficients)
data.frame(exp(model$coefficients))

##Poisson Data
#Check for Poisson Distribution
Library(vcd)
1-pchisq(model$deviance, model$df.residual)

plot(density(CountData$JobOffers))
gf <- goodfit(CountData$JobOffers, type = "poisson", method = "MinChisq")

modelp <- glm(JobOffers ~ Program + AnalyticsScore, data = CountData, family = "poisson")

1-pchisq(modelp$deviance, modelp$df.residual) 

library(MASS)
#Quasi-Poisson:
modelqp <- glm(JobOffers ~ Program + AnalyticsScore, data = CountData, family = "quasipoisson")

#Negative Binomial:
modelnb <- glm.nb(JobOffers ~ Program + AnalyticsScore, data = CountData)

##Ordinal Data
?coeftest()
install.packages("lmtest")
library(lmtest)


head(OrdinalData)
str(OrdinalData)

OrdinalData$Satisfaction <- factor(OrdinalData$Satisfaction)

model <- polr(Satisfaction ~ YTDPurchases + Sex + Age, data = OrdinalData, Hess = TRUE, method = "logistic")
coeftest(model) 







