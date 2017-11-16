#first centering should be done----
#centering-- we find mid value and put it into mid place
#scaling-- we divide by standard deviation
#for z-score-- we provide true for both the center value and scale value
?scale
x= c(1,3,5,7,9,2,4,6,8,10)
(x1=scale(x,scale = F, center= F))
as.vector(x1)
(xc=scale(x, scale = F , center = T))# centering the mid value
(xc=scale(x, scale = F, center = 5.5))
(xc1=scale(x, scale = F, center = 4))
cbind(x,-4,xc1)
(xs=scale(x,scale = T, center = F))
(round(xs))
(rmse=sqrt(sum(x^2)/(length(x)-1)))#root mean square value
round((xs2=(x/rmse)),2)
(xsc=scale(x,scale = T,center = T))#mean and standard deviation
round((zscore=(x-mean(x))/sd(x)),2)# z-score value
(x2=x-mean(x))
