# SORTING

#sort order rank

set.seed(1123)
marks= ceiling(runif(11,5,10))
marks
#sort marks
sort(marks)
sort(-marks)# wrong (doesn't work here)
sort(marks,decreasing = T)
rev(sort(marks))
# NA values and sort later

#order
order(marks) #indices
marks
marks[c(6,7,10)]
marks[order(marks)] #similar to sort(x)
order(marks,decreasing = T)
order(-marks) #decreasing

length(marks)
marks2=marks
marks2[5] = NA #check with NA value  :display,position 
marks2
order(marks2) # NA is last
?order
order(marks2,na.last = NA) # removed
length(marks2) # length is same
is.na(marks2) #logical vector if NA
anyNA(marks2) # is there any NA

mean(marks2) #doesn't work with NA values
mean(marks2, na.rm = T) # add na.rm=T
order(marks2, na.last = F) # 5 is first
order(marks2,na.last = NA) # NA is removed
order(marks2,na.last = T) # 5 is last
length(order(marks2,na.last = T))

?rank
marks #10-3 times , 8 & -2 times
table(marks)
rank(marks,ties.method = "first") #2-6s-5
#6-1,6-2,7-3,8-4,8-5,9-6,9-7,10-8,10-9,10-11
rank(marks,ties.method = 'average') # default 2-6's -5
#all 6's :(1+2)/2 = 3/2 =1.5 ; (8+9+10+11)/4 = 38/4 = 9.5
rank(marks,ties.method = 'max') # 2 6's -7
#two 6 -1,2 -> (max): four 10s -8,9,10,11 -> 11
rank(marks,ties.method = 'random') # put them in unique order


# NA values -sort and rank
sort(marks2, na.last = T)
sort(marks2, na.last = F)

rank(marks2, na.last = T)
rank(marks2, na.last = F)

#14sept17
#sorting
df2
