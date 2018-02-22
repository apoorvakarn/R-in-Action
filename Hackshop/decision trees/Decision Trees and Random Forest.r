

#---------------------------------Decision trees----------------------------------------------#


#-------------------------Fitting Classification Trees----------------------------------------#

#-------------------------->Preparing the Working Environment
install.packages(tree)
library(tree)
library(ISLR)
library(MASS)
library(randomForest)

Path<-setwd("C:/Ganesha_Accenture/Ganesha_IVY/R/20180112 -- 0180114 Ivy Data Science Hackshop/04 DECISION TREES/CASE STUDY3")
Carseats<-read.csv(paste(Path,"/02DATA/Carseats_Sales.csv",sep = ""))


#-------------------->Exploring the Data Set

head(Carseats)
str(Carseats)
colSums(is.na(Carseats))


#-------------------->Recoding the Continous Var as a Categorical Var

High <- ifelse(Carseats$Sales <=8, 'No', 'Yes')
Carseats <- data.frame(Carseats, High)



#-------------------->Using the tree function to predict the Dependent Variable -- High

tree.carseats <- tree(High ~. - Sales, Carseats)
summary(tree.carseats)



#-------------------->Displaying the trees structure
plot(tree.carseats)
text(tree.carseats)
tree.carseats


#-------------------->Evaluating the Performance of the Model through Train and Test Data Set

#Creating the test and train data sets
set.seed(2)
train <- sample(1:nrow(Carseats), 200)
Carseats.test <- Carseats[-train, ]
High.test <- High[-train]
tree.carseats <- tree(High ~. -Sales, Carseats, subset=train)


#Predicting the train model on test data set
tree.pred <- predict(tree.carseats, Carseats.test, type='class')

table(tree.pred, High.test)

# Overalll Accuracy of the Model
T_1<-(86+57)/200


#--------------------> Pruning the Decision Tree

#Cross-validation in used to determine the optimal level of tree complexity; cost complexity pruning
#is used in order to select a sequence of trees for consideration.


#Here, we use FUN=prune.misclass in order to indicate that we want the classification error rate to
#guide the cross- validation and pruning process rather than default deviance function


#-------------------->Performing the cross validation
set.seed(3)
cv.carseats <- cv.tree(tree.carseats, FUN=prune.misclass)
cv.carseats



#Thecv.tree() function reports the number of terminal nodes of each tree considered
#(size) as well as the corresponding error rate and the value of the
#cost-complexity parameter used

#$size-- No. of terminal nodes for each tree (9 -- Optimal)
#$dev -- Cross Validation Error
#$k -- Cost Complexity Parameter

#----------------->Ploting the error rate as a function of both size and k.

options(repr.plot.height = 3, repr.plot.width = 6)

par(mfrow=c(1,2))
plot(cv.carseats$size, cv.carseats$dev, type='b', main = "CV plot (terminal node size vs dev)")
plot(cv.carseats$k, cv.carseats$dev, type='b',main = "CV plot (cost complexity vs dev)")


#----------------->Pruning the tree to prune to obtain the nine-node tree.

prune.carseats <- prune.misclass(tree.carseats, best = 9)
par(mforw = c(1,1))
plot(prune.carseats)
text(prune.carseats, pretty = 0)
summary(prune.carseats)

#Predicting the pruned model on test data set
tree.pred <- predict(prune.carseats, Carseats.test, type = 'class')
table(tree.pred, High.test)

# Accuracy
T2<-(94+60)/200




#-------------------------Fitting Regression Tree----------------------------------------#

Boston<-read.csv(paste(Path,"/02DATA/Boston.csv", sep = ""))
head(Boston)




#Creating the test and train data sets
set.seed(1)
train <- sample(1:nrow(Boston), nrow(Boston)/2)


#Fitting the train model 
tree.boston <- tree(medv ~., Boston, subset = train)
summary(tree.boston)

plot(tree.boston)
text(tree.boston, pretty = 0)



#--------------------> Pruning the Decision Tree
cv.boston <- cv.tree(tree.boston)
cv.boston
plot(cv.boston$size, cv.boston$dev, type = 'b', main = "CV plot terminal node size vs Deviance")

#-------------------> if you still want to prune the tree
prune.boston <- prune.tree(tree.boston, best = 5)
plot(prune.boston)
text(prune.boston, pretty = 0)



#-------------------> Predicting the pruned model on test data set
yhat <- predict(tree.boston, newdata = Boston[-train, ])
boston.test <- Boston[-train, 'medv']
plot(yhat.bag, boston.test)
abline(0, 1)
mean((yhat - boston.test) ^ 2)




#-------------------------------------Random Forest----------------------------------------#
#----------------->Bagging
#----------------->Bagging is a special case of Random Forest, with where no. of random variables (m) =
#no. of predictors (p)



#-------------------------------------Bagging----------------------------------------#


set.seed(1)
bag.boston <- randomForest(medv ~., data=Boston, subset=train,
                          mtry=13,
                          importance=T)

#--------------------------> Here,mtry == indicates all the 13 variables should be considered
# each split of the tree -- i.e bagging should be done.



bag.boston

#--------------------------> Here,mtry == indicates all the 13 variables should be considered
# each split of the tree -- i.e bagging should be done.

yhat.bag <- predict(bag.boston, newdata = Boston[-train, ])
plot(yhat.bag, boston.test)
abline(0, 1)
MSE_bagging<-mean((yhat.bag - boston.test) ^ 2)

#Here, the test MSE 13.47, which is almost half than a single pruned tree


#---------------------------------Random Forest-----------------------------------------#
set.seed(1)
rf.boston <- randomForest(medv ~., data = Boston,
                         subset = train,
                         mtry = 6,
                         importance = T)

#By default, randomForest() uses p/3 variables when building a random forest of regression trees, and
#p variables when building a random forest of classification trees.

yhat.rf <- predict(rf.boston, newdata = Boston[-train, ])
mean((yhat.rf - boston.test ) ^ 2)

importance(rf.boston)

#Importance reports -- mean decrease of accuracy in predictions on the out of bag samples when a given
#variable is excluded from the model
varImpPlot(rf.boston)

#varImpPlot reports -- measure of the total decrease in the node impurity that results from splits
#over that variable, averaged over all the trees. 

#In case of regression tree, the node impurity is measured by the training Residual Sum of Squares
# and for classificaton it is measured by the deviance. 
