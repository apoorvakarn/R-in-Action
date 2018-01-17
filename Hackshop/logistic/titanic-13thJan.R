# Build an analytical model to predict the survival of a passenger in Titanic----
#---------------------Step1: Loading the Data in R----
getwd()
setwd("C:/rWork/rProjects/R-in-Action/Hackshop")
train_titanic<-read.csv("titanic.train.csv", header = TRUE, as.is = TRUE, na.strings = c(""))
test_titanic<- read.csv("titanic.test.csv", header = TRUE, as.is = TRUE, na.strings = c(""))
#------------------Step2: Expolatory Data Analysis----
#Understand the data type and summary of each coloumn----
str(train_titanic)
summary(train_titanic)
#checking the missing values----
as.data.frame(colSums(is.na(train_titanic)))
#Visualy Observing the missing values----
#install.packages("Amelia", dependencies = TRUE)----
install.packages("Amelia")
library(Amelia)
missmap(train_titanic, main = "Missing values vs Observed")
#Selecting for relevant data variables (dropping Cabin (Too many missing values), Passanger Id(Index), 
#Ticket (Index))----
train_titanic_1<-subset(train_titanic, select = -c(Cabin,PassengerId,Ticket, Name))
#imputing the missing values:
#Age(with mean)----
train_titanic_1$Age[is.na(train_titanic_1$Age)]<-mean(train_titanic_1$Age, na.rm = TRUE)
#Imputing the missing values of categorical variables----
str(train_titanic_1$Embarked)
train_titanic_1$Embarked<-as.factor(train_titanic_1$Embarked)
str(train_titanic_1$Sex)
train_titanic_1$Sex<-as.factor(train_titanic_1$Sex)


contrasts(train_titanic_1$Sex)#Contrasts are needed when you fit linear models with factors 
#(i.e. categorical variables) as explanatory variables.
#The contrast specifies how the levels of the factors will be coded into a family of numeric 
#dummy variables for fitting the model.
contrasts(train_titanic_1$Embarked)
#Removing the two missing values of Embarked from the dataset----

train_titanic_1<-train_titanic_1[!is.na(train_titanic_1$Embarked),]
rownames(train_titanic_1)<-NULL
#Subsetting the Data into train and Validation ----
library(caTools)
set.seed(113)
spl = sample.split(train_titanic_1$Survived, 0.85)
train_titanic_t = subset(train_titanic_1, spl == TRUE)
train_titanic_v = subset(train_titanic_1, spl == FALSE)
nrow(train_titanic_t)
nrow(train_titanic_v)
#Building the Predictive Model---- 
#Initial model-1st iteration----
Model1<-glm(Survived~.,family = binomial(link = 'logit'), data = train_titanic_t)
summary(Model1)
model2=glm(Survived~ Pclass+ Sex+ Age+ SibSp+ Fare + Embarked
        ,family = binomial(link = 'logit'), data = train_titanic_t)
summary(model2)
model3=glm(Survived~ Pclass+ Sex+ Age+ SibSp+ I(Embarked =="S")
           ,family = binomial(link = 'logit'), data = train_titanic_t)
summary(model3)
#interpretation of the Model3
model3$coefficients
exp(model3$coefficients)
#Coefficients:
#Estimate Std. Error z value Pr(>|z|)    
(Intercept)             5.451800   0.604445   9.020  < 2e-16 ***
  Pclass                 -1.077844   0.148176  -7.274 3.49e-13 ***
  Sexmale                -2.694993   0.212189 -12.701  < 2e-16 ***
  Age                    -0.045416   0.008493  -5.347 8.93e-08 ***
  SibSp                  -0.376221   0.115066  -3.270  0.00108 ** 
  Fare                    0.001078   0.002283   0.472  0.63665    
I(Embarked == "S")TRUE -0.464453   0.217986  -2.131  0.03312 *  
  ---
  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 1005.73  on 755  degrees of freedom
Residual deviance:  675.05  on 749  degrees of freedom
AIC: 689.05

Number of Fisher Scoring iterations: 5
#z-value is chi square value and significance value means wald test----

#Multicollinearity of independent variables
library(car)
vif(model3)


#Residual vs Null Deviance
anova(model3, test = "Chisq")
#Goodness of Fit of the Model
install.packages(BaylorEdPsych)#compute all R2
library(BaylorEdPsych)

PseudoR2(model3)


#Assessing the predictive power of the model
#Predicted Probabilities
pred_sur=predict(model3,newdata=train_titanic_v,type="response")
pred_sur_n=ifelse(pred_sur>0.5,1,0)


#Building the Confusion Matrix
install.packages("reshape2")
library(caret)
confusionMatrix(pred_sur_n,train_titanic_v$Survived)
train_titanic_1$Survived<-as.factor(train_titanic_1$Survived)



#Building the AUC Curve
library(ROCR)

pr <- prediction(pred_sur, train_titanic_v$Survived)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)#the more above the line..more accurate the model----

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc
