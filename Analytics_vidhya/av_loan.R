library('ggplot2') # visualization
library('ggthemes') # visualization
library('scales') # visualization
library('dplyr') # data manipulation
library('caTools') # Spliting data
library('rms') # For step wise regression
install.packages("ggthemes")
install.packages("rms")
getwd()
setwd("C:/rWork/rProjects/R-in-Action/Analytics_vidhya")
loan_data=read.csv("train_loan.csv",stringsAsFactors = FALSE,header = TRUE)
loan_data
loan_test=read.csv("test_loan.csv",stringsAsFactors =  FALSE,header = TRUE)
loan_test
str(loan_data)
summary(loan_data)
head(loan_data)
colSums(is.na(loan_data))
barplot(table(loan_data$Loan_Status))#loan_status is a target variable
prop.table(table(loan_data$Loan_Status))
par(mfrow=c(1,2))
#gender factor has 3 levels in both train and test data set
barplot(table(loan_data$Gender),main="train set")
barplot(table(loan_test$Gender),main="test set")
loan_data$Gender
prop.table(table(loan_data$Gender))
prop.table(table(loan_test$Gender))
#married factor has 3 levels in train data set and 2 levels in test data set
par(mfrow=c(1,2))
barplot(table(loan_data$Married),main="train set")
barplot(table(loan_test$Married),main="test set")
prop.table(table(loan_data$Married))
prop.table(table(loan_test$Married))
#dependent factor with 4 levels
par(mfrow=c(1,2))
levels(loan_data$Dependents)
barplot(table(loan_data$Dependents),main="train set")
barplot(table(loan_test$Dependents),main="test set")
prop.table(table(loan_data$Dependents))
prop.table(table(loan_test$Dependents))
#education is a factor with 2 levels. There are no missing values.
par(mfrow=c(1,2))
levels(loan_data$Education)
barplot(table(loan_data$Education),main="train set")
barplot(table(loan_test$Education),main="test set")
prop.table(table(loan_data$Education))
prop.table(table(loan_test$Education))
#Self-Employed factor with two levels. Has missing values in both sets.
par(mfrow=c(1,2))
levels(loan_data$Self_Employed)
barplot(table(loan_data$Self_Employed),main="train set")
barplot(table(loan_test$Self_Employed),main="test set")
prop.table(table(loan_data$Self_Employed))
prop.table(table(loan_test$Self_Employed))
#Applicant Income and CoApplicant Income. Both numeric variables. No na’s.
par(mfrow=c(1,2))
boxplot(loan_data$ApplicantIncome,train$CoapplicantIncome,names=c("App Income","Coapp Income"),main="train set")
boxplot(loan_test$ApplicantIncome,test$CoapplicantIncome,names=c("App Income","Coapp Income"),main="test set")
#Loan Amount,numeric. Has na’s in both sets.
par(mfrow=c(1,2))
boxplot(loan_data$LoanAmount,main="train set")
boxplot(loan_test$LoanAmount,main="test set")
#Loan amount term - numeric. Both sets have na’s.
par(mfrow=c(1,2))
hist(loan_data$Loan_Amount_Term,breaks=500,main="train set")
hist(loan_test$Loan_Amount_Term,breaks=500,main="test set")
summary(loan_data$Loan_Amount_Term)#summary of train data
summary(loan_test$Loan_Amount_Term)#summary of test data
#Credit History - integer. This should actually be a factor variable. Both sets have na’s.
par(mfrow=c(1,2))
loan_data$Credit_History <-as.factor(loan_data$Credit_History)
loan_test$Credit_History <- as.factor(loan_test$Credit_History)
barplot(table(loan_data$Credit_History),main="train set")
barplot(table(loan_test$Credit_History),main="test set")
prop.table(table(loan_data$Credit_History))
prop.table(table(loan_test$Credit_History))
#property Area - factor with three levels. No missing values.
par(mfrow=c(1,2))
barplot(table(loan_data$Property_Area),main="train set")
barplot(table(loan_test$Property_Area),main="test set")
prop.table(table(loan_data$Property_Area))
prop.table(table(loan_test$Property_Area))
#Loan_Status by other variables
install.packages("ggplot2")
library(ggplot2)
print(ggplot2(loan_data, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Gender)+ggtitle("Loan Status by Gender of Applicant"))
print(ggplot(train, aes(x=Loan_Status))+geom_bar()+facet_grid(.~Married)+ggtitle("Loan Status by Marital Status of Applicant"))
alldata<-rbind(train[,2:12],test[,2:12])
