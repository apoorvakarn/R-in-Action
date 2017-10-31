# Multiple Linear Regression
# Importing the dataset
dataset = read.csv('50_Startups.csv')

# Encoding categorical data
dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)
View(training_set)
View(test_set)
# Fitting Multiple Linear Regression to the Training set
regressor = lm(formula = Profit ~ .,
               data = training_set)
regressor
summary(regressor)
# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)
test_set$Profit_Pred = y_pred
test_set
#Prediction Error
test_set$Pred_error = test_set$Profit - test_set$Profit_Pred

#Mean Absolute deviation
MAD = mean(abs(test_set$Pred_error))
MAD

#Mean Square Error
MSE = mean(test_set$Pred_error^2)
MSE

#Root Mean Sqaure Error
RMSE = sqrt(mean(test_set$Pred_error^2))
RMSE

Pred_Err = function(test_data,prediction_model)
{
  pred = predict(prediction_model,newdata=test_data)
  RMSE = sqrt(mean((test_data$Profit-pred)^2))
  MAD = mean(abs(test_data$Profit-pred))
  return(c(RMSE,MAD)) 
}

Pred_Err(test_set,regressor)

#Building the optimal model using Backward Elimination
regressor = lm(formula = Profit ~ R.D.Spend+Administration+Marketing.Spend+State,
               data = dataset)
summary(regressor)

regressor = lm(formula = Profit ~ R.D.Spend+Administration+Marketing.Spend,
               data = dataset)
summary(regressor)

regressor1 = lm(formula = Profit ~ R.D.Spend+Marketing.Spend,
               data = test_set)
summary(regressor1)

regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset)
summary(regressor)
Pred_Err(test_set,prediction_model = regressor)
Pred_Err(test_set,prediction_model = regressor1)
