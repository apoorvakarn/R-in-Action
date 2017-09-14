#13 sept 2017
# sort......
df2
sort(df2$age)
df2$name[order(df2$age)] # sort by age;display names
df2$name[order(-df2$age)] # sort by descending age;display names# avoid
df2[order(df2$age),c("name","age")]
df2$name[rev(order(df2$age))] # right way of doing descending age
df2[order(df2$age),1:4][c(1,4,5),]
df2[order(df2$hostel,df2$age),c('name','age','hostel')] #hostel,age
df2[order(df2$hostel,-df2$age),c('name','age','hostel')]#hostel, rev age

# hostel ascending,age descending
df2[order(df2$fees,decreasing = T),c('name','age','fees')] #fee descending
df2[order(df2$fees,decreasing = F),c('name','age','fees')] #fee ascending
df2$name[1]
df2$fees[4]