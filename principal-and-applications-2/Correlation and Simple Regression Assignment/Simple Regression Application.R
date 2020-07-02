head(simplerelationships)

##CHECK FOR ASSUMPTIONS
##Variable Type
class(simplerelationships$Income)
class(simplerelationships$PI)
class(simplerelationships$MS)
##Non-Zero Variance
plot(density(simplerelationships$Income))
plot(density(simplerelationships$PI))
plot(density(simplerelationships$MS))
##Heteroscedasticity
scatterplot(simplerelationships$Income, simplerelationships$PI)
##Normally Distributed Error
qqnorm(simplerelationships$PI)
qqline(simplerelationships$PI)
##Linearity
scatterplot(simplerelationships$Income, simplerelationships$PI)

##Regression Model
model <- lm(PI ~ Income, data = simplerelationships)
summary(model)

#Residuals: #Distance from the data to the fitted line (ideally should be symetric around line)
#  Min        1Q    Median        3Q       Max 
#-0.026076 -0.004835  0.004298  0.006859  0.012624 

#Coefficients:
#           Estimate Std. Error       t value   Pr(>|t|)    
#(Intercept) -8.378e-03   2.570e-03  -3.260     0.00154 ** (Generally not interested in this p-value)
#  Income     1.097e-07   2.560e-08   4.286     4.3e-05 ***
#  ---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

#Residual standard error: 0.01075 on 97 degrees of freedom (Square root of the denominator in the equation for F)
#Multiple R-squared:  0.1592,	Adjusted R-squared:  0.1505 (Income can explain 16% of the variation in PI)
#F-statistic: 18.37 on 1 and 97 DF,  p-value: 4.296e-05 (p-value from above)

##Model Plot
plot(simplerelationships$Income, simplerelationships$PI)
abline(model)

plot(model)

##Non-Linear Regression
set.seed(20191007)
x<-seq(0,50,1)
y<-((runif(1,10,20)*x)/(runif(1,0,10)+x))+rnorm(51,0,1)

plot(x,y)

#Approximate Starting Values
a_start<-8
b_start<-2*log(2)/a_start 

model<-nls(y~a*exp(-b*x),start=list(a=a_start,b=b_start))
lines(x,predict(model),lty=2,col="red",lwd=3)


