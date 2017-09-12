#list
a="my first list"
b=c( 25,26,18,39)
m= matrix(1:8, nrow = 2)
m
a;b;m
d= c("one","two","three")
d
formno=c(17010,17045,17012)
formno
name=c("achal","apoorva","goldie")
name
gender=c("m","f","m")
gender
df=data.frame(formno,name,gender,stringsAsFactors = F)
df
str(df)
mylist=list(a,b,m,d,df)
mylist
str(mylist)
mylist=list(title=a,ages=b,m,students=df)
mylist
mylist # fulllist
mylist[2] #ages as a vector
mylist[['ages']] #ages as a vector
sum(mylist[3]) #sum matrix values #does not work becoz it is list
sum(mylist[[3]]) # works becoz its a vector
mylist$students
mylist[2]
