# Margin Tables

parties1 = c('BJP',"Congress","SP","AAP")
length(parties1)
states1 = c('UP','Delhi','Haryana','Punjab','UK')
length(states1)
set.seed(1234)
mp=ceiling(runif(20,25,50))
sum(mp)

df=data.frame(parties1,states1,mp)
df
(col1 = rep(parties1,each=5))
(col2 = rep(states1,times =4))  
length(col2)

length(col1)
cbind(col1,col2)

party = factor(col1)
state = factor(col2)
df1 = data.frame(party,state,mp)
df1
table(df1) #not relevant here
ftable(df1)# table will work for one vector

tabulate(df1$col1) #one coloumn factor type

#table(df1)
table(df1$party)

table(df1$state)
table(df1[,c('party','state')])
table(df1[,c('party','state')], dnn= list('Political Parties','States Of India'))

# Formula Method
xtabs(mp ~ party+state, data=df1) #formula method # row party, column state
statesel = c('UP','Delhi') #vector of same names (few)
xtabs(mp ~ party+state, data = df1, subset= state %in% statesel)
xtabs(mp ~ party+state, data = df1, subset= state %in% statesel, drop.unused.levels = T)
partysel = c("BJP","AAP")
xtabs(mp~ party + state , data = df1, subset = party %in% partysel)
xtabs(mp~ party + state , data = df1, subset = party %in% partysel & state %in% statesel  , drop.unused.levels = T)
xtabs(mp~ party + state , data = df1, subset = party %in% partysel, drop.unused.levels = T)

ftable(df1) # where they fought and won # f means frequency

#Margins--------------
matresults = xtabs(mp ~ party+state, data=df1) # row parties, column states
matresults

?margin.table
str(matresults)
margin.table(matresults,margin = NULL) # total mp 
margin.table(matresults,margin = 1) # total mp in party rows
margin.table(matresults,margin = 2) # total mp in state columns
addmargins(matresults,1,sum)

addmargins(matresults,2,sum)
# if matresults was an array :dimensions=3
margin.table(matresults,margin = 3) # error here

#proportion table----
prop.table(matresults,margin = NULL) # proportion of total
round(prop.table(matresults,margin = NULL),2) #proportion of total--- upto two decimal
sum(round(prop.table(matresults,margin = NULL),2)) #proportion of total ----sum
p1=round(prop.table(matresults,margin = 1),2)
p1
rowSums(p1)
p2=round(prop.table(matresults,margin = 2),2)
p2
colSums(p2)


addmargins(p2)
addmargins(p2,1)
addmargins(p2,2)
addmargins(p2,1,sum)
rowSums(p2) # not equal to 1
