#Clear All
rm(list=ls())

# Load libraries
library(datasets)
library(caTools)

# Load the dataset
dataset <- iris 
#Structure of the data
str(dataset)

#Split data into train and test
set.seed(123)
split <- sample.split(dataset$Species,SplitRatio = 0.80)

train <- subset(dataset,split==TRUE)
test <- subset(dataset,split==FALSE)

# Use logistic regression and the one-vs-all strategy to build a classification model.
test[,as.character(unique(train$Species))] <- 0
test
for(cls_1 in unique(train$Species))
{
  for(cls_2 in unique(train$Species))
  {
    if(cls_1 == cls_2)
      {next}
    
    train_sub <- train[train$Species %in% c(cls_1,cls_2),]

    train_sub$class <- ifelse(train_sub$Species == cls_1,1,0)
    logits <- glm(class~.,data = train_sub[,-5],family = binomial)
    
    # Predict the class for each of the samples in the test set.
    pred <-  predict(logits,newdata = test[,c(1:4)], type="response")
    
    # Voting
    test[,cls_1] <- test[,cls_1] + ifelse(pred > 0.50,1,0)  
    test[,cls_2] <- test[,cls_2] + ifelse(pred > 0.50,0,1)
  }
}

# Assign Class with Maximum Votes
predictions <- apply(test[,c(6,7,8)], 1, which.max)
predictions[which(predictions=="1")] <- levels(train$Species)[1]
predictions[which(predictions=="2")] <- levels(train$Species)[2]
predictions[which(predictions=="3")] <- levels(train$Species)[3]
test$prediction <- predictions

# summarize accuracy
table(test$prediction, test$Species)

