library(datasets)
data <- quakes
data

str(data)
summary(data) #summary gives min, mean, median, max
didst <- table(data$mag)
barplot3d(dist)
hist(data)

library(e1071)
skewness(quakes$mag)

