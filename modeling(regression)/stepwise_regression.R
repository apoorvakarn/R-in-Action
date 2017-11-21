#stepwise regression
library(MASS)
names(mtcars)
(fit= lm(mpg~wt+cyl+hp+am, data=mtcars))
step= stepAIC(fit,direction='both')
step$anova
#leaps(all subset regression)#which tell us n best models
library(leaps)
leaps= regsubsets(mpg~wt+cyl+hp+am,data= mtcars,nbest = 10)
leaps
summary(leaps)
plot(leaps,scale = "r2")
library(car)
subsets(leaps,statistic  ="rsq")
#relative importance #to check the relative importance of each variable in the model
install.packages(relaimpo)
library(relaimpo)
calc.relimp(fit,type = c("lmg","last","first","pratt"),rela=TRUE)
boot = boot.relimp(fit,b=1000,type = c("lmg","last","first","pratt"),rank= TRUE,diff= TRUE,rela=TRUE)
booteval.relimp(boot)
plot(booteval.relimp(boot,sort=TRUE))
