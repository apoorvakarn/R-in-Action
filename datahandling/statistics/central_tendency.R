#mean----
set.seed(1234)
x = rnorm(100,50,10) #100 random numbers ,mean=50 and sd=10
x = ceiling(x)
x
meanx = sum(x)/length(x)
meanx
summary(x)
# trimming values----
x
set.seed(1234)
x = ceiling(runif(100,50,100))#extreme values
x
mean(x)
mean(x, trim =0.1)
#NA values- remove ----
x[c(1,20,30)] = NA
x
table(is.na(x))
table(anyNA(x))
length(na.omit(x)) # 3 values
mean(x) #error
mean(x,na.rm = T)
# mean deviation----
x = c(3,6,6,7,8,11,15,16)
(mx = mean(x))
(mdev = x - mx)
mdev
abs(mdev)
(mabsdev = sum (abs(mdev)))/length(x)
mad(x,center = mean(x)) # direct from formula #mean absolute deviation----
#marks out of 25: 7,4,10,9,15,12,7,9,7
#calculate MD about Mean,Median,Mode
a=c(7,4,10,9,15,12,7,9,7)
mean(a)
#median----
median(a)
#mode----
x = c(2,3,4,4,4,5,5)
library(modeest)
m = mlv(x,method = "mfv")
m
#getmode(x)----
fivenum(x)
?mlv
