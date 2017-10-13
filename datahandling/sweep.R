#create some data
M= matrix(1:12,ncol=3)
M
M+1
M+c(1,2)
M
M+c(1,2,3)
cbind(M, M+c(1,2,3))
#calculate columnwise means for M
dx= colMeans(M)
dx
colSums(M)
sweep(M,2,dx, FUN = '-')
dy = rowMeans(M)
dy
sweep(M,1,dy, FUN = '-')
sweep(M,1,dy, FUN = '+')
sweep(M,c(1,2),dx, FUN = '+')
sweep(M,c(1,2),c(dx,dy), FUN = '+')
