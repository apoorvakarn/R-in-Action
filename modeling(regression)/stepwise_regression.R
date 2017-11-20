#stepwise regression
library(MASS)
names(mtcars)
(fit= lm(mpg~wt+cyl+hp+am, data=mtcars))
step= stepAIC(fit,direction='both')
step$anova
#leaps(all subset regression)
library(leaps)
leaps= regsubsets(mpg~wt+cyl+hp+am,data= mtcars,nbest = 10)
leaps
summary(leaps)
plot(leaps,scale = "r2")
library(car)
subsets(leaps,statistic  ="rsq")
