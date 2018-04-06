install.packages("dplyr")
library(dplyr)
install.packages("nycflights13")
library(nycflights13)
data= flights
data
print(dplyr::tbl_df(mtcars),n=30)
tbl_df(iris) %>% print(n= Inf)
glimpse(iris)
View(iris)
mtcars['mpg']
select(mtcars,mpg,vs)
mtcars %>% select(vs,mpg,wt)
mtcars %>% group_by(cyl) %>% summarise(avg=  mean(wt),mean(hp)) %>% arrange(avg)
dplyr::summarise_each(iris,funs(mean))
dplyr::count(iris, Species, wt = Sepal.Length)
