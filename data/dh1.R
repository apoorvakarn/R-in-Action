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
df2[df2$age>30,c(1,2,3)]

df2[df2$gender == 'M' & df2$course =="PGDDS",][1:2]
df2[df2$gender == 'M' & df2$course =="PGDDS",c('rollno','name')]
df2[df2$gender == 'M' & df2$course =="PGDDS",c(1,2)]

summary(df2)


# Save Data
write.csv(x=df2,file = './data/apoorva.csv') # save to csv
# you can save to other formats using other tools/options
?write.csv
saveRDS(object = df2,file = './data/ak.RDS') # only 1 object at a time
markstotal = runif(11,50,150)
save(markstotal,df2,file = './data/ak2.RData') #save multiple objects in R
markstotal
round(markstotal)
save.image(file = './data/ak3.RData') #save all current objects/multiple objects
save.image()#save to default RData


#load objects from saved locations
#from CSV
#from RDS
readRDS(file = './data/ak.RDS') #loads and prints
mydata = readRDS(file='./data/ak.RDS') #save it into object
#load() # for data in R.Data this happens automatically
load(file ='./data/ak2.RData')
load(file ='./data/ak3.RData')

#[1:2] # by course & gender

#find from indices
df2[df2$hostel==T,][1:2] #stay in hostel
which(df2$hostel==T) # using which command tells indices
df2[which(df2$hostel ==T),][c(1,2,4,5)] # in hostel
df2[which(!df2$hostel ==T),][c(1,2,4,5)] # not in hostel
df2[which(df2$hostel ==F),][c(1,2,4,5)] # not in hostel
df2[which(!df2$hostel ==T)]

aggregate(cbind(df3$fees,df3$excel), list(DScourse,gender=df3$gender),sum)
cat(names(df3))
split(df3[1:3],df3$gender)
class(split(df3[1:3],df3$gender))
split(df3[1:3],df3$gender)$F


# lag
v1= (1:20)
v1
diff(v1,2)
diff(v1,5)
v2 = seq(10,50,10)
v2
trunc(4.2)
round(4.2)
sqrt(4)
sqrt(57587745)
