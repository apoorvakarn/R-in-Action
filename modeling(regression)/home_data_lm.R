library('ggplot2') # visualization
library('ggthemes') # visualization
library('scales') # visualization
library('dplyr') # data manipulation
library('caTools') # Spliting data
library('rms') # For step wise regression
install.packages("ggthemes")
install.packages("rms")
# Set Working Directory
getwd()
setwd("C:/rWork/rProjects/R-in-Action/modeling(regression)")
# Read Data
dataset <- read.csv("home_data.csv",stringsAsFactors = F,na = "")
# First few entries of the data

library(dplyr)
#data_home = dataset %>%
  #mutate(locality=ifelse(substr(zipcode,1,3)==981,"Seattle vicinity","Seattle Main"))

(data_home$zipcode = as.factor(data_home$zipcode))
avg_price <- aggregate(data_home$price,list(data_home$zipcode),FUN=mean)
str(avg_price)
filter(avg_price,x==max(x))
(filter(data_home,sqft_living>2000 & sqft_living<=4000))
nrow(filter(data_home,sqft_living>2000 & sqft_living<=4000))/nrow(data_home)
library(caTools)
set.seed(1234)
split= sample.split(data_home$price,SplitRatio = 0.80)
training_set= subset(data_home, split == TRUE,select = -c(id,date))
test_set= subset(data_home, split == FALSE,select = -c(id,date))
length(training_set[,1])
length(test_set[,1])
my_features = c('bedrooms', 'bathrooms', 'sqft_living', 'sqft_lot', 'floors', 'zipcode')
summary(data_home[,my_features])
model1= lm(price~bedrooms +bathrooms+sqft_living+sqft_lot+floors+zipcode,data = training_set)
model1
summary(model1)# problem

residuals(model1)

pred=predict(model1,test_set[,my_features])
pred
(rmsepred=sqrt((sum(pred-test_set$price)^2)/length(test_set$id)))
advanced_features = c('bedrooms', 'bathrooms', 'sqft_living', 'sqft_lot', 'floors', 'zipcode','condition','grade','waterfront','view','sqft_above', 'sqft_basement','yr_built', 'yr_renovated', 'lat','sqft_living15', 'sqft_lot15' )
summary(data_home[,advanced_features])
model2= lm(price~bedrooms+bathrooms+sqft_living+sqft_lot+floors+zipcode+condition+grade+waterfront+view+sqft_above+sqft_basement+yr_built+yr_renovated+lat+sqft_living15+sqft_lot15,data = test_set)
model2
summary(model2)
residuals(model2)
RMSE1=sqrt(sum(residuals(model2)^2 / length(training_set$id)))
RMSE1
pred1=predict(model2,test_set[,advanced_features])
pred1
rmsepred1=sqrt(sum((pred1-test_set$price)^2)/length(test_set$id))
rmsepred1
(y=(sum(pred1-test_set$price)))
house1=data_home[which(data_home$id == "9297300055"),]
house1
house1$price
predict(model2,house1)
house2=data_home[which(data_home$id == "5309101200"),]

house2
house2$price
predict(model2,house2)
plot(model2)

house= data_home[which(data_home$id == "5309101200"),]
house
house$price
predict(model1,house)
predict(model2,house)
  
step(model2,direction="backward")
library(rms)
model=fastbw(ols(formula=price ~ bedrooms + bathrooms + sqft_living + sqft_lot
                 +floors + zipcode + condition +grade + waterfront + view + 
                   sqft_above + sqft_basement + yr_built + yr_renovated +
                   lat + sqft_living15 +sqft_lot15,data = training_set),rule="P")

model
model3=fastbw(model2,rule="P")








