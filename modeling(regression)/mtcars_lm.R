data(mtcars)
str(mtcars)
head(mtcars)
attach(mtcars)
(fit1 = lm(hp ~ gear + carb + mpg , data= mtcars))

(fit2 = lm(hp ~ gear + carb , data =  mtcars))  
anova(fit2,fit1)
AIC(fit1,fit2)
