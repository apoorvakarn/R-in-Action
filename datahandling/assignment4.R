# ASSIGNMENT 4
df3= read.csv(file = './datahandling/dsstudents2.csv') #downloaded as csv and stored as df3
df3
str(df3) #structure of df3

summary(df3) # summary of df3
class(df3) #class is data.frame of df3
nrow(df3) #number of rows is 11 in df3
dim((df3)) # 11rows and 14 columns
names(df3) # names of columns
cat(names(df3))
#df3a
df3=read.csv(file = './datahandling/dsstudents2.csv',colClasses = colcls, as.is = T)
df3

colcls =c('numeric', NA, 'factor', 'factor', 'logical', 'character','numeric',
          'character', 'character' ,'factor', rep('numeric',4))
length(colcls)
is.na(df3) #find na values in dataset
anyNA(df3) # if true(dataset contains na values)
table(is.na(df3)) #gives the number of na values
all(is.na(df3)) #if false(not all values are na)
# finding age and creating new column for that
df3$dob= as.Date(df3$dob,format = "%d-%b-%y")
class(df3$dob)
difftime(Sys.Date(),df3$dob,unit = "weeks")
df3$age= ceiling(as.numeric(difftime(Sys.Date(),df3$dob,unit = "weeks"))/52.5)
df3$age
str(df3$age)

# missing values
complete.cases(df3)
all(is.na(df3))
all(is.na(df)==F) 
all(is.na(df3)==F | is.na(df3)==T)
sum(complete.cases(df3)) # complete cases
sum(!complete.cases(df3)) #incomplete cases
df3[complete.cases(df3),][1:2] #name and rollno of complete cases
df3[!complete.cases(df3),][1:2] #name and rollno of incomplete cases
# removing na values with mean
mean(df3$excel)
mean(df3$excel,na.rm = T) # remove na values from excel column
mean(df3$excel,na.rm = T, trim=.2)
cat(df3$excel,trim=.2)
df3$excel
df3$excel[is.na(df3$excel)]= mean(df3$excel,na.rm = T)
df3$excel
 # removing na values with mean in sql
mean(df3$sql)
mean(df3$sql,na.rm = T)
df3$sql
df3$sql[is.na(df3$sql)]= mean(df3$sql,na.rm = T)
df3$sql
# removing na values from fee
df3$fees
median(df3$fees)
median(df3$fees,na.rm = T)
df3$fees[is.na(df3$fees)] = median(df3$fees , na.rm = T)
df3$fees
#removing na values from hostel
df3$hostel
sample(c('TRUE','FALSE'),5,replace = T, prob = c(0.5,0.5))
median(df3$hostel)
median(df3$hostel, na.rm = T)
df3$hostel[is.na(df3$hostel)] = median(df3$hostel, na.rm = T)
df3$hostel
 # adding up a new row
df= data.frame(17000,"Ramesh Singh","MSC",NA,"TRUE","1994-10-17", 50000,"ramesh@gmail.com", NA,"Delhi",NA,NA,NA,NA,NA)
names(df)= c("rollno" ,"name" ,  "course", "gender", "hostel", "dob" ,  
              "fees" ,  "email",  "mobno" , "city"  , "rpgm" ,  "excel" ,
              "sql"  ,  "stats",  "age") 
colnames(df3)
ncol(df3)
ncol(df)
df4=rbind(df3,df)
df4 # creating a new dtaframe as df4
df4$excel
mean(df4$excel)
mean(df4$excel,na.rm = T)
df4$excel[is.na(df4$excel)]=mean(df4$excel,na.rm = T)
df4$excel
df4$sql
mean(df4$sql)
mean(df4$excel,na.rm= T)
df4$sql[is.na(df4$sql)] = mean(df4$excel,na.rm= T)
df4$sql
df4$stats
mean(df4$stats, na.rm=T)
df4$stats[is.na(df4$stats)]= mean(df4$stats, na.rm=T)
df4$stats
df4$rpgm
mean(df4$rpgm, na.rm = T)
df4$rpgm[is.na(df4$rpgm)] =mean(df4$rpgm, na.rm = T)
df4$rpgm
df4$gender
df4$gender[is.na(df4$gender)] = "M"
df4$gender
df4$dob= as.Date(df4$dob,format = "%d-%b-%y")
df4$dob
difftime(Sys.Date(),df4$dob,unit = "weeks")
df4$age= ceiling(as.numeric(difftime(Sys.Date(),df4$dob,unit = "weeks"))/52.5)
df4$age

df4$rollno=rownames(df4)
df4
# creating another table
View(df4)
df5 <- df4[c("rollno","rpgm","excel","sql","stats")]
View(df5)
df5$sum <- c(df5$rpgm+df5$excel+df5$sql+df5$stats)
addmargins(df5,1,mean)
addmargins(df5,1,median)
# creating another table
table(df4$course,df4$gender)
(prop.table(table(df4$course,df4$gender)))
p1= (prop.table(table(df4$course,df4$gender)))
p1
rowSums(p1)
rowSums(p1)
addmargins(p1)
addmargins(p1,1,sum)
addmargins(as.table(as.matrix(df4)),c(2,1,1),list(sum,mean,median))#addmargins to create row sum,column means,medians
#creating course vs gender summary & proportion tables
t1 <- table(df4$course,df4$gender)
addmargins(t1)#summary of course vs gender
prop.table(t1)#proportions of course-gender table
#Grade function & Rank
df6 <- df4[,c(1,2,11,12,13,14)]# creating dataframe df3c having rollno,names & subject marks
df6
df6$total <- rowMeans(df4[,c(3:6)])#creating total column
df6
grades <- function(x){
  if (x > 70){
    print('A')
  } else if (x >= 60 & x <= 70){
    print('B')
  } else {
    print('C')
  }
} # creating function for grades
for (i in c(1:12)){
  df6$grade[i] <- grades(df6$total[i])# for loop for giving grades according to avg. marks per row
}
df6
df6$ranks <- rank(-df6$total)#rank 1 to largest total marks
df6
df6$name[df6$ranks==5]#gives Shruti Sinha-5th rank holder
df6
#Rowwise & Columnwise means-Pending
df7 <- df4[,c(3,11,12,13,14)]
df4

#split wrt course,wrt gender-hostel
split(df4[1:3],df4$course)#split according to course
split(df4[1:3],list(df4$gender,df4$hostel))#split wrt gender-hostel
#adding bigdata marks and scaling
bigdata <- ceiling(runif(12,100,150))
bigdata
df8 <- df4#creating new dataframe - df8
df8
df8$bigdata <- bigdata#adding bigdata to df8
df8
?scale
df8$bigdataS <- scale(df8$bigdata,center=F)#scaling bigdata marks
df8
#creating barplot
df9 <- df8[,c('rpgm','excel','sql','stats','bigdata')]
df9
g1 <- colMeans(df9)
barplot(g1,main = 'Average Marks',ylim=c(0,140))#barplot of average marks
aggregate(df4[c("rpgm","excel","sql","stats")],by= list(df4$course,df4$gender), FUN = sum)
