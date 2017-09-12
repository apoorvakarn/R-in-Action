
#Assignment 3 Question 1;

Sales <-c(1000,13000,12000,15000);
Qtr <- c("Q1","Q2","Q3","Q4");

Qtr_sales <-data.frame(Qtr,Sales)

dotchart(Qtr_sales$Sales,labels = Qtr_sales$Qtr,
         main = "Quarterly Sales",xlab ="Sales",
         ylab = "Quarter",cex=0.8)

barplot(Qtr_sales$Sales,names.arg= Qtr_sales$Qtr, 
        xlab = "Quarter",ylab = "Sales",main = "Quaterly sales")

Qtr1 <-Qtr_sales[Qtr_sales$Sales>11000,]
Qtr1

Qtr3_sales <-Qtr_sales[Qtr_sales$Qtr=='Q3',2]

#Question 2

attendance <- sample(c('A','P'),size = 30,replace = TRUE,prob = c(0.3,0.7))
attendance

attendance_data <- data.frame(sample(c('A','P'),size = 30,replace = TRUE,prob = c(0.3,0.7)))
attendance_data

#question 3

set.seed(1000)
score_P1 <- ceiling(runif(10,min=30,max=100))


set.seed(1100)
score_P2 <- ceiling(runif(10,min=30,max=100))

set.seed(1100)
score_P3 <- ceiling(runif(10,min=30,max=100))

set.seed(1300)
score_P4 <- ceiling(runif(10,min=30,max=100))

set.seed(1400)
score_P5 <- ceiling(runif(10,min=30,max=100))

score <-matrix(c(score_P1,score_P2,score_P3,score_P4,score_P5),nrow=5,ncol=10)
rownames(score)=c('p1','p2','p3','p4','p5')
colnames(score)=c('Match1','Match2','Match3','Match4','Match5',
                  'Match6','Match7','Match8','Match9','Match10')
score
rowMeans(score)
colMeans(score)

# question 4

guests <- c("Achal","Apoorva","Lalit","Goldie")
course <- c("BSc","LLB","MSc")
school <- c("Animation","Law","DS")
nos <- c(50,20,24)
male = c(25,10,12) #based on 50%,otherwise based on answer male = c(40,16,19)
female <- c(25,10,12)# based on 50%,otherwise based on answer female = c(10,4,5)
hosts <- data.frame(course,school,nos,male,female)
decoration <- c(10,300,400,500,230)
food <- c(500,200,150,400,700)
bills <- data.frame(rbind(decoration,food))
colnames(bills) <-c("B1","B2","B3","B4","B5")
cat("sum in decorations-",sum(bills[1,]))
cat("sum in food-",sum(bills[2,]))
cat("male among hosts-",hosts[,4])
cat("female among hosts-",hosts[,5])
cat("no of guests-",length(guests))

# question 5
set.seed(1234)
ds <- matrix(ceiling(runif(30,1000,2000)),nrow = 5,ncol = 3)
colnames(ds)<- c("graduate","pg","diploma")
rownames(ds)<- c("S1","S2","S3","S4","S5")
law <- matrix(ceiling(runif(30,100,2000)),nrow = 5,ncol = 3)
colnames(law)<- c("graduate","pg","diploma")
rownames(law)<-c("S1","S2","S3","S4","S5")
cat("5th student ds-page course-",ds[5,2])
cat("student 1 law of law-dip course-",law[1,3])
# avg school vs course
avgSchCrs=round(cbind(colMeans(ds),colMeans(law)))
avgSchCrs
colnames(avgSchCrs)=c("ds","law")
avgSchCrs
# studntwisesum
rowsum(ds)+rowsum(law)
 # average of student vs course
avgdslaw <- round((ds+law)/2)
avgdslaw
 # coursewise sum
DS<- sum(ds)
LAW <- sum(law)
schsum <- data.frame( DS,LAW)
schsum

# question 6
students <- c("S1","S2","S3","S4","S5")
gender <- c("M","F","M","M","F")
age <- c(23,22,21,25,22)
city <- c("Delhi","Noida","Lucknow","Delhi","Noida")
category <- c("GEN","OBC","GEN","SCST","GEN")
studentdf <- data.frame(students,gender,age,city,category)
studentdf
table(studentdf$category)
table(studentdf$gender)
table(studentdf$category,studentdf$gender)
newstudent <- c("student1","student2","student3","student4","student5")
studentdf$students=newstudent
studentdf
