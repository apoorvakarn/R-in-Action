# assignment 6
#question 1----
x=ceiling(seq(10,200,length.out = 40)) # equal interval between 10 and 200
x
m= matrix(x,nrow = 5) # create the matrix 5x8 : columnwise----
m
# Return the product of each of the rows
apply(m,1,FUN = prod) #7.027086e+14 1.576307e+15 3.068219e+15 5.383547e+15 8.957139e+15
p=m[1,]*m[2,]*m[3,]*m[4,]*m[5,]
p
# Return the sum of each of the columns
apply(m,2,FUN = sum)
apply(m,1,FUN = sum) #Return the sum of each of the rows
# Return a new matrix whose entries are those of 'matrix values' modulo 10----
m1 = (m%%10)
m1
# How many odd nos each column has
y= apply(m,c(1,2),function(x) x%%2 !=0)
y
apply(y,2,sum)
# View the data set iris
View(iris)
# get the mean of the first 4 variables, by species
data(iris)
mean(iris[["Petal.Length"]])
mean(iris[,"Sepal.Width"])
mean(iris["sepal.length",])
mean(iris[,"petal.Width"])
aggregate(iris[1:4],list(iris$Species),mean)
#question 2----
#create a new environment
e = new.env()
e
# two environment variables, a - matrix and b as an array
e$a= matrix(1:12,nrow = 4)
e$a
e$b = array(c(1:3*4*2),dim = c(3,4,2))
e$b
# Find the mean of the variables----
m1=mean(e$a)
m2=mean(e$b)
M= c(m1,m2)
M
#check the class of each object----
class(M) #numeric
class(e) #environment
c=class(c(M,e)) #list
c
#question 3----
# create a list with 2 elements 1:20 and 55:100 and mpg and weight coln of mtcars dataset
v1=c(1:20)
v2=c(55:100)
l=list(v1,v2,mtcars$wt,mtcars$mpg)
l
#find the sum of the values in each statement
lapply(1,sum)#print the values in the form of list
sapply(1,sum)#print the values in the form of vector
# Q4 - Sweep----
a1 <- array(c(1:24),dim=c(4,3,2))
a1
sweep(a1,1,mean(a1),FUN="-")
# dataframe - attitude-----
view(attitude)
dim(attitude)
# median of each column----
med <- apply(attitude,2,median)
# subtract median from each column----
sweep(attitude,2,med,FUN = "-")
#Create an array----
a2 <- array(1:24,dim=c(4,3,2))
#Subtract 5 from each row----
sweep(a2,1,5,FUN="-")
# Find minimum of each row----
minimum = apply(a2,1,min)
minimum
# subtract this minimum value from each row----
sweep(a2,1,minimum,FUN="-")
# subtract median value across row & col----
sweep(a2,1:2,apply(a2,1:2,median))
## warnings ----
sweep(a2,1,1:3) # STATS does not recycle
sweep(a2, 1, 6:1) # STATS is longer----
# exact recyling----
sweep(a2, 1, 1:2,FUN="-")
#Q5 - cast and melt (Reshape2)----
install.packages("reshape2")
library(reshape2)
require(reshape2)
# create data frame----
(x = data.frame(subject = c("Lalit", "Vijay"),time = c(1,1),age = c(33,NA),weight = c(80, NA),height = c(2,2)) )
# melting dataframe x----
melt(x)
# removing NA values----
is.na(x)# TRUE for NA values----
x[!complete.cases(x),]#gives row having NA values
colSums(is.na(x))# gives columns with NA values
x$age[is.na(x$age)] = 26
x$weight[is.na(x$weight)] <- 75
x
y = melt(x)
y
# Now reshape the molten data - pending----
dcast(y,subject~variable)
# dataset - airquality----
view(airquality)
# melting----
y1 <- melt(airquality)
#casting - pending----
# Q6 - merge----
rollno = c(17010,17045,17012,17087,17057,17056,17032,17084,17078,17018,17013)
sname = c('Achal Kumar','Apoorva Karn','Goldie Sahni','Hitesh Mann','Kaustav Chatterjee','Meena Srisha Valavala','Rashmi Ranjan Mangaraj','Shruti Sinha','Shubham Pujan','Vijay Pal Singh','Lalit Sahni')
course =  c('PGDDS','PGDDS','PGDDS','PGDDS','MSCDS','PGDDS','MSCDS','PGDDS', 'PGDDS','PGDDS','PGDDS')
df1 <- data.frame(rollno,sname,course)
gender = c('M','F','M','M','M','F','M','F','M','M','M')
exp =  c(3,3.5,14,5,0,1,1,15,1,3,8) # Experience
hostel =  c(FALSE,FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE)
df2 <- data.frame(rollno,gender,exp,hostel)
#Merge the data frame : automatically-----
merge(df1,df2)
# Create DF of marks of subject1----
ID = c(17010,17045,17012,1)
SEX = c('M','F','M','M')
SUB1 = c(50,60, 70,80)
(df3 = data.frame(ID, SEX, SUB1))
#use to columns to join df1 & df3----
df1$gender = gender
df1
df3
merge(df1,df3,by.x = c('rollno','gender'),by.y = c('ID','SEX'))
merge(df1,df3,by.x=c('rollno'),by.y = c('ID'),all = T)#all rows from df1 & df3
merge(df1,df3,by.x='rollno',by.y = 'ID',all.x=T)#all rows from df1
merge(df1,df3,by.x=c('rollno'),by.y = c('ID'),all = F)#intersection of df1$rollno & df3$ID
merge(df1,df3,by.x='rollno',by.y = 'ID',all.y=T)#all rows from df3
classA = c(10,14,15) 
classB = c(20,25,27)
classC = c(13,15,17)
classmarks <- data.frame(classA,classB,classC)
classmarks
stack(classmarks)
d = stack(classmarks,c('classA','classC'))
unstack(d)
#Q8 - by
df5 = read.csv("./data/dsstudents.csv",na.strings = '')
df5
b1 <- by(df5[,c(11)],INDICES = df5$course,mean)
b1
b2 <- by(df5[,c(12)],INDICES = df5$course,mean)
b2
b3 <- by(df5[,c(13)],INDICES = df5$course,mean)
b3
b4 <- by(df5[,c(14)],INDICES = df5$course,mean)
b4
b5 <- by(df5[,c(1)],INDICES = df5$course,mean)
b5
b6 <- by(df5[,c(7)],INDICES = df5$course,mean)
b6
save(b1,b2,b3,b4,b5,b6,file = 'mydata.RData')
#Q9 - Aggregate----
aggregate(mtcars,by=list(mtcars$cyl,mtcars$am),FUN='mean')
df5
aggregate(df5[,c('rpgm','excel','sql','stats')],by=list(df5$hostel,df5$gender),FUN='sum')
