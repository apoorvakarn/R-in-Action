#4th assignment revision
getwd()
setwd("C:/rWork/rProjects/R-in-Action/datahandling")

df3= read.csv(file = "dsstudents2.csv")


df3= read.csv(file = './datahandling/dsstudents2.csv') #downloaded as csv and stored as df3
df3
str(df3)#checking the structure of df3
df3$name <- as.character(df3$name)#converting df3$name from factor to character
df3$dob <- as.Date(df3$dob,format='%d-%b-%y')#converting df3$dob from factor to date
df3$email <- as.character(df3$email)#converting from factor to character
df3$city <- as.character(df3$city)#converting from factor to character
str(df3)
df3
# creating age column
df3$age <- ceiling(as.numeric(difftime(Sys.Date(),df3$dob,units='days')/365))#calculating age
df3
#sum of missing values & listing rows having missing values
sum(is.na(df3))# no. of missing values
df3[!complete.cases(df3),]# missing rows
#replacing NAs with appropriate values
df3$hostel[is.na(df3$hostel)] <- names(table(df3$hostel)[1])#replacing NA with 'FALSE'having greater occurrence
df3$hostel
df3$fees[is.na(df3$fees)] <- median(df3$fees,na.rm=T)#replacing NA with median of fees
df3$fees
df3$city[is.na(df3$city)] <- 'Delhi'#replacing NA with Delhi
df3$city
df3$excel[is.na(df3$excel)] <- median(df3$excel,na.rm=T)#replacing NA with median
df3$excel
df3$sql[is.na(df3$sql)] <- median(df3$sql,na.rm=T)#replacing NA with median
sum(is.na(df3))# check for NAs after replacing all NAs
#Adding a row in df3
df1 <- data.frame(17000, 'Ramesh Singh', 'MSC','',TRUE, '1994-10-17', 50000,
                  'ramesh@gmail.com','', 'Delhi','','','','')#creating one row dataframe
df1
str(df1)
colnames(df1) <- colnames(df3[1:14])#replacing column names of df1 with df3 column names
colnames(df1)
df1
df1$name <- as.character(df1$name)#converting from factor to character datatype
df1$dob <- as.Date.factor(df1$dob)#converting from factor to date
df1$dob
str(df1)
df1$email <- as.character(df1$email)#converting from factor to character
df1$city <- as.character(df1$city)#converting from factor to character
str(df1)
df1$age <- ceiling(as.numeric(difftime(Sys.Date(),df1$dob,units='days')/365))#calculating age
df1
dim(df1)
df3 <- rbind(df3,df1)# adding df1 as row to df3;has changed mobno,rpgm,excel,sql,stats to chr
df3
str(df3)
df3$mobno <- as.numeric(df3$mobno)# converting chr to numeric
df3[,c('rpgm')] = as.numeric(df3[,c('rpgm')])# converting chr to numeric
df3[,c('excel')] = as.numeric(df3[,c('excel')])# converting chr to numeric
df3[,c('sql')] = as.numeric(df3[,c('sql')])# converting chr to numeric
df3[,c('stats')] = as.numeric(df3[,c('stats')])# converting chr to numeric
levels(df3$gender)[3] <- 'M'

df3$gender[is.na(df3$gender)] <- 'M'# replacing NA with M
df3
df3$rpgm[is.na(df3$rpgm)] <- mean(df3$rpgm,na.rm=T)#replacing NA with mean of rpgm
df3$excel[is.na(df3$excel)] <- mean(df3$excel,na.rm=T)#replacing NA with mean of excel
df3$sql[is.na(df3$sql)] <- mean(df3$sql,na.rm=T)#replacing NA with mean of sql
df3$stats[is.na(df3$stats)] <- mean(df3$stats,na.rm=T)#replacing NA with mean of stats
sum(is.na(df3))
str(df3)
df3
# creating df3a for summary like sum,mean,median in one dataframe
df3a <- df3[11:14]#creating df3a
rownames(df3a) <- df3$rollno# putting rollno as row names
df3a
addmargins(as.table(as.matrix(df3a)),c(2,1,1),list(sum,mean,median))#addmargins to create row sum,column means,medians
#creating course vs gender summary & proportion tables
t1 <- table(df3$course,df3$gender)
addmargins(t1)#summary of course vs gender
prop.table(t1)#proportions of course-gender table
#Grade function & Rank
df3c <- df3[,c(1,2,11,12,13,14)]# creating dataframe df3c having rollno,names & subject marks
df3c
df3c$total <- rowMeans(df3c[,c(3:6)])#creating total column
df3c
grades <- function(x){
  if (x > 70){
    print('A')
  } else if (x >= 60 & x <= 70){
    print('B')
  } else {
    print('C')
  }
}# creating function for grades
for (i in c(1:12)){
  df3c$grade[i] <- grades(df3c$total[i])# for loop for giving grades according to avg. marks per row
}
df3c
df3c$ranks <- rank(-df3c$total)#rank 1 to largest total marks
df3c
df3c$name[df3c$ranks==5]#gives Shruti Sinha-5th rank holder
df3
#Rowwise & Columnwise means-Pending
df4 <- df3[,c(3,11,12,13,14)]
df4

#split wrt course,wrt gender-hostel
split(df3[1:3],df3$course)#split according to course
split(df3[1:3],list(df3$gender,df3$hostel))#split wrt gender-hostel
#adding bigdata marks and scaling
bigdata <- ceiling(runif(12,100,150))
bigdata
df3d <- df3#creating new dataframe - df3d
df3d
df3d$bigdata <- bigdata#adding bigdata to df3d
df3d
?scale
df3d$bigdataS <- scale(df3d$bigdata,center=F)#scaling bigdata marks
df3d
#creating barplot
df3e <- df3d[,c('rpgm','excel','sql','stats','bigdata')]
df3e
g1 <- colMeans(df3e)
barplot(g1,main = 'Average Marks',ylim=c(0,140))#barplot of average marks
