#giving labels
classint1b=cut(marks, breaks=bks,include.lowest = T,labels = LETTERS[1:length(bks)-1])
as.character(head(classint1b,n=5))

#LETTERS[1:5];letters[1:8];month.abb[1:5]
x1=c(0,2,5,1,3,10,14,5,15,16,20)
x1
cut(x1,breaks = 4,include.lowest = T)
