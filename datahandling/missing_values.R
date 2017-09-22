# Missing Values
df= read.csv(file ='./datahandling/dsstudents2.csv')
df
str(df)
summary(df)
is.na(df)
anyNA(df)
table(is.na(df))
all(is.na(df))
all(is.na(df)==F)
all(is.na(df)==F | is.na(df)==T)
complete.cases(df)
!complete.cases(df)
sum(complete.cases(df))
sum(!complete.cases(df))
df[complete.cases(df),][1:2] #list the rollno and name of rows which are completed
mean(df$excel)
mean(df$excel,na.rm = T) #na.rm = remove "na" values
mean(df$excel,na.rm = T, trim=.2) # trim helps in trimming atleast 20% of values from starting or from end
mean(df$excel,na.rm = T, trim=.4) # trim atleast 40% of values on either side
cat(df$excel,trim=.2)
df$excel
na.omit(df$excel)
na.omit(df)
na.omit(df)[1:2] #omitting the any row which contains na values
colSums(is.na(df)) #aply to numeric m, df
apply(df,2,function(x) sum(is.na(x)))
apply(is.na(df), 2, sum)
length(which(is.na(df['excel']==T)))
sum(is.na(df$excel))
mean(df$excel,na.rm = T)
df$excel
df$excel[is.na(df$excel)] = mean(df$excel,na.rm = T)
df$excel
df$sql
df$stats
max(df$stats)
df$sql[is.na(df$sql)] = max(df$stats)# substituted stats highest marks in sql's na
df$sql
na_count <-sapply(df,function(y)sum(length(which(is.na(y)))))
df
(na_count=data.frame(na_count))
