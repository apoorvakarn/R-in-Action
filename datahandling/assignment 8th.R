#8th assignment
data("faithful")
View(faithful)
mean(faithful$eruptions)#q1----
median((faithful$eruptions))#q2----
quantile(faithful$eruptions)#q3----
quantile(faithful$eruptions,c(0.32,0.57,0.98))#q4----
range(faithful$eruptions)#q4----
IQR(faithful$eruptions)#q5----
sqrt(var(faithful$eruptions))#q6----
var(faithful$eruptions)#q7----
library(fBasics)
skewness(faithful$eruptions)#q8----
kurtosis(faithful$eruptions)#q9----
stem(faithful$eruptions)#q10----
plot(x=faithful$eruptions,y=faithful$waiting)#q11----
scatter.smooth(faithful$eruptions,faithful$waiting)#q11----
hist(faithful$eruptions)#q12----
boxplot(faithful$eruptions)#q13----
boxPlot(faithful$eruptions)#q13----
cov(faithful$eruptions,faithful$waiting)#q15----
cor(faithful$eruptions,faithful$waiting)#q16----
#insectsprays
data("InsectSprays")
View(InsectSprays)
boxplot(InsectSprays$count~InsectSprays$spray)
