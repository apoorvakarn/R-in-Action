x=factor(c("low","high","medium"))
x
x1=factor("Male","Female","Male")
x1
z=factor(c("low","medium","high"),ordered=T,levels = c("high","medium","low"))
z
gender=c(1,2,1,1,2)
fgender=factor(gender)
fgender
fgender=factor(gender,levels = c(1,2), labels = c("M","F"))
fgender
classposition=c(1,2,3,1)
class(classposition)
summary(classposition)
fclassposition=factor(classposition)
fclassposition
summary(fclassposition)
levels(fclassposition)
fclassposition2=factor(classposition,levels=c(5,4,3,2,1),ordered = T,labels = c("fifth","fourth","third","second","first"))
fclassposition2
summary(fclassposition2)
fclassposition3=factor(fclassposition2,levels(fclassposition2)[c(5,3,4,2,1)])
fclassposition3
print(levels(fclassposition3))
rev(levels(fclassposition2))
fclassposition2
fclassposition4=factor(fclassposition2,(levels = rev(fclassposition2)))
plot(summary(fclassposition2))
