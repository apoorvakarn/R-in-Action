getwd()
setwd("C:/rWork/rProjects/R-in-Action/hackshop/multivariate_LR")
data=read.csv("elantra.csv",stringsAsFactors = FALSE,header = TRUE)
data

#Structure and summary of data
str(data)
summary(data)

#Checking for NA values
colSums(is.na(data))
#checking correlation with dependent variables
cor.test(data$ElantraSales,data$Month)
cor.test(data$ElantraSales,data$Year)
cor.test(data$ElantraSales,data$Unemployment)
cor.test(data$ElantraSales,data$Queries)
cor.test(data$ElantraSales,data$CPI_energy)
cor.test(data$ElantraSales,data$CPI_all)

#Partitioning the data into train and validation
traindata=subset(data,Year<=2012)
traindata
testdata=subset(data,Year>2012)
testdata
nrow(traindata)
nrow(testdata)



####building a model
model1=lm(ElantraSales~Unemployment+CPI_all+ CPI_energy + Queries,data=traindata)
summary(model1)


##model includes month
model2=lm(ElantraSales~Month+Unemployment+CPI_all+ CPI_energy + Queries,data=traindata)
summary(model2)

#Converting month as Factor
data$Month=as.factor(data$Month)
str(data)

traindata$Month=as.factor(traindata$Month)
str(traindata)
#after making month as factor

model3=lm(ElantraSales~Month+Unemployment+CPI_all+ CPI_energy + Queries,data=traindata)
summary(model3)

#removing the variable queries

model4=lm(ElantraSales~Month+Unemployment+CPI_all+ CPI_energy ,data=traindata)
summary(model4)

#Normality Test----
res=model4$residuals
library(nortest)
res
par(mfrow=c(2,2))
plot(model4)
#Anderson-Darling Test
ad.test(res)
plot(model4)

#Homoscedasticity Test
library(car)
#non-constant Variance Test
ncvTest(model4)

#Autocorrelation Test
durbinWatsonTest(model4)

#Multicollinearity Test
as.data.frame(vif(model4))




#using stargazer library
library(stargazer)
stargazer(model4,type="text",out="model4.txt")
stargazer(model1,model2,model3,model4,type="text",out = "elantramodels.txt")

#prediction
testdata$Month=as.factor(testdata$Month)
pred_sales=predict(model4,newdata=testdata)
testdata$pred=pred_sales
testdata

#Mean Absolute Percentage Error
fv=model4$fitted.values#fitted values
fv
av=traindata$ElantraSales#actual values
av
avt=testdata$ElantraSales
install.packages(MLmetrics)
library(MLmetrics)
MAPE(fv,av)
MAPE(fv,avt)

SSE=sum((testdata$ElantraSales-testdata$pred)^2)
SSE

summary(abs(pred_sales-testdata$ElantraSales))

testdata[which.max(abs(pred_sales-testdata$ElantraSales)),]


library(car)
as.data.frame(vif(model4))              
              
#model4=lm(ElantraSales~Month+Unemployment+CPI_all ,data=traindata)
#summary(model4)
