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



