#SGN

##############################################################################################
###### Build an analytical model to predict the Loan Repayment by a Borrower   ###############
##############################################################################################

#---------------------Step1: Loading the Data in R
Path<-setwd("C:/Ganesha_Accenture/Ganesha_IVY/R/20180112-20180114 Ivy Data Science Hackshop/02 LOGISTIC REGRESSION/CASE STUDY2/02DATA")
loans<-read.csv("loans.csv", header = TRUE)

#------------------Step2: Expolatory Data Analysis
#Understand the data type of each coloumn
str(loans)
summary(loans)
table(loans$not.fully.paid)

#Checking missing values
as.data.frame(colSums(is.na(loans)))
library(Amelia)
missmap(loans, main = "Missing values vs Observed")

#Treating the missing values using the MICE Package
#install.packages("MICE", dependencies = TRUE)
library(mice)
set.seed(144)
vars.for.imputation = setdiff(names(loans), "not.fully.paid")
imputed = complete(mice(loans[vars.for.imputation]))
loans[vars.for.imputation] = imputed
as.data.frame(colSums(is.na(loans)))



#########################################################################################
##############Subsetting the Data into train and test data  #############################
#########################################################################################
library(caTools)
set.seed(144)
spl = sample.split(loans$not.fully.paid, 0.70)
loans_train = subset(loans, spl == TRUE)
loans_test = subset(loans, spl == FALSE)
nrow(loans_train)
nrow(loans_test)




#########################################################################################
##############          Building the Predictive Model       #############################
#########################################################################################


#Inital Model- 1st Iteration 
Model1<-glm(not.fully.paid~.,family = binomial(link = 'logit'), data = loans_train)
summary(Model1)


#- 2nd Iteration 
Model2<-glm(not.fully.paid~ credit.policy + purpose + installment + log.annual.inc + fico
            + revol.bal + revol.util + inq.last.6mths + delinq.2yrs + pub.rec,
            family = binomial(link = 'logit'), data = loans_train)
summary(Model2)


#- 3rd Iteration 
Model3<-glm(not.fully.paid~ credit.policy + I(purpose == "debt_consolidation") +
              I(purpose == "credit_card") + I(purpose == "all_other") + 
              I(purpose == "major_purchase") + I(purpose == "educational") +
            + installment + log.annual.inc + fico
            + revol.bal + revol.util + inq.last.6mths + delinq.2yrs + pub.rec,
            family = binomial(link = 'logit'), data = loans_train)
summary(Model3)


#- 4th Iteration 
Model4<-glm(not.fully.paid~ credit.policy + I(purpose == "debt_consolidation") +
              I(purpose == "credit_card") + I(purpose == "all_other") + 
              I(purpose == "major_purchase")
              + installment + log.annual.inc + fico
            + revol.bal + revol.util + inq.last.6mths  + pub.rec,
            family = binomial(link = 'logit'), data = loans_train)
summary(Model4)

####################################################################################
#################     Diagonstic Checking       #################################### 
####################################################################################


#Multicollinearity of independent variables
library(car)
vif(Model4)


#Residual vs Null Deviance
anova(Model4, test = "Chisq")

#Goodness of Fit of the Model
#install.packages(BaylorEdPsych)
library(BaylorEdPsych)

PseudoR2(Model4)

#Assessing the predictive power of the model
#Predicted Probabilities
pred_loan=predict(Model4,newdata=loans_test,type="response")
pred_loan_n=ifelse(pred_loan>0.5,1,0)


#Building the Confusion Matrix
library(caret)
confusionMatrix(pred_loan_n,loans_test$not.fully.paid)


#Building the AUC Curve
library(ROCR)

pr <- prediction(pred_loan, loans_test$not.fully.paid)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc


