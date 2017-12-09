#question 3
dept = c("d1","d2")
course = c("c1","c2","c3")
student= c("s1","s2","s3","s4","s5")
subjects= c("sub1","sub2","sub3","sub4")
set.seed(1234)
marks = ceiling(rnorm(2*3*4*5,50,10))
marks
a = array(marks,c(5,4,3,2),dimnames = list(student,subjects,course,dept))
a
apply(a,2,max)
round(apply(a,4,mean))
apply(a,c(1,3,4),sum)
round(apply(a,c(3,4),sd))
