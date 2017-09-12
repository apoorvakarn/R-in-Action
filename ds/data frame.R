n= c(2,3,5)

n= c(2,3,5)
s= c("aa","bb","cc")
b= c(TRUE,FALSE,TRUE)
df= data.frame(n,s,b)
str(df)
summary((df))
d= c(M,F,M)
d= c("male","female","male")
df= data.frame(n,s,b,d)
df
summary(df)
df= data.frame(n,s,b,d, stringsAsFactors = T)
df
str(mtcars)
?mtcars
help(mtcars)
head(mtcars)
tail(mtcars)
?head
nrow(mtcars)
ncol(mtcars)
summary(mtcars)
mtcars[,1:3]
mtcars[1:5,]
names(mtcars)
mtcars[,"cyl"]
mtcars["mpg","cyl"]
x=c("mpg","cyl")
mtcars[x]
rownames(mtcars)
mtcars["Mazda RX4","cyl"]
mtcars$hp
mtcars[mtcars$mpg>25,]
mtcars[mtcars$carb > 3 & mtcars$wt > 3, c(2,3)]
mtcars[mtcars$hp > 10 | mtcars$carb >3, c(4,5)]
mtcars[mtcars$gear==4,]
mtcars[rownames(mtcars)=='Fiat 128',]
mtcars[1]
library(dplyr)
slice(mtcars, 1L)

library(dplyr)
?dplyr
search()
rownames(df) = c("ID1","ID2","ID3")
df
colnames(df) = c("rollno","name")
mtcars$hp
attach(mtcars)
hp
detach(mtcars)
mtcars
df=mtcars
str(df)
sort(mtcars)
sort(mtcars[,1])
sort(mtcars$mpg, decreasing = T)
sort(mtcars$mpg, decreasing = F)
x=factor("Male","Female","Male")
x
x=factor(c("yes","no","No"))
x
y=factor("yes","no","No")
y
z=factor(c("low","medium","high"),ordered=T,levels = c("high","medium","low"))
z
x1=factor(c("yes","no","yes"),levels = c("yes","no"))
x1
