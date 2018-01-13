#SGN

###############################################################################################
c
###############################################################################################




#---------------------Step1: Loading the Data in R
Path<-setwd("C:/Ganesha_Accenture/Ganesha_IVY/R/20180112-20180114 Ivy Data Science Hackshop/01 MULTIVARIATE LINEAR REGRESSION/CASE STUDY1/02DATA")
statedata<-read.csv("statedata.csv", stringsAsFactors = FALSE, header = TRUE, as.is = TRUE)



#------------------Step2: Expolatory Data Analysis
#Understand the statedata type of each coloumn
str(statedata)


#Univariate Data Analysis 
#Subsetting the statedata into continuous and categorical variables

statedata_ctn<-subset(statedata, select = c(Population,Income,Illiteracy,Life.Exp,Murder,HS.Grad,Frost,Area,state.area,x,y))
statedata_cat<-subset(statedata, select = -c(Population,Income,Illiteracy,Life.Exp,Murder,HS.Grad,Frost,Area))

#Quick Summary of all variables

#Continuous Variables
#install.packages("pastecs", dependencies = TRUE)
library(pastecs)
options(scipen = 100)
options(digits = 2)
stat.desc(statedata_ctn)


#Categorical Variables
as.matrix(sort(table(statedata_cat$state.division), decreasing = TRUE))
as.matrix(sort(table(statedata_cat$state.name), decreasing = TRUE))
as.matrix(sort(table(statedata_cat$state.region), decreasing = TRUE))


#Data Visualisation
plot(statedata$x,statedata$y, xlab = "longtitude of centres", ylab = "latitude of centres", main = "PLOT OF STATE CENTRES")


# About Highest Median High School Graduation Rate

boxplot(statedata$HS.Grad ~ statedata$state.region, xlab = "Region of USA", ylab = "High School Graduation Rate", main = "Distribution of High School Graduation Rate")



#########################################################################################
##############          Building the Predictive Model       #############################
#########################################################################################



#Inital Model- 1st Iteration 
#Converting Character into Factor Variables
statedata$state.region<-as.factor(statedata$state.region)
statedata$state.division<-as.factor(statedata$state.division)
statedata$state.name<-as.factor(statedata$state.name)



Model1<-lm(Life.Exp~ Population + Income + Illiteracy + Murder + HS.Grad + 
                     Frost + Area + x + y + state.division +  + state.region,
                     data = statedata)

#Printing the results of the Model
summary(Model1)


#2nd Iteration
Model2<-lm(Life.Exp~ Population + Income + Illiteracy + Murder + HS.Grad + 
             Frost + Area,
           data = statedata)

summary(Model2)

#Further Data Exploration (for Income)
plot(statedata$Life.Exp, statedata$Income)

#Checking Multicollinearity
library(car)
as.data.frame(vif(Model2))


#3rd Iteration
Model3<-lm(Life.Exp~ Population + Income + Murder + HS.Grad + 
             Frost + Area,
           data = statedata)

summary(Model3)





#4th Iteration
Model4<-lm(Life.Exp~ Population + Income + Murder + HS.Grad + 
             Frost ,
           data = statedata)

summary(Model4)
as.data.frame(vif(Model4))

#5th Iteration
Model5<-lm(Life.Exp~ Population +  Murder + HS.Grad + 
             Frost,
           data = statedata)

summary(Model5)
as.data.frame(vif(Model5))

#Predicting Life_Expectancy from the Model
Pred_Life<-predict(Model5)
statedata$Pred_Life<-Pred_Life


write.csv(statedata, "statedata_pred.csv", row.names = FALSE)
#Plot Actual vs Predicted
#install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)
ggplot(data = statedata, aes(x=x, y=val)) + geom_line(aes(colour=variable))