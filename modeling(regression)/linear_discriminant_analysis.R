url= 'https://archive.ics.uci.edu/ml/machine-learning-databases/wine/wine.data'
url
(wine = read.csv(url))
colnames(wine) <- c('Type','Alcohol', 'Malic', 'Ash', 'Alcalinity', 'Magnesium', 'Phenols', 'Flavanoids','Nonflavanoids', 'Proanthocyanins', 'Color', 'Hue', 'Dilution', 'Proline')
head(wine)
library(car)
scatterplotMatrix(wine[2:6])
#The purpose of linear discriminant analysis (LDA) in this example is to find the linear combinations of the original variables (the 13 chemical concentrations here) that gives the best possible separation between the groups (wine cultivars here) in our data set. Linear discriminant analysis is also known as “canonical discriminant analysis”, or simply “discriminant analysis”.
#If we want to separate the wines by cultivar, the wines come from three different cultivars, so the number of groups G=3, and the number of variables is 13 (13 chemicals’ concentrations; p=13). The maximum number of useful discriminant functions that can separate the wines by cultivar is the minimum of G−1 and p, and so in this case it is the minimum of 2 and 13, which is 2. Thus, we can find at most 2 useful discriminant functions to separate the wines by cultivar, using the 13 chemical concentration variables.

#You can carry out a linear discriminant analysis using the “lda()” function from the R MASS package. To use this function, we first need to install the MASS R package.
# install.packages('MASS')
install.packages('MASS')
library(MASS)
wine.lda <- lda(Type ~ ., data=wine)
wine.lda
wine.lda.values <- predict(wine.lda)
ldahist(data = wine.lda.values$x[,1], g=wine$Type)
ldahist(data = wine.lda.values$x[,2], g=wine$Type)
plot(wine.lda.values$x[,1],wine.lda.values$x[,2]) # make a scatterplot
text(wine.lda.values$x[,1],wine.lda.values$x[,2],wine$Type,cex=0.7,pos=4,col="red")
table(wine.lda.values$class,wine$Type)
