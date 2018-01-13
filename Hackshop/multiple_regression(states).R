getwd()
setwd("C:/rWork/rProjects/R-in-Action/hackshop")
data=read.csv('statedata.csv',stringsAsFactors = F,na = "")
data
str(data)
summary(data)
install.packages("pastecs",dependencies = TRUE)
library(pastecs)
options(scipen = 100)
options(digits = 2)
data_ctn<-subset(data, select = c(Population,Income,Illiteracy,Life.Exp,Murder,HS.Grad,Frost,Area,state.area,x,y))
data_cat<-subset(data, select = -c(Population,Income,Illiteracy,Life.Exp,Murder,HS.Grad,Frost,Area))
data_ctn = subset(data,select = c(Population,Income, Illiteracy ,Life.Exp,))
stat.desc(data_ctn)
#categorical values
as.matrix(sort(table(data_cat$state.division),decreasing = TRUE))
as.matrix(sort(table(data_cat$state.name),decreasing = TRUE))
as.matrix(sort(table(data_cat$state.region),decreasing = TRUE))
plot(data$x,data$y, xlab = "longtitude of centres", ylab = "latitude of centres", main = "PLOT OF STATE CENTRES")
boxplot(data$HS.Grad ~ data$state.region, xlab = "Region of USA", ylab = "High School Graduation Rate", main = "Distribution of High School Graduation Rate")
data$state.region<-as.factor(data$state.region)
data$state.division<-as.factor(data$state.division)
data$state.name<-as.factor(data$state.name)
Model1<-lm(Life.Exp~ Population + Income + Illiteracy + Murder + HS.Grad + 
                     Frost + Area + x + y + state.division + state.region,
                     data = data)
Model1
summary(Model1)
Model2<-lm(Life.Exp~ Population + Income + Illiteracy + Murder + HS.Grad + 
             Frost + Area,
           data = data)

summary(Model2)
model3=lm(Life.Exp~Population + Income + Illiteracy + Murder + HS.Grad,
          data= data)
summary(model3)
model4=lm(Life.Exp~Population +Murder+ x + y, 
          data=data )
summary(model4)
model5=lm(Life.Exp~Population +Murder+HS.Grad+Frost ,
          data=data)
summary(model5)

plot(data$Life.Exp,data$Income)
library(car)
as.data.frame(vif(model4))#should not be greater than 1.7




