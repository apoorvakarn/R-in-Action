m1 = matrix(1:16,nrow = 4)
m1
for(i in 1:4) {
  print(mean(m1[i,]))
}
for(j in 1:4) {
  print(mean(m1[,j]))
}
addmargins(m1,1) # 1 for rows and output will be shown in column
addmargins(m1,2) # 2 for columns and output will be shown in row
rowMeans(m1)
colMeans(m1)
addmargins(m1,1, FUN = mean)
addmargins(m1,2, FUN = mean)

addmargins(m1,c(1,2),mean)
addmargins(m1,c(1,2), FUN = list(sum,mean))
addmargins(m1,c(2,1), FUN = list(mean,sum))

#apply
apply(m1,1,mean) #row means
apply(m1,2,mean) #col means

a=array(1:24, c(3,4,2))
a
apply(a,1,sum)
apply(a,1,mean)
apply(a,2,sum)
apply(a,2,mean)
apply(a,3,sum)
apply(a,3,mean)
apply(a, c(1,3),mean)
apply(a,c(1,2),mean)
apply(a,2,sd)
apply(a,c(1,2,3),mean)
apply(a,c(1,2,3),sum)
apply(a,c(2,3),sum)
apply(a,c(3,2),sum)

# Lapply :- when you want to apply a function to each element of a list in turn and get output in list form
(x = list(a=1, b= 1:3, c = 10:100))
length(x)
x
lapply(x, FUN = length)
lapply(x, FUN = sum)

#sapply :- output will come into vector form      
sapply(x, FUN = sum)
sapply(1:5,function(x) rnorm(3,1)) # easier way to create function
for(i in 1:5) {
  print(rnorm(3,6))
}
func1 = function(x){ # theoratical way to create function
  rnorm(3,x)
}
func1(1)
sapply(1:5,func1)

for(i in 1:5){
  print(matrix(i,2,2))
}
sapply(1:5,function(x) matrix(x,2,2),simplify = "array")

#mapply
#multivariate apply.
#create 4x4 matrix
Q1 = matrix(c(rep(1,4),rep(2,4),rep(3,4),rep(4,4)),4,4)
#print Q1
Q1
# or use mapply()
Q2 = mapply(rep,1:4,5)
Q2
2^3 
mapply(function(x,y) x^y,x=c(1:6) ,y=c(2,3))
mapply(function(x,y){x^y},c(a=2,b=3),c(a=3,b=4))
mapply(function(x,y){x^y},c(a=2,b=3),c(a=3,b=4),USE.NAMES = FALSE)
mapply(function(x,y,z,k){(x+k)^(y+z)},c(a=2,b=3),c(a=3,b=4),MoreArgs = list(1,2))
mapply(function(x,y,z,k){(x+k)^(y+z)},x=c(a=2,b=3),y=c(a=3,b=4),MoreArgs = list(1,2))

#eapply
#like lapply except that rather than applying a function to
#every element in a list,it applies a function to
#every element in environment. for example if we want to find 
#a list of user defined functions in the global environment

A= c(1,3,5,7,9)
B= c(0,3,6,9,12)
C= list(x=1, y=2)
D= function(x){x+1}
ls()
lsf.str()

eapply(.GlobalEnv, is.function)
unlist(eapply(.GlobalEnv,is.vector))
table(unlist(eapply(.GlobalEnv,is.vector)))

#byapply
mtcars$am
mtcars$mpg
mtcars$am; mtcars$mpg
by(mtcars$mpg,mtcars$am, FUN = mean)
by(mtcars$mpg,mtcars$am, FUN = sum)
split(mtcars,mtcars$am)
by(warpbreaks[,1:2],warpbreaks[,"tension"],summary)

#vapply
vapply(x,FUN = length, FUN.VALUE = 0L)

#tapply
library(MASS)
painters
tapply(painters$Composition,painters$School,mean)
