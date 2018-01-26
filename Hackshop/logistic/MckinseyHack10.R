library(caret)
library(caTools)
getwd()
setwd("C:/rWork/rProjects/R-in-Action/Hackshop/logistic")
trn = read.csv('./data/Mckinsey1m/mk.train.csv')
str(trn)
trn$ID = NULL
trn$DOB = NULL
colSums(is.na(trn))
tst = read.csv('./data/Mckinsey1/test.csv')
str(tst)
Ids = tst$ID
tst$ID = NULL 
tst$DOB = NULL
nrow(trn)#69713
nrow(tst)#30037
str(trn)
trn1 = trn[,1:19]
str(trn1)
colSums(is.na(tst))
c1 = rbind(trn1,tst)
nrow(c1)
c1$Employer_Category2 = median(c1$Employer_Category2,na.rm=T)
colSums(is.na(c1))
c1$Existing_EMI = median(c1$Existing_EMI,na.rm=T)
c1$Loan_Amount = median(c1$Loan_Amount,na.rm=T)
c1$Loan_Period = median(c1$Loan_Period,na.rm=T)
c1$Interest_Rate = median(c1$Interest_Rate,na.rm=T)
c1$EMI = median(c1$EMI,na.rm=T)
colSums(is.na(c1))
train = head(c1,69713)
train1 = cbind(train,trn$Approved)
train1$Approved = train1$`trn$Approved`
train1$`trn$Approved` = NULL
str(train1)
test1 = tail(c1,30037)
train1$Lead_Creation_Date = NULL
train1$City_Code = NULL
train1$Employer_Code = NULL
train1$Customer_Existing_Primary_Bank_Code = NULL
fitControl <- trainControl(method = "repeatedcv", number = 4, repeats = 4)
gbmFit1 <- train(Approved ~ ., data = train1, method = "gbm",trControl = fitControl,verbose = T)
test1$Lead_Creation_Date = NULL
test1$City_Code = NULL
test1$Employer_Code = NULL
test1$Customer_Existing_Primary_Bank_Code = NULL
pred <- predict(gbmFit1,test1)
pred[1:5]
pred10 = ifelse(pred>0.02,1,0)
sub10 = data.frame(ID = Ids)
sub10$Approved = pred10
length(sub10$Approved[sub10$Approved==0])
write.csv(sub10,'MckinseyHack10.csv',row.names = F)
