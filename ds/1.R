age <- c(1,3,5,2,11,9,3,9,12,3) 
weight <- c(4.4,5.3,7.2,5.2,8.5,7.3,6.0,10.4,10.2,6.1) 
mean(weight) 
sd(weight)
cor(age,weight)
plot(age,weight)
demo(graphics)
history(1)

options(digits = 3)
x <- runif(20)
summary(x)
hist(x)
savehistory()
save.image()

library()

.libPaths()
library()
library(gclus)

HELP()
Help()
help()
 
vector
vector()
vector(1)
vector(1:100)

vec1=c(1,4,6,8,10)
vec1
vec2=c(1:100)
vec2
vec3=c(vec1,0,vec2) 
vec3
vec1(5)
vec1[5]
vec1[3]=12
vec1
vec2=seq(from=0,to=1, by=0.25)
vec2
vec1+2
length(vec1)
length(vec1+2)
vec1[vec1>2]
vector("numeric",5)
vector("complex",5)
>u=c(10,20,30)
u=c(10,20,30)
v=c(1,2,3,4,5,6,7,8,9)
u+v
s[-3]
s=c("aa","bb","cc","dd","ee")
L=c(FALSE,TRUE,FALSE,TRUE,FALSE)
s[L]
vec1[c(FALSE,TRUE,FALSE,TRUE,FALSE)]
v=c("Mary","Sue")
v
names(v)=c("First","Last")
v
v[c("Last","First")]

x=c("first"=3,"second"=0,"third"=9)
length(x)
x=apoorva
x="apoorva"
substr(x,1,5)
substr(x,1,7)
x= null
x="null"
vec2=null
vec2="null"
vec2

sort(x)
order(x)
x=c(1,2,3,4,5,6,7)
x[order(x)]
sort(x)
x1=c(1,4,7,2,3)
x1[order(x1)]
sort(x)
order(x1)
sort(x1)
order(x1,decreasing = TRUE)
v=c(1:100)

x=1:3
y=rep(x,3)
y
rep(x,c(1,2,3))
rep(x,c(3,1,2))
v=paste(1:3,4:5,sep = "&")

x=matrix(1:12,nrow = 4,byrow = T)
x
x[2,2]
x[4,2]
x[r,c(1,2)]
x[ ,c(1,2)]
x[c(1,4),2]
dim(x)
mymatrix[-2,-3]
x[-2,-3]
colnames(x)=c("sub1","sub2","sub3")
x
rownames(x)=c("r1","r2","r3")
x

x=c(20,30,40,50)
cbind(x,x)
x=matrix(1:12,nrow = 4,byrow = T)
z=c(x)
z

x=matrix(1:12,nrow = 4,byrow = T)
x
colnames(x)=c("c1","c2",'c3')
x
rownames(x)=c("r1","r2","r3","r4")
x
z=c(x)
x
z
x[x[,2]>5]
x[x[2,]>3]
patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
patientdata <- data.frame(patientID, age, diabetes, status)
patientdata
str(patientdata)
?str
str
help("str")
str(patientID)
patientdata[3,2]
subset_patientdata <-patientdata[1:2,]
subset_patientdata
patientdata[patientdata$diabetes %in% c("Type1","Type2"),]
patientdata[patientdata$status %in% c("Poor","Excellent"),]
patientdata[patientdata$age>25,]
patientdata[patientdata$age<30]
