#question 2
data(airquality)
attach(airquality)
str(airquality)
dim(airquality)
colnames(airquality)
names(airquality)
summary(airquality)
airquality$Month
aggregate(airquality[,c(1,2,3,4,6)],by = list(airquality$Month), FUN=mean, na.rm = T)
#matrix operations
matrix1 = as.matrix(airquality)
matrix1
n = is.na(matrix1)
is.na(matrix1)
matrix1
colSums(is.na(matrix1)) #== 0

x=mean(matrix1[,1],na.rm= T)
x
x1=mean(matrix1[,2],na.rm= T)
x1
matrix1[which(is.na(matrix1[,1])),1]=x
matrix1[which(is.na(matrix1[,2])),1]=x1
apply(matrix1, 2, x)
apply(matrix1, 2, x1)
