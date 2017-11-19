# linear regression model
#myfit = lm(formula,data)
data(women)
?women
# height numeric Height(in)
#weight numeric weight (lbs)
# linear regression y=mx+c
attach(women)
View(women)
cov(height,weight)
cor(height,weight)

write.csv(women,"")

fit= lm(weight~height,data = women)
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit)
fit
summary(fit)

coefficients(fit) # model coefficients
confint(fit, level=0.95) # CIs for model parameters 
fitted(fit) # predicted values
residuals(fit) # residuals
anova(fit) # anova table 
vcov(fit) # covariance matrix for model parameters 

influence(fit) # regression 

(weight.lm =lm(weight~height,data = women)) # to print the values in one line 

plot(height,weight)
abline(weight.lm,col="red") #line of best fit
abline(v=c(62,64,66),col="blue") #to draw vertical line
abline(h=c(140),col="yellow") # to draw horizontal line
