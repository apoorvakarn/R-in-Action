# Data Handling on Student Data

# Read File ------
df1 = read.csv(file='./data/dsstudents2.csv')
str(df1)
dim(df1)
names(df1)

# start from here -------
cat(names(df1))
colcls =c('numeric', NA, 'factor', 'factor', 'logical', 'character','numeric',
          'character', 'character' ,'factor', rep('numeric',4)      )
length(colcls)
df2 = read.csv(file='./data/dsstudents2.csv', 
               colClasses = colcls, as.is= T)  # asis for name
str(df2)

# now data structure seems to be alright

#date column
as.Date('1967-20-15') #wrong
as.Date('1967-10-15') #right default %y-%b-%d : learn this
?date
as.Date('05-oct-1967',format="%d-%b-%Y") #this is correct
as.Date('05-oct-67',format="%d-%b-%y") # this is also correct :year without century
as.Date('05-oct-1967',format="%d-%b-%Y") #this is also correct :year with century

(df2$dob = as.Date(df2$dob,format= "%d-%b-%y"))
str(df2$dob)

 # add another column ---calculate age
Sys.Date()-df2$dob # days -> age : numeric values - days : diff in weeks ->years
difftime(Sys.Date(),df2$dob,unit ='weeks')
(df2$age =ceiling(as.numeric(difftime(Sys.Date(),df2$dob,unit = "weeks"))/52.25))
head(df2$age)

#filter
df2$age>30 # by age
df2[df2$age>30,][1:2]# [1:2] means first two columns,otherwise it will give logical ans

df2[df2$gender == 'M' & df2$course =="PGDDS",][1:2]


