##BIVARIATE CORRELATION
install.packages("car")
library(car)

##Create data frames
Height<- c(175, 170, 180, 178, 168)
Weight<-c(60, 70, 75, 80, 69)
Data <- data.frame(Height, Weight)

Data

##ASSUMPTION 1: SAMPLES CONSIST OF RELATED PAIRS
##ASSUMPTION 2: BOTH VARIABLES ARE CONTINUOUS/INTERVAL & LINEARLY RELATED
##ASSUMPTION 3: VARIABLES FOLLOW BIVARIATE NORMAL DISTRIBUTION
scatterplot(Data$Height, Data$Weight)

##OR
qqnorm(Data$Height)
qqline(Data$Height)
qqnorm(Data$Weight)
qqline(Data$Weight)

cor(Data$Height, Data$Weight, use = "complete.obs", method = "pearson")

cor.test(Data$Height, Data$Weight, method = "pearson", conf.level = .99)
cor.test(Data$Height, Data$Weight, method = "pearson", conf.level = .95)

##BIVARIATE CORRELATION WITH MORE THAN TWO VARIABLES
HeartRate <- c(60, 70, 75, 73, 71)

Data2 <- data.frame(Height,Weight,HeartRate)

cor(Data2)

install.packages("Hmisc")
library(Hmisc)
DataMatrix <- as.matrix(data.frame(Height,Weight,HeartRate))
rcorr(DataMatrix)

##R^2 Interpretation
cor(Data)^2
cor(Data)^2*100

##SPEARMAN'S CORRELATION COEFFICIENT
cor(Data$Height, Data$Weight, method = "spearman")
cor.test(Data$Height, Data$Weight, method = "spearman")
cor.test(Data$Height, Data$Weight, alternative = "less", method = "spearman")

##KENDALL's TAU (Common in Ordinal Data with Ranks)
cor(Data$Height, Data$Weight, method = "kendall")
cor.test(Data$Height, Data$Weight, method = "kendall")
cor.test(Data$Height, Data$Weight, alternative = "less", method = "kendall")

##PARTIAL CORRELATION
install.packages("ggm")
library(ggm)

head(simplerelationships)
scatterplot(simplerelationships$Income, simplerelationships$PI)
cor(simplerelationships$Income, simplerelationships$PI, method = "pearson")
cor.test(simplerelationships$Income, simplerelationships$PI, method = "pearson", conf.level = .95)

pc <- pcor(c("Income", "MS", "Age"), var(simplerelationships))
pc
pc^2
pcor.test(pc, 1, 99)






