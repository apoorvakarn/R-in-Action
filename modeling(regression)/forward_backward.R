data(mtcars)
View(mtcars)
str(mtcars)
summary(mtcars)
#forward
#blank model
(mtcars.lm=lm(mpg~1,data = mtcars))
summary(mtcars.lm)
#find best predictor
add1(mtcars.lm,mtcars, test = "F")
add1(mtcars.lm,mtcars, test = "Chisq")
add1(mtcars.lm,mtcars, test = "none")
(mtcars.lm=lm(mpg~wt,data = mtcars))
add1(mtcars.lm,mtcars,test = "F")
(mtcars.lm=lm(mpg~wt+cyl,data = mtcars))
add1(mtcars.lm,mtcars,test = "F")
#backward
#create a model with all possible variables
(fit.full= lm(mpg~wt+cyl+hp+am,dat=mtcars))
summary(fit.full)
drop1(fit.full,test="F")  
drop1(update(fit.full,~.-am),test="F")
drop1(update(fit.full,~.-am-hp),test="F")
