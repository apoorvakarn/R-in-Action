#decile
set.seed(1234)
x= ceiling(rnorm(100,50,10))
x
quantile(x,seq(.1,1,by=0.1))
#50=46.5
