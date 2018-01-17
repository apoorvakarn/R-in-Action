getwd()
setwd("C:/rWork/rProjects/R-in-Action/Hackshop/multivariate_LR")
elantradata=read.csv('elantra.csv',stringsAsFactors = FALSE, header = TRUE,as.is = TRUE)
elantradata
str(elantradata)
summary(elantradata)
#split the data into test nd train data 
train_data= subset(elantradata, elantradata$Year<=2012)
train_data
test_data=subset(elantradata,elantradata$Year>2012)
test_data
#no of observations in each data
nrow(train_data)
nrow(test_data)
#applying liear regression
lmElantra = lm(ElantraSales ~ Unemployment + CPI_all + CPI_energy + Queries, data=train_data)
summary(lmElantra)
lmElantra1 = lm(ElantraSales ~ Month + Unemployment + CPI_all + CPI_energy + Queries, data=train_data)
summary(lmElantra1)
train$Month = as.factor(train$Month)
lmElantra2 = lm(ElantraSales ~ Month + Unemployment + CPI_all + CPI_energy , data=train_data )
summary(lmElantra2)
test_data$Month = as.factor(test_data$Month)
salesPrediction = predict(lmElantra2, newdata=test)
SSE = sum((salesPrediction - test$ElantraSales)^2)
SSE
baselineSales = mean(train$ElantraSales)
SST = sum((baselineSales - test$ElantraSales)^2)
R2 = 1 - SSE/SST
R2
max(abs(salesPrediction - test$ElantraSales))
which.max(abs(salesPrediction - test$ElantraSales))
install.packages("stargazer")
library(stargazer)
stargazer(lmElantra,lmElantra1,lmElantra2,type = "text",out = "elmodel.txt")
