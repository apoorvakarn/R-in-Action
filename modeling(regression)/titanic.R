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
dataset <- read.csv("train.csv",stringsAsFactors = F,na = "")
# First few entries of the data
head(dataset)
str(dataset)
colSums(is.na(dataset))
table(dataset$Embarked)
dataset$Embarked[is.na(dataset$Embarked)] = "S"
table(dataset$Embarked)
apply(dataset,2,function(x) length (unique(x)))
cols=c("Survived","Pclass","Sex","Embarked")
for (i in cols){
  dataset[,i]=as.factor(dataset[,i])
}
ggplot(dataset,aes(x=Pclass,fill=factor(Survived))) +
  geom_bar()+
  ggtitle("Pclass v/s Survival Rate")+
  xlab("Pclass") +
  ylab("Total Count") +
  labs(fill = "Survived")  
ggplot(dataset, aes(x = Sex, fill = Survived)) +
  geom_bar() +
  ggtitle("Gender vs survival") +
  xlab("Sex") +
  ylab("Total Count") +
  labs(fill = "Survived")
ggplot(dataset, aes(x = Sex, fill = Survived)) +
  geom_bar() +
  facet_wrap(~Pclass) + 
  ggtitle("3D view of sex, pclass, and survival") +
  xlab("Sex") +
  ylab("Total Count") +
  labs(fill = "Survived")
head(dataset$Name)
names <- dataset$Name
title <-  gsub("^.*, (.*?)\\..*$", "\\1", names)
dataset$Title <- title
table(dataset$Sex, dataset$Title)
# Army folks, doctors and nobel people to be combined in one group - "Officer" level
officer <- c('Capt', 'Col', 'Don', 'Dr', 'Major', 'Rev', 'Sir', 'Jonkheer', 'the Countess')
dataset$Title[dataset$Title %in% officer]  <- 'Officer'

# Also reassign mlle, ms, and mme accordingly
dataset$Title[dataset$Title == 'Mlle']        <- 'Miss' 
dataset$Title[dataset$Title == 'Ms']          <- 'Miss'
dataset$Title[dataset$Title == 'Lady']         <- 'Miss' 
dataset$Title[dataset$Title == 'Dona']         <- 'Miss' 
dataset$Title[dataset$Title == 'Mme']         <- 'Mrs' 
table(dataset$Sex, dataset$Title)
ggplot(dataset,aes(x = Title,fill=factor(Survived))) +
  geom_bar() +
  ggtitle("Title V/S Survival rate")+
  xlab("Title") +
  ylab("Total Count") +
  labs(fill = "Survived")
ggplot(dataset, aes(x = Title, fill = Survived)) +
  geom_bar() +
  facet_wrap(~Pclass) + 
  ggtitle("3-way relationship of Title, Pclass, and Survival") +
  xlab("Title") +
  ylab("Total Count") +
  labs(fill = "Survived")
# Create a family size variable including the passenger themselves
dataset$Fsize <- dataset$SibSp + dataset$Parch + 1

# Use ggplot2 to visualize the relationship between family size & survival
ggplot(dataset, aes(x = Fsize, fill = Survived)) +
  geom_bar() +
  ggtitle("Family Size V/S Survival Rate") +
  xlab("FamilySize") +
  ylab("Total Count") +
  labs(fill = "Survived")
# Discretize family size
dataset$FsizeD[dataset$Fsize == 1] <- 'singleton'
dataset$FsizeD[dataset$Fsize < 5 & dataset$Fsize > 1] <- 'small'
dataset$FsizeD[dataset$Fsize > 4] <- 'large'

ggplot(dataset, aes(x = FsizeD, fill = Survived)) +
  geom_bar() +
  ggtitle("Family Size V/S Survival Rate") +
  xlab("FamilySize") +
  ylab("Total Count") +
  labs(fill = "Survived")
## Exploratory Analysis on Embarked
```{r}
###is there any association between Survial rate and where we get into the Ship.   
ggplot(dataset,aes(x = Embarked,fill=factor(Survived))) +
  geom_bar() +
  ggtitle("Embarked vs Survival") +
  xlab("Embarked") +
  ylab("Total Count") +
  labs(fill = "Survived") 
# Prediction

## Split into training & test sets

* Divide data into train and test set for internal validation
```{r}
# Set a random seed
set.seed(123)

split = sample.split(dataset$Survived, SplitRatio = 0.80)

training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Structure of the data
str(training_set)
```

## Building the model
We then build our model using logistic regression on the training set.

```{r}
# Build the model (note: not all possible variables are used)
LogReg_model <- glm(factor(Survived) ~ Pclass + Sex + SibSp + Parch + Fare + Embarked +                       Title + FsizeD, data = training_set, family = binomial)

summary(LogReg_model)
```

```{r}
# Backward Elimination to choose the predictors - Iternation 2 - Sex removed
LogReg_model <- glm(factor(Survived) ~ Pclass + SibSp + Parch + Fare + Embarked + Title + FsizeD,
                    data = training_set, family = binomial)

summary(LogReg_model)
```

```{r}
# Iteration 3 - Embarked Removed
LogReg_model <- glm(factor(Survived) ~ Pclass + SibSp + Parch + Fare + Title + FsizeD,
                    data = training_set, family = binomial)

summary(LogReg_model)
```

```{r}
# Iteration 4 - SibSp removed
LogReg_model <- glm(factor(Survived) ~ Pclass + Parch + Fare + Title + FsizeD,
                    data = training_set, family = binomial)

summary(LogReg_model)
```

```{r}
# Iteration 5 - Parch removed
LogReg_model <- glm(factor(Survived) ~ Pclass + Fare + Title + FsizeD,
                    data = training_set, family = binomial)

summary(LogReg_model)
```

```{r}
# Iteration 6 - Fare removed
LogReg_model <- glm(factor(Survived) ~ Pclass + Title + FsizeD,
                    data = training_set, family = binomial)

summary(LogReg_model)
```
Final Set of Variable: **Pclass**,**Title**,**FsizeD**
  
  
  Find set of variables using backward variable selection:
  ```{r,message=FALSE}
attach(training_set)
# Fast backward Selection 
fullmodel <- fastbw(lrm(factor(Survived) ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FsizeD)                     ,rule="p")
fullmodel
```

```{r}
# Predicting the Test set results
prob_pred = predict(LogReg_model, type = 'response', newdata = test_set[c("Pclass","Title","FsizeD")])
Survived_pred = ifelse(prob_pred > 0.5, 1, 0)

# Making the Confusion Matrix
cm = table(test_set$Survived, Survived_pred)
cm
```

```{r}
# Accuracy
Accuracy = (96+51)/length(test_set$Survived)
Accuracy
```

