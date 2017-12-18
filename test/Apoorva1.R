#question1----
(saledate = paste("2016-","0",c(1:6),"-01",sep =""))
dept = c("dept1","dept2")
city = c("Delhi","Noida")
dept = as.factor(dept)
relevel(dept,2)
set.seed(1234)
saleamt = c(ceiling(runif(24,100,200)))
set.seed(1234)
advamt = c(ceiling(runif(24,25,40)))
df = data.frame(saledate,dept,city,saleamt,advamt)
df
df$dept = factor(df$dept,levels = c("dept2","dept1"))
df$dept
str(df)
#manipulation
aggregate(saleamt~dept + city, data= df, FUN = "sum")
x1 = xtabs(saleamt~dept+city,df)
x2 = xtabs(saleamt~ city,df)
x3 = addmargins(x1,c(2,1),FUN = list(sum, list(sd,mean)))
x1
x2
x3
prop.table(df$dept,df$city,margin = NULL)
df2 = df[df$city == "Noida",c(2,4,5)]
df2
df2[order(df2$saleamt),]
df2[order(df2$advamt),]

with(df2,boxplot(saleamt~df2$dept))
within(df2,profit <- saleamt - advamt)
df3 = cbind(df2[1],sweep(df2[,c(2,3)],1,1, FUN = "+"))
df3
install.packages("reshape2")            
df4 = reshape2::melt(df2, id = "dept")
df4
#descriptive stats
plot(df2$saleamt~df2$dept)
#graph
boxplot(df2$saleamt~df$city)
m = mean(df2$saleamt)
m
p = aggregate(df$saleamt,by = list(df$dept,df$city), FUN = "mean")
p
pie(df,p)
