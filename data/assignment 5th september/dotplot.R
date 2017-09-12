mtcars
str(mtcars)
dotchart(mtcars$mpg)
dotchart(mtcars$mpg,labels=row.names(mtcars))

x<-mtcars[order(mtcars$mpg),]

dotchart(x$mpg,labels=row.names(x))

x$cyl<-factor(x$cyl)

x$color[x$cyl == 4] <- "red"
x$color[x$cyl == 6] <- "blue"
x$color[x$cyl == 8] <- "darkgreen"

dotchart(x$mpg,
         labels = row.names(x),
          cex= .6,
          groups = x$cyl,
          gcolor = "black",
          color = x$color,
          pch = 19,
          main = "Gas Mileage for car models\ngrouped by cylinder",
          xlab = "Miles per Gallon") 

par()
par(pin=c(2,2)) #changing the parameters size


par(col.lab="green") #changing the colour of the labels
hist(mtcars$mpg)
opar= par(readonly= T) 
par(margin.table)
par("mar") #to find the value of margins
par("mai")
hist(mtcars$mpg)
par(mar=c(0.5,0.5,0.5,0.5))
par("mar")
hist(mtcars$mpg)
par(mfrow=c(2,2)) #multiple frame per row(row wise)
attach(mtcars)
hist(mpg,main = "1")
hist(cyl,main = "2")
hist(wt,main = "3")
hist(hp,main = "4")
par(mfcol=c(2,2)) #multiple frame per coloumn(column wise)
attach(mtcars)
hist(mpg,main = "1")
hist(cyl,main = "2")
hist(wt,main = "3")
hist(hp,main = "4")
layout(matrix(c(1,1,2,3),byrow = T,nrow = 2))
attach(mtcars)
hist(mpg,main = "1")
hist(cyl,main = "2")
hist(wt,main = "3")
hist(hp,main = "4")
layout(matrix(c(1,1,1,2,3,4),byrow = T,nrow = 3))
attach(mtcars)
hist(mpg,main = "1")
hist(cyl,main = "2")
hist(wt,main = "3")
hist(hp,main = "4")
layout(matrix(c(1,1,2,3),byrow = T,nrow = 2),widths = c(1,3),heights = c(1,2))
attach(mtcars)
hist(mpg,main = "1")
hist(cyl,main = "2")
hist(wt,main = "3")
hist(hp,main = "4")

# by use of figure
par(opar)
par(fig= c(0,0.8,0,0.8), new= T)
plot.new()
par(opar)
par(fig= c(0,0.8,0,0.8), new= T)
attach(mtcars)
hist(mpg,main = "1")
hist(cyl,main = "2")
par(fig= c(0,0.8,0,0.8), new= T)
plot(wt,mpg)
par(fig= c(0,0.8,0.65,1), new= T)
boxplot(wt,horizontal = T,axes = F)
par(fig= c(0.65,1,0,0.8), new= T)
boxplot(wt,axes = F)

