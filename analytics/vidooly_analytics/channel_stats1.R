library(tseries)
library(forecast)
library(dplyr)
library(xts)
tsdata = read.csv('./data/oct_march.csv', header = T, na.strings = c(""),stringsAsFactors = F)
str(tsdata)
tsdata$date = as.Date(tsdata$date)
tsdata$views = as.integer(tsdata$views)
str(tsdata)
summary(tsdata)
dim(tsdata)
aggregate(tsdata$chid, by=list(tsdata$chid), FUN=NROW)
table(tsdata$chid)
# for each Channel Predict Views for next 3 months
channel1 = tsdata$chid[1]
# subset data
names(tsdata)
tsdata.subset = subset(tsdata, chid == channel1, select = c(views, subscriber, videoscount, date))
tsdata.subset
names(tsdata.subset)
# Subscriber
subscriber = xts(tsdata.subset[,2], order.by=tsdata.subset$date)
str(subscriber)
head(subscriber)
plot(subscriber)
fit1a = auto.arima(subscriber)
fit1a
forecast(fit1a, 90)
accuracy(fit1a)
# Views
head(tsdata.subset)
views = xts(tsdata.subset[,1], order.by=tsdata.subset$date)
head(views)
fit2a = auto.arima(views)
fit2a
forecast(fit2a, 90)
accuracy(fit2a)
## Videos Cpimt
head(tsdata.subset)
videocount = xts(tsdata.subset[,3], order.by=tsdata.subset$date)
head(videocount)
fit3a = auto.arima(videocount)
fit3a
forecast(fit3a, 90)
accuracy(fit3a)
finalresult = data.frame(fit1a = subscriber,fit2a = views,fit3a = videocount, check.rows = F)
summary(finalresult)
write.csv(finalresult,file = "Channel_Stats_pred.csv",row.names = F)
data = read.csv('./Channel_Stats_pred.csv', header = T,stringsAsFactors = F)
finalresult2 = data.frame(Chid = "UC6ROKPXrnzfhNYST1w",Subscriber = data$fit1a, Views = data$fit2a, VideosCount = data$fit3a, Date = seq(from = as.Date("2017-04-01"), to = as.Date("2017-06-30"), by = 'day'),check.rows = F)
write.csv(finalresult2, file = "Channel_Stats_predictions.csv", row.names = F)
