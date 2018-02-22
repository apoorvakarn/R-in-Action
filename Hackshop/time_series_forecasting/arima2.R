list.of.packages <- c("forecast", "ggplot2","MASS","caTools","sqldf","tseries")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages, repos="http://cran.rstudio.com/")
library(forecast)
library(tseries)
getwd()
setwd("C:/rWork/rProjects/R-in-Action/Hackshop/time_series_forecasting")
data=read.csv("1sales.csv",header = TRUE)
data
head(data)
dim(data)
str(data)
summary(TSdata)
colSums(is.na(data))
names(data)[c(1:2)]=c("Date","Sales")
data=ts(data[,2],start=c(2003,1),frequency=12)
start(data)
end(data)
frequency(data)
StructTS(data)
data
class(data)
str(data)
plot(data,ylab="Sales", xlab="Year",main="Sales between 2003-2017",col="orange")
abline(reg = lm(data~time(data)))#time(tsdata) means point of time data
cycle(data)
plot(aggregate(data,FUN=mean))
plot(log10(TSdata),ylab="log(Sales)",xlab="Year",main="log(Sales) between 2003-2017",col="orange")
plot(diff(data,differences = 1),ylab="Diff(Sales)",xlab="Year",main="Diff(Sales) between 2003-2017",col="green")
plot(diff(log10(data),differences = 1),ylab="Diff(Sales)",xlab="Year",main="Diff(Log(Sales)) between 2003-2017",col="brown")
LDTSdata=diff(log10(data),differences = 1)
require(forecast)
adf.test(LDTSdata,alternative="stationary")
kpss.test(LDTSdata)
par(mfrow=c(1,2))
acf(diff(log10(data)),main="ACF plot",col ="red")#ACF PLOT -- Moving Average or q
pacf(diff(log10(data)),main="PACF plot",col="brown")#PACF PLOT -- Auto Regressive or p
ARIMAFit=arima((log10(data)),c(1,1,0))#c(1,1,0)means order of ARIMA(AR[p],I[d],MA[q])
summary(ARIMAFit)
require(forecast)
ARIMAFit1=auto.arima(log10(data),approximation=TRUE,trace=TRUE)
?auto.arima
?arima
summary(ARIMAFit1)
ARIMAFit1$residuals
pred=predict(ARIMAFit1,n.ahead=36)#for 36 months , frequency is 12
pred
par(mfrow=c(1,1))
plot(data,type="l",xlim=c(2004,2018),ylim=c(1,1600),xlab="Year",ylab="Sales",col="green")
lines(10^(pred$pred),col="red")#original time series + predicted time series
plot(data,type="l",xlim=c(2004,2018),ylim=c(1,1600),xlab = "Year",ylab = "Sales")
lines(10^(pred$pred),col="red")
lines(10^(pred$pred+2*pred$se),col="blue")#se-- standard error
lines(10^(pred$pred-2*pred$se),col="black")#blue black means confidence interval of my predicted value
## then forecast the result
pred = predict(ARIMAFit1, n.ahead = 36)
write.csv(pred,"predict.csv")

## then do the exponential since you had used log earlier.
normal_result=10^pred$pred ## you get the desired result. 
write.csv(normal_result,"finalpredict.csv", row.names = FALSE)
plot(normal_result)
