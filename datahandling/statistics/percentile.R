#percentile
set.seed(1234)
x= ceiling(rnorm(100,50,10))
x
quantile(x,seq(.01,1,by=0.01))

#summary
summary(x)
fivenum(x)
#plot
plot(density(x))
hist(x)
