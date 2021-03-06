#Logistic Regression
data(mtcars)
str(mtcars)
dim(mtcars)
(t=table(mtcars$am))#1 is manual & 0 is automatic
(amt=addmargins(t))
(ppt=prop.table(t))
(base=glm(am~1,data=mtcars,family = binomial()))
(odds=exp-0.3795)
#null deviance --> deviance of base model which includes only intercept value
(fit1 = glm(am~mpg+disp+hp+wt,data = mtcars, family= binomial()))
summary(fit1)#p values of all explanatory variables is > 0.05 : niether of the variables affects the dependent variable am
plot(fit1)
anova(fit1)
layout(matrix(c(1,2,3,4),2,2))
plot(fit1)
(fit2= glm(am~mpg+hp+wt,data = mtcars, family = binomial()))
summary(fit2)
(fit3=glm(am~mpg+hp,data = mtcars,family = binomial()))
(fit4=glm(am~mpg+wt,data = mtcars,family = binomial()))
(fit5=glm(am~hp+wt,data = mtcars,family = binomial()))
summary(fit5)
(probpred=predict(fit5,type= "response", newdata= mtcars[c("hp","wt")]))
probpred=ifelse(probpred>0.5,1,0)
table(probpred)
t=table(mtcars$am,probpred)
t
accuracy=(18+12)/length(mtcars$am)
accuracy
(newdata= data.frame(wt=2,hp=150))
(A= 18.86 + (0.0362*150) - (8.083*2))
exp(8.124)
(P= exp(8.124)/(1+(exp(8.124))))
predict(fit5,newdata,type = "response")
(probpred=ifelse(probpred>0.5,1,0))
table(probpred)
install.packages(caret)
xtab=table(mtcars$am,probpred)
caret::confusionMatrix(t)
car::vif(fit5) #multicollinearity
sqrt(car::vif(fit5))>2
