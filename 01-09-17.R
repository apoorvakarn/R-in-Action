x= 1:12
x= c(1:12,1,5,5)
table(x)
names(table(x))
sort(table(x))
sort(table(x),decr=T)
sort(table(x),dec=T)
names(table(x))[1]
names(sort(table(x),dec=T))[1]#[]it is used for getting the exact number of element, like[1],[7]..
 # third part of assignment
set.seed(1234)
x=ceiling(rnorm(100,60,15))
x
mean(x)
table(x)
x[c(1,2,3,4,5)]=c(0,10,11,99,100)
head(x,n=5)
barplot(x)
range(x)
bks= seq(25,99,10)
bks
bks= seq(20,100,10)
bks
(bks= seq(0,100,10))# round bracket helps in to fetch the result..
#slabs :0-10,20-30
classint1= cut(x,breaks = bks) #default right=T
head(classint1,n=5)
head(x,n=5)
classint1
table(classint1)
bks
?cut#divides the range of x into intervals and codes the value in x # according to which interval they fall.
#correct the problem of NA
classint1a=cut(X,breaks = bks,include.lowest = T)
x.cut=cut(x,bks)
x.cut
x.table=table(x.cut)
x.table
cbind(x.table)
x
hist(x)
hist(x,breaks = 10)
length(bks)
length((bks)-1)
LETTERS[1:length(bks)-1]
