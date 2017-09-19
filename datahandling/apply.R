# apply functions
x= array(1:24,dim=c(4,3,2))
x
r1= c(paste0("c",1:4))
r1
c1= c(paste0("d",1:3))


c1
y1= c(paste0("s",1:2))
y1
dimnames(x)= list(r1,c1,y1)
x
dimnames(X)= list(c("c1","c2","c3","c4"),c("d1","d2","d3"),c("s1","s2"))
x

# matrix ----
seq_len(length.out = 5)
m1= matrix(c(10:1,rep(5,10),rep(c(5,6),5),seq_len(length.out = 10)),byrow = F,ncol=4)
m1
rownames(m1)= c(paste0("R",1:10))
colnames(m1)= c(paste0("sub",1:4))
m1

#DataFrame ----
df1=data.frame(sub1=10:1, sub2= 5, sub3=rep(c(5,6),5),sub4=seq_len(length.out = 10))
df1

#List ----
list1= list(sub1=10:1,sub2=rep(5,3),sub3=rep(c(5,6),4),sub4=seq_len(length.out = 10))
list1

#print objects ----
x
m1
df1
list1

# apply ----
?apply
x
apply(x,1,sum) # dimension =1 :c
apply(x,1,mean) # dimension =1 :c
apply(x,2,sum) #d
apply(x,2,mean)
apply(x,3,sum)
apply(x,c(1,2),sum) # c&d
apply(x,c(1,2,3),sum) # original :c d
apply(x,c(2,3),sum) # sum over 2 & 3

class(apply(x,1,sum)) # integer vector
addmargins(x,1,sum) # row margin=1
addmargins(x,2,sum) #col margin=1
addmargins(x,3,sum) #sum s1+s2
addmargins(x,c(1,2),sum) #row & col
addmargins(x,c(1,3),sum) #sum rows of s1
addmargins(x,c(2,3),sum) #sum columns of s2
m1
addmargins(m1,c(1,2),FUN = list(list(sum,sd),list(mean,var)))
m2=matrix(1:12,nrow = 3)
m2
addmargins(m2,c(1,2),FUN = list(list(sum),list(mean,var,IQR,sd)))
