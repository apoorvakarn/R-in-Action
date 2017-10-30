x =c(1.7,1.6,2.8,5.6,1.3,2.2,1.3,1.1,3.2,1.5,5.2,4.6,5.8,3 )				
y= c(3.7,3.9,6.7,9.5,3.4,5.6,3.7,2.7,5.5,2.9,10.7,7.6,11.8,4.1 )				
df= data.frame(x,y)
df
length(x)
length(y)
sum(x)
sum(y)
mean(x)
mean(y)
cov(x,y)
cor(x,y)#sales is strongly correlated with area
cor.test(x,y)#Pearson's product-moment correlation,#alternative hypothesis: true correlation is not equal to 0
plot(x,y,main='plot between x and y')
abline(lm(y~x),col='green')
text(3,6,"hello")
fit= lm(y~x)
summary(fit)
mean(x)
df
df$X=round(mean(x)-x,2)
df$X
df$Y=round(mean(y)-y,2)
df$Y
df
df$xy=round(df$X*df$Y,2)
df
df$x2=round(df$X*df$X,2)
df
df$y2=round(df$Y*df$Y,2)
df
ssxy=sum(df$xy)
ssxy
ssx2= sum(df$x2)
ssx2
b1=ssxy/ssx2
b1
b0= mean(y)-(b1*mean(x))
b0
df$yh=round(fitted(fit),2)
df$yh
df
plot(df$yh,x)
df$residuals=(round(df$y-df$yh,2))
summary(df$residuals)#through b1 nd b0 all the results came out
df
df$SSr= round((df$yh- mean(y))^2,2)
df$SSr
df
df$SSe = round((df$y-df$yh)^2,2)
df$SSe
df
colSums(df)
(R2=round(sum(df$SSr)/(sum(df$SSe)+ sum(df$SSr)),4))
