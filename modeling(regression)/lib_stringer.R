dt2 = read.table(text="var,Sandy Jones,Dave Jon Jhonson,apoorva karn", header=TRUE,sep=",")
dt2

var=c("Sandy Jones","Dave Jon Jhonson","apoorva karn")
dt2=data.frame(var)
dt2
library(stringr)
dt2$var2 = word(dt2$var, -1, sep = " ")
dt2$var2
dt2$var2 = word(dt2$var, -2, sep = " ")
dt2$var2
mydate <- as.Date("2015-09-02")
class(mydate)
mydate + months(3)
