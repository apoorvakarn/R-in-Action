# assignment 6
x=ceiling(seq(10,200,length.out = 40)) # equal interval between 10 and 200
x
m= matrix(x,nrow = 5) # create the matrix 5x8 : columnwise----
m
# Return the product of each of the rows
apply(m,1,FUN = prod) #7.027086e+14 1.576307e+15 3.068219e+15 5.383547e+15 8.957139e+15
p=m[1,]*m[2,]*m[3,]*m[4,]*m[5,]
p
# Return the sum of each of the columns
apply(m,2,FUN = sum)
apply(m,1,FUN = sum) #Return the sum of each of the rows
# Return a new matrix whose entries are those of 'matrix values' modulo 10
