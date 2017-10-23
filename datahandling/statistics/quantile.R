#quantile
set.seed(1234)
x= ceiling(rnorm(100,50,10))
x
quantile(x,c(0.25,0.5,0.75))
quantile(x)
IQR(x)
q1=quantile(x,0.25)
q1
q2=quantile(x,0.50)
q2
q3=quantile(x,0.75)
q3
q4=quantile(x,1.00)
q4
