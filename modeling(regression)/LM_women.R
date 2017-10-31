data(women)
(women)
nrow(women)
attach(women)
cor.test(weight,height,data=women)
class(women)
fit=lm(weight~height,data=women)
fit
plot(height,weight,main = "height vs weight")
abline(fit,col="yellow")
text(height,weight,labels = paste0('(',height,',',weight,')'),col = "pink")
summary(fit)
fitted(fit)#predicted values
#polynomial model
fit2 = lm(weight~height + I(height^2),data=women)
fit2
summary(fit2)
plot(height,weight,main = "height vs weight")
lines(women$height,fitted(fit2),col='blue')
fit3 = lm(weight~height + I(height^2)+ I(height^3),data=women)
fit3
summary(fit3)
plot(height,weight,main = "height vs weight")
lines(women$height,fitted(fit3),col='red')
car::scatterplot(weight~height,dat=women,spread = FALSE,lty.smooth=2,pch=19,main='women age 30-39',xlab='height(inches)',ylab='weight(lbs.)')
?cars
