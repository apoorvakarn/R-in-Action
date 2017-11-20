(fit1=lm(mpg~wt,data = mtcars))
(fit2=lm(mpg~wt+cyl,data=mtcars))
anova(fit1,fit2)
#p value <0.05, adding a variable has significant effect on r2
AIC(fit1,fit2) # fit2 with wt and cyl is better
coefficients(fit2)#B0,B1,B2 values
confint(fit2,level=0.95)#B values varies from 2.5 % & 97.5 %
residuals(fit2)#residuals
anova(fit2)#anova table
vcov(fit2)#covariance matrix for model parameters
influence(fit2)#regression diagnostics

