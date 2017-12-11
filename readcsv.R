# Data Science Students Sample Data
?read.csv
# Read From CSV File
getwd()
#file.show()
df1= read.csv(file = './files(R)/dsstudents.csv')
df1
str(df1)
df2= read.csv(file = './files(R)/dsstudents.csv', stringsAsFactors = F)
df2
str(df2)
head(df2)[1:4]

head(df2)[3:4]
df2$gender= factor(df2$gender)
df2$gender
df2$course= factanal(df2$course)
df2$course
table(df2$course,df2$gender)
df2[c('name','gender')] #display name & gender
names(df2) #column names/attributes/variables
row.names(df2)
df2$rollno[df2$rollno== 170113] = 17013 #change rol no from .. to ...
df2$rollno #check roll no column

df2$name[df2$name== "Lalit Sahni"] = 17013 #check by name
df2$name = 
df2$name== "Lalit Sahni"
df2$name
fix(df2) #edit data frame and save back 
