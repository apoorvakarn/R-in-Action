iris 
head(iris)
str(iris)
y = iris[,"Sepal.Width"]
x = iris[,"Sepal.Length"]
head(x)
head(y)
xycorr = cor(y,x, method = "pearson")
xycorr
