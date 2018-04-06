getwd()
setwd("C:/rWork/rProjects/R-in-Action/analytics/clustering_stocks")
(d=read.csv("stock_data.csv",header = TRUE))
str(d)
dim(d)
head(d)
tail(d)
is.na(d)
d$Y=as.factor(d$Y)
d$Y
train=d[1:2000,]
train
test=d[2001:3000,]
test
library(randomForest)
library(Metrics)
model=randomForest(Y~.,d=train)
model
pred=predict(object=model,test[,-101])
pred
table(pred)
#checking accuracy
accuracy(pred,test$Y)
#combining all----
all= cbind(train,test)
all
Cluster=kmeans(all[,-101],5)
Cluster
