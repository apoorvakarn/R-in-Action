#Assignment - 2
#Forecasting of channel stats of a Youtube channel 
data=read.csv("C:/rWork/rProjects/R-in-Action/analytics/vidooly_analytics/oct_march.csv",stringsAsFactors = FALSE)
str(data)
#Converting date column into date format
data$date=as.Date(data$date,format="%d-%m-%Y")
data$date
#Forecasting views 
omn=as.data.frame(data[,c(5,2)])    
colSums(is.na(data)) #Checking presence of NA values
#We use 'xts' and 'zoo' library for this assignment
library(xts)
library(zoo)
#Converting dataframe into a time-series object for further analysis
channel1 <- xts(omn[,2], order.by=as.Date(omn[,1], "%Y-%m-%d"))
channel1

#Plotting views against time
plot(channel1,ylab='Views',xlab='Date',main="Views between Oct 2016 - Mar 2017",col="grey")
#Differentiating views of order 1 to remove trend
plot(diff(channel1),ylab='Views',xlab='Date',main="Views between Oct 2016 - Mar 2017",col="grey")

library(tseries)
adf.test(channel1,alternative="stationary")
#p-value less than 0.05, null hypothesis rejected
#data is stationary

#Detrending the data
ch2=diff(channel1)
par(mfrow=c(1,2))
ch2 = as.data.frame(ch2)
ch2$V1[is.na(ch2$V1)]=0
ch2=as.xts(ch2)
class(ch2)
channel1
ch2

#To obtain values of p,d,q(d=1 already obtained)
acf(ch2,main="ACF plot")#ACF PLOT -- Moving Average or q
pacf(ch2,main="PACF plot")#PACF PLOT -- Auto Regressive or p

#Fitting ARIMA model on detrended data
ARIMAFit=arima(channel1,c(0,1,1))
summary(ARIMAFit)

#Forecasting values of next 3 months(91 days)
pred=predict(ARIMAFit, n.ahead=91)
str(pred)
pred2 = pred$pred+2*pred$se
pred2=round(pred2,0)
pred2 #Final forecast of views for Apr 01-Jun 30 2017

#Forecasting subscribers
omn2=as.data.frame(data[,c(5,3)])
omn2

colSums(is.na(data)) #Checking NA values
library(xts)
library(zoo)
#Converting dataframe to time-series object
channel2 <- xts(omn2[,2], order.by=as.Date(omn2[,1], "%Y-%m-%d"))
channel2

#Plotting subscribers against time
plot(channel2,ylab='Subscribers',xlab='Date',main="Views between Oct 2016 - Mar 2017",col="grey")
#Removing trend
plot(diff(channel2,differences = 1),ylab='Views',xlab='Date',main="Views between Oct 2016 - Mar 2017",col="grey")


library(tseries)
adf.test(channel2,alternative="stationary")
#p-value greater than 0.05, hence we fail to reject null hypothesis 
#Data is non-stationary

#Detrending data
ch3=diff(channel2)
ch3
ch3 = as.data.frame(ch3)
ch3$V1[is.na(ch3$V1)]=0
ch3=as.xts(ch3)
ch3

adf.test(ch3,alternative="stationary")
#p-value < 0.05, null hypothesis rejected
#Data is stationary

#To obtain p and q(d=1 already obtained)
acf(ch3,main="ACF plot")#ACF PLOT -- Moving Average or q
pacf(ch3,main="PACF plot")#PACF PLOT -- Auto Regressive or p

#Fitting ARIMA model on channel2
ARIMAFit2=arima(channel2,c(0,1,1))
summary(ARIMAFit2)

#Forecasting values for Apr-Jun 2017
pred3=predict(ARIMAFit2, n.ahead=91)
str(pred3)
pred4 = pred3$pred+2*pred3$se
pred4=round(pred4,0)
pred4 #Final forecast of subscribers for Apr 01-Jun 30 2017

#Forecasting videoscount 
omn3=as.data.frame(data[,c(5,4)])
omn3
nrow(omn3)
library(xts)
library(zoo)
#Converting dataframe into time-series object for further analysis
channel3 <- xts(omn3[,2], order.by=as.Date(omn3[,1], "%Y-%m-%d"))
channel3

#Plotting videoscount against time and checking for trend
plot(channel3,ylab='Videocount',xlab='Date',main="Videocount between Oct 2016 - Mar 2017",col="grey")
plot(diff((channel3),differences = 1),col="grey")


library(tseries)
adf.test(channel3,alternative="stationary")
#p-value greater than 0.05, hence we fail to reject null hypothesis
#Data is non-stationary

#Detrending data
ch4=diff(channel3)
ch4
ch4 = as.data.frame(ch4)
ch4$V1[is.na(ch4$V1)]=0
ch4=as.xts(ch4)
ch4

adf.test(ch4,alternative="stationary")
#p-value < 0.05, null hypothesis is rejected
#Data is stationary

#Obtaining p and q(d=1 already obtained)
acf(ch4,main="ACF plot")#ACF PLOT -- Moving Average or q
pacf(ch4,main="PACF plot")#PACF PLOT -- Auto Regressive or p

#Fitting ARIMA model
ARIMAFit3=arima((channel3),c(0,1,1))
summary(ARIMAFit3)

#Forecasting videoscount for Apr-Jun 2017
pred5=predict(ARIMAFit3, n.ahead=91)
str(pred5)
pred6 = (pred5$pred+2*pred5$se)
pred6=round(pred6,0)
pred6#Final forecast of videoscount for Apr 01 - Jun 30 2017

