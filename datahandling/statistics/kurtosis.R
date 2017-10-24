str(mtcars)
vars= c("mpg","hp","wt")
vars
head(mtcars[vars])
str(mtcars)
dim(mtcars)
#descriptive statsistics-----
summary(mtcars)
summary(mtcars[vars])
#use apply or sapply to provide desc.stats----
?sapply# apply function of list or vector----
sapply(x,fun,options)
sapply(mtcars[vars],mean)
sapply(mtcars,fivenum)
#other functions- fivenum,sd,var,min,max,median,length----
library(Hmisc)
describe(mtcars[vars]) # 
library(installr)
updateR()
