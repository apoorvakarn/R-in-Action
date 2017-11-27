require(ISLR)
require(boot)

?cv.glm
plot(mpg~horsepower,data=Auto)

##LOOCV
glm.fit = glm(mpg~horsepower,data=Auto)
cv=cv.glm(data = Auto,glmfit = glm.fit,K=392)#K=392, K=10
cv$delta[1]#two average values ,first for k fold model and second one for leave one out cross validation

(cv.error = rep(0,5))
(degree = 1:5)

for (d in degree){
  glm.fit = glm(mpg~poly(horsepower,d),data=Auto)
  CV = cv.glm(data = Auto,glmfit = glm.fit)
  cv.error[d] = CV$delta[1]
}
plot(degree,cv.error,type = "b")


## 10-fold CV
cv.error10 = rep(0,5)
for (d in degree){
  glm.fit = glm(mpg~poly(horsepower,d),data=Auto)
  CV = cv.glm(data = Auto,glmfit = glm.fit,K = 10)
  cv.error10[d] = CV$delta[1]
}
lines(degree,cv.error10,type = "b",col = "orange")
#orange line is for k=10 and black is for k = 392
