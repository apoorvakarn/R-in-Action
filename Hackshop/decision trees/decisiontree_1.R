train1= data.frame(rollno= c(1,2,3),gender = c("M","M","F"), play = c("play","no play","play"))
train1
library(rpart) # R partioning
mytree1 = rpart(play ~ gender, data = train1, method = "class")
mytree1
train2= data.frame(rollno= c(1,2,3,4),gender = c("M","M","F","F"), play = c("play","No play","play","play"))
train2
mytree2 = rpart(play ~ gender, data = train2, method = "class")
mytree2
rpart(play ~ gender, data= train2, method = "class")
rpart(play ~ gender, data = train2, method = "class", minsplit=1, minbucket=1)
train3= data.frame(rollno= c(1,2,3,4,5,6,7),gender = c("M","M","F","M","M","F","F"), play = c("play","play","play","play","play","noplay","noplay"))
train3
library(rpart)
mytree3 = rpart(play ~ gender, data = train3, method = "class")
mytree3                 
table(train3$gender,train3$play)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(mytree3)
train3$status = c("married","not married","married","married","not married","married","not married")
train3
mytree4= rpart(play ~ gender+married , data = train3, method = "class", minsplit=2, minbucket=1)
mytree4
mytree4b= rpart(play ~ gender+married , data = train3, method = "class", minsplit=2, minbucket=1, cp = -1)
mytree4b
fancyRpartPlot(mytree4b)
mytree4b$where
train3
mytree4c = rpart (play ~ gender,data= train3, method = "class",weights = c(.3,.1,.1,.1,.1,.1,.2))
mytree4c
predict(mytree4b, newdata = data.frame(gender = "M", married="not married"))
printcp(mytree4b)
