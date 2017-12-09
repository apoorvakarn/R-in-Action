# cast & melt
set.seed(1234)
(rollno = rep(c(10,11,12,13),4))
(sname = rep(c("achal","aporva","goldie","hitesh"),4))
(examunit = rep(c("u1","u2","u3","u4"),each=4))
(rpgm = rnorm(16,60,10))
set.seed(1234)
(rpgm= ceiling(rnorm(4*4,60,10)))
set.seed(1234)
(sql= ceiling(rnorm(4*4,65,10)))
df1=data.frame(rollno,sname,examunit,rpgm,sql)
df1 #16 rows, 4 students,4units, 2 subjects

# melt the data : wide to long(more rows)
install.packages("reshape")
library(reshape)
md= reshape::melt(df1,id=c("rollno","sname","examunit")) 
head(md)
md
md[md$rollno==11,]
summary(md)
md

#without aggregation ----
reshape::cast(md,rollno + sname + examunit ~ variable)
reshape::cast(md,rollno + variable ~ examunit)
reshape::cast(md,rollno + sname + variable ~ examunit) # list type
reshape::cast(md,rollno + sname ~ variable ~ examunit)

# better way to do it
md2 = melt(df1,id.vars = c("rollno","sname","examunit"),measure.vars = c("rpgm","sql"),variable.name = "subject",value.name="marks" )
md2
head(md2) # with proper labelling

reshape::cast(md2,rollno + sname ~ subject, sum)

