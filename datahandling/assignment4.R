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
df3a=read.csv(file = './datahandling/dsstudents2.csv',colClasses = colcls, as.is = T)
df3a

colcls =c('numeric', NA, 'factor', 'factor', 'logical', 'character','numeric',
          'character', 'character' ,'factor', rep('numeric',4))
length(colcls)
is.na(df3) #find na values in dataset
anyNA(df3) # if true(dataset contains na values)
table(is.na(df3)) #gives the number of na values
all(is.na(df3)) #if false(not all values are na)
# finding age and creating new column for that
df3a$dob= as.Date(df3a$dob,format = "%d-%b-%y")
class(df3a$dob)
difftime(Sys.Date(),df3a$dob,unit = "weeks")
df3a$age= ceiling(as.numeric(difftime(Sys.Date(),df3a$dob,unit = "weeks"))/52.5)
df3a$age
str(df3a$age)

# missing values
complete.cases(df3a)
all(is.na(df3a))
all(is.na(df)==F) 
all(is.na(df3a)==F | is.na(df3a)==T)
sum(complete.cases(df3a)) # complete cases
sum(!complete.cases(df3a)) #incomplete cases
df3a[complete.cases(df3a),][1:2] #name and rollno of complete cases
df3a[!complete.cases(df3a),][1:2] #name and rollno of incomplete cases
# removing na values with mean
mean(df3a$excel)
mean(df3a$excel,na.rm = T) # remove na values from excel column
mean(df3a$excel,na.rm = T, trim=.2)
cat(df3a$excel,trim=.2)
df3a$excel
df3a$excel[is.na(df3a$excel)]= mean(df3a$excel,na.rm = T)
df3a$excel
 # removing na values with mean in sql
mean(df3a$sql)
mean(df3a$sql,na.rm = T)
df3a$sql
df3a$sql[is.na(df3a$sql)]= mean(df3a$sql,na.rm = T)
df3a$sql
# removing na values from fee
df3a$fees
median(df3a$fees)
median(df3a$fees,na.rm = T)
df3a$fees[is.na(df3a$fees)] = median(df3a$fees , na.rm = T)
df3a$fees
#removing na values from hostel
df3a$hostel
median(df3a$hostel)
median(df3a$hostel, na.rm = T)
df3a$hostel[is.na(df3a$hostel)] = median(df3a$hostel, na.rm = T)
df3a$hostel
 # adding up a new row
df= data.frame(17000,"Ramesh Singh","MSC",NA,"TRUE","1994-10-17", 50000,"ramesh@gmail.com", NA,"Delhi",NA,NA,NA,NA,NA)
names(df)= c("rollno" ,"name" ,  "course", "gender", "hostel", "dob" ,  
              "fees" ,  "email",  "mobno" , "city"  , "rpgm" ,  "excel" ,
              "sql"  ,  "stats",  "age") 
colnames(df3a)
ncol(df3a)
ncol(df)
df4=rbind(df3a,df)
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
# creating another table

