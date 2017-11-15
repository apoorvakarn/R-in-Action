# Load libraries
library(datasets)
library(caTools)

# Load the dataset
dataset <- iris 
View(iris)
#Structure of the data
str(dataset)

#Split data into train and test
set.seed(123)
split <- sample.split(dataset$Species,SplitRatio = 0.80)
(train <- subset(dataset,split==TRUE))
(test <- subset(dataset,split==FALSE))

# Use logistic regression and the one-vs-all strategy to build a classification model.
for(cls in unique(train$Species))
{
  train$class <- ifelse(train$Species==cls,1,0)
  logits <- glm(class~.,data = train[,-5],family = binomial)
  
  # Predict the class for each of the samples in the test set.
  pred <-  predict(logits,newdata = test[,c(1:4)], type="response")
  test[,paste0(cls,"_prob")] <- pred  
}
View(test)
# Assign Class with Maximum Probability
predictions <- apply(test[,c(6,7,8)], 1, which.max)
predictions[which(predictions=="1")] <- levels(train$Species)[1]
predictions[which(predictions=="2")] <- levels(train$Species)[2]
predictions[which(predictions=="3")] <- levels(train$Species)[3]
test$prediction <- predictions

# summarize accuracy
table(test$prediction, test$Species)

