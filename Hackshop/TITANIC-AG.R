#SGN
rm(list = ls())

##############################################################################################
###### Build an analytical model to predict the survival of a passenger in Titanic ###########
##############################################################################################

#---------------------Step1: Loading the Data in R
Path<-setwd("C:/Ganesha_Accenture/Ganesha_IVY/R/20180112-20180114 Ivy Data Science Hackshop/02 LOGISTIC REGRESSION/CASE STUDY1/02DATA")
train_titanic<-read.csv("train.csv", header = TRUE, as.is = TRUE, na.strings = c(""))
test_titanic<- read.csv("test.csv", header = TRUE, as.is = TRUE, na.strings = c(""))

#------------------Step2: Expolatory Data Analysis
#Understand the data type and summary of each coloumn
str(train_titanic)
summary(train_titanic)

#Checking missing values
as.data.frame(colSums(is.na(train_titanic)))


#Visualy Observing the missing values
#install.packages("Amelia", dependencies = TRUE)
library(Amelia)
missmap(train_titanic, main = "Missing values vs Observed")


#Selecting for relevant data variables (dropping Cabin (Too many missing values), Passanger Id(Index), 
                                        #Ticket (Index))

train_titanic_1<-subset(train_titanic, select = -c(Cabin,PassengerId,Ticket, Name))



#Imputing the missing values:
#Age (with mean)
train_titanic_1$Age[is.na(train_titanic_1$Age)]<-mean(train_titanic_1$Age, na.rm = TRUE)


#Imputing the missing values of categorical variables
str(train_titanic_1$Embarked)
train_titanic_1$Embarked<-as.factor(train_titanic_1$Embarked)
str(train_titanic_1$Sex)
train_titanic_1$Sex<-as.factor(train_titanic_1$Sex)


contrasts(train_titanic_1$Sex)
contrasts(train_titanic_1$Embarked)

#Removing the two missing values of Embarked from the dataset

train_titanic_1<-train_titanic_1[!is.na(train_titanic_1$Embarked),]
rownames(train_titanic_1)<-NULL


#########################################################################################
##############Subsetting the Data into train and Validation #############################
#########################################################################################
library(caTools)
set.seed(113)
spl = sample.split(train_titanic_1$Survived, 0.85)
train_titanic_t = subset(train_titanic_1, spl == TRUE)
train_titanic_v = subset(train_titanic_1, spl == FALSE)
nrow(train_titanic_t)
nrow(train_titanic_v)






#########################################################################################
##############          Building the Predictive Model       #############################
#########################################################################################


#Inital Model- 1st Iteration 
Model1<-glm(Survived~.,family = binomial(link = 'logit'), data = train_titanic_t)


#Printing the results of the Model
summary(Model1)

#2nd Iteration 
Model2<-glm(Survived~ Pclass+ Sex+ Age+ SibSp+ Fare + Embarked
              ,family = binomial(link = 'logit'), data = train_titanic_t)


#Printing the results of the Model
summary(Model2)

#3rd Iteration 
Model3<-glm(Survived~ Pclass+ Sex+ Age+ SibSp+ Embarked
            ,family = binomial(link = 'logit'), data = train_titanic_t)


#Printing the results of the Model
summary(Model3)

####################################################################################
#################     Diagonstic Checking       #################################### 
####################################################################################


#Multicollinearity of independent variables
library(car)
vif(Model3)


#Residual vs Null Deviance
anova(Model3, test = "Chisq")


#Goodness of Fit of the Model
#install.packages(BaylorEdPsych)
library(BaylorEdPsych)

PseudoR2(Model3)


#Assessing the predictive power of the model
#Predicted Probabilities
pred_sur=predict(Model3,newdata=train_titanic_v,type="response")
pred_sur_n=ifelse(pred_sur>0.5,1,0)


#Building the Confusion Matrix
library(caret)
confusionMatrix(pred_sur_n,train_titanic_v$Survived)
train_titanic_1$Survived<-as.factor(train_titanic_1$Survived)



#Building the AUC Curve
library(ROCR)

pr <- prediction(pred_sur, train_titanic_v$Survived)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc

#######################End of Model##################################################