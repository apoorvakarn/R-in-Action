#SGN
#-----------------------------------Decision Trees in R------------------------------#



#Problem Statement: To use census information about an individual to predict how much a person earns -- in particular, 
#whether the person earns more than $50,000. 


#Methodology to be used: CART and Random Forests




#------------------------------Preparing the environment for Decision Trees---------------------------------------#


list.of.packages <- c("caret", "e1071","ggplot2","rpart", "rpart.plot","pROC","ROCR","randomForest","caTools")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]

if(length(new.packages)) install.packages(new.packages, repos="http://cran.rstudio.com/")

library(caret)
library(ggplot2)
library(rpart.plot)
library(pROC)
library(ROCR)
library(rpart)
library(randomForest)
library(caTools)
library(e1071)



#-------------------------Setting the working directory and Reading the dataset--------------------------------------------#

Path<-"C:/Ganesha_Accenture/Ganesha_IVY/R/20180112-20180114 Ivy Data Science Hackshop/04 DECISION TREES/CASE STUDY1/02DATA"
setwd(Path)
getwd()

census=read.csv("census.csv")
head(census)

#-----------------------Basic Exploration of the Data Set----------------------------------------------------------#

dim(census)
str(census)

summary(census)
sapply(census, function(x) sum(is.na(x)))
census$over50k<-as.factor(census$over50k)

#-----------------
#Dependent Variable
#over50k = whether or not the individual earned more than $50,000 in 1994

#------------------
#Independent Variables
#age = the age of the individual in years
#workclass = the classification of the individual's working status (does the person work for the federal government, work for the local government, work without pay, and so on)
#education = the level of education of the individual (e.g., 5th-6th grade, high school graduate, PhD, so on)
#maritalstatus = the marital status of the individual
#occupation = the type of work the individual does (e.g., administrative/clerical work, farming/fishing, sales and so on)
#relationship = relationship of individual to his/her household
#race = the individual's race
#sex = the individual's sex
#capitalgain = the capital gains of the individual in 1994 (from selling an asset such as a stock or bond for more than the original purchase price)
#capitalloss = the capital losses of the individual in 1994 (from selling an asset such as a stock or bond for less than the original purchase price)
#hoursperweek = the number of hours the individual works per week
#nativecountry = the native country of the individual



#------------------------------Splitting the dataset into train and test data-----------------------#


set.seed(3000)
spl = sample.split(census$over50k, SplitRatio = 0.6)
Train = subset(census, spl==TRUE)
dim(Train)
str(Train)

Test = subset(census, spl==FALSE)
dim(Test)
str(Test)



#-------------------------------------------Building the CART model----------------------------------------------#

CART1<-rpart(over50k~.,data=Train, method = "class")
prp(CART1)
CART1



#-------------------------Checking the accuracy of the model in the test data------------------------------#
predictCART1<-predict(CART1, newdata=Test, type = "class")
table(Test$over50k,predictCART1)
(9117+1676)/(1402+1676+596+9117)

#ConfusionMatrix
confusionMatrix(predictCART1,Test$over50k)

#----------------Reciever Operating Characterstics Curve for CART------------------------------------------#

predictCART2<-predict(CART1, newdata=Test)#To predict the probabilities for the observations in the test data set


CARTroc<-roc(response=Test$over50k, predictor = predictCART2[,2],
             level = rev(levels(Test$over50k)))
CARTroc
plot(CARTroc)
# Area under the curve is 0.84


1402+1676
832+2246


#---------------------------End of the CART model---------------------------------------------------------#



#------------------------------------A Random Forest Model-------------------------------------------------#

#Reducing the train data sample size, to limit the train data set to contain randomly chosen 2000 data points


set.seed(3000)
spl = sample.split(census$over50k, SplitRatio = 0.6)
Train_1 = subset(census, spl==TRUE)
dim(Train_1)
str(Train_1)
Train_1$over50k<-NULL

Test_1 = subset(census, spl==FALSE)
dim(Test)
str(Test)
Test_1$over50k<-NULL


PredictForest1<-randomForest(over50k~.,data = Train_1)
PredictForest1
nrow(Test)


#--------------------Checking the accuracy of the model-------------------------------------------#
predForest1<-predict(PredictForest1, newdata=Test_1, type = "class")
table(Test_1$over50k_RF,predForest1)
nrow(trainsmall)


#ConfusionMatrix
confusionMatrix(predForest1,Test_1$over50k)


#---------------------------Variable Importance chart in Random Forest---------------------------------------#
vu = varUsed(PredictForest1, count=TRUE)
vusorted = sort(vu, decreasing = FALSE, index.return = TRUE)
dotchart(vusorted$x, names(PredictForest1$forest$xlevels[vusorted$ix]), main = "Variable Importance Chart_Splitting")

#Interpretation: Here, 'Age' variable is most important in terms of number of splits

#each variable measures the number of times that variable was selected for splitting (the value on the x-axis)

#--------------------Measuring Impurity in the Random Forest Model-----------------------------------------#

#A different metric we can look at is related to "impurity", which measures how homogenous each bucket or leaf of the tree is. 
#In each tree in the forest, whenever we select a variable and perform a split, the impurity is decreased. 
#Therefore, one way to measure the importance of a variable is to average the reduction in impurity, 
#taken over all the times that variable is selected for splitting in all of the trees in the forest. 
varImpPlot(PredictForest1, main = "Variable Importance Chart_Impurity Red")

#Interpretation: Here, 'Capitalgain' variable is most important in terms of mean reduction in impurity
