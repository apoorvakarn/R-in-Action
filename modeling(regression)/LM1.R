# linear regression model
#myfit = lm(formula,data)
data(women)
?women
# height numeric Height(in)
#weight numeric weight (lbs)
# linear regression y=mx+c
attach(women)
cov(height,weight)
cor(height,weight)
weight.lm= lm(weight~height,data = women)
(weight.lm =lm(weight~height,data = women)) # to print the values in one line 
summary(weight.lm)
plot(height,weight)
abline(weight.lm,col="red") #line of best fit
abline(v=c(62,64,66),col="blue") #to draw vertical line
abline(h=c(140),col="yellow") # to draw horizontal line
