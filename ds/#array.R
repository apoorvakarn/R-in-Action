#Arrays
#2 coys; eac hcoy has three departments;each department has 4 salesman
company=c("coy1","coy2")
department=c("dept1","dept2","dept3")
salesman=c("salesman1","salesman2","salesman3","salesman4")
set.seed(1234)
sales=ceiling(runif(2*3*4,50,100))
mean(sales)
cat(sales)
sales;length(sales)
salesarray= array(sales,c(4,3,2),dimnames= list(salesman,department,company))
?array
salesarray
colnames(salesarray)
rownames(salesarray[2])
nrow(salesarray)
ncol(salesarray)
dimnames(salesarray)
length(salesarray)
dimnames(salesarray(2))
class(salesarray)
str(salesarray)
salesarray[2,,]
salesarray[,,1]
salesarray[,,1] #coy1
apply(salesarray,c(1),sum) #salesmanwise
apply(salesarray,c(2,3),sum) 
apply(salesarray,c(1,2,3),length) #coywise=numbers
