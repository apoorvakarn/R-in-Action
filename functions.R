rm(list = ls())
df = load(file = './data/ak2.RData')
df
cat(names(df2))
#Functions
x=2;y=3
(sumofnos=x+y)
x1=c(1:10)
x1

apoorva <- function(x, y) {
  sum2 = x + y
  return(sum2)
}
x=apoorva(5,6)
x
apoorva(7)
sumofnos=sum(x1)
sumofnos
fsum1=function(x1){
  sumofnos=sum(x1)/length(x1)
}
fsum1
fsum1(1:10)#output not seen
fsum1(x1)
(sumout=fsum1(x1))#output seen:value assigned to a variable

#print output from function call
fsum2=function(x1){
  sumofnos=sum(x1)
  return(sumofnos)
}
fsum2(x1)#output seen

fsum2a <- function(x1) { #copy the expression (sumofnos=sum(x1)) and extract function from code
  sumofnos=sum(x1)        #by default it doesnot return the variable
}
fsum2a(x1)                #output not seen bcoz no return argument

sum2a <- function(x3, y3) {
  sumofnos=sum(x3)*mean(y3)#shorcut for extract function-ctrl+alt+x
}
(sum2a(1:10,100:200))


#another way of printing the values inside a function
fsum3 <- function(x1) {
  sumofnos=sum(x1)
  print(sumofnos)
  print(paste('sum of object is',sumofnos,sep='-')) #output is in quotes
  cat(paste('sum of my object is',sumofnos,sep='-'))#output is without quotes
}
fsum3(x1)


#check structure of function
body(fsum3)
body(fsum1)
args(fsum3)
args(sum2a)


args('bxp')#arguments of built in function
body(bxp)


#create a new function
area <- function(pi, r) {
  areacircle=pi*r^2
  return (areacircle)
}
area(pi,14)

#defining default value in the function
area1<- function(mypi=pi, r) {
  areacircle=mypi*r^2
  return (areacircle)
}
area1(r=14)
area1(mypi=4,r=2)
area1(r=3,mypi=2)
area1(3,2)
#we can directly return the value
area2 <- function(pi, r) {
  
  return (pi*r^2)
}
area2(pi,14)
body(area2)
args(area2)

#since pi value is default
area3 <- function(r) {
  
  return (pi*r^2)
}
area3(14)

library(plyr)

#structure of functions
lsf.str()#list of function structures
search()
ls()
lsf.str(pos=-1)#relate to functions
lsf.str(pos=1)#relate to functions
lsf.str(pos=2)#relate to second package in the list
lsf.str(pos=3)
lsf.str(pos=4)
lsf.str(pos=5)
save(area3,file='./datahandling/mfn.RData')
save(area,area1,area2,area3,fsum1,fsum2,fsum2a,fsum3,file='./datahandling/mfn.RData')
load(file = './datahandling/mfn.RData')
area     

#R arguments and objects name into character strings
args(area)
(ch1=deparse(args(area)))
str(ch1)

#invisible
area <- function(pi, r) {
  areacircle=pi*r^2
  invisible(areacircle)
}
area(pi,5)        #no output shown
(ch=area(pi,5))   #assigns and prints
print(area,useSource = T)
print(area,useSource = F)
#print command and optios
pi
print(pi)

print(pi,digits=2)
?print
















