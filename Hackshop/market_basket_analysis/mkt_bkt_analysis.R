library(arules)#association rules
library(arulesViz)#association rules visualisation
library(datasets)
data("Groceries")
Groceries
itemFrequencyPlot(Groceries,topN=20,type="absolute")
inspect(Groceries)
frequentitems=eclat(Groceries,parameter = list(supp=0.07,maxlen=8))
rules= apriori(Groceries,parameter = list(supp=0.001,conf=0.5))
rules
inspect(rules[1:5])
quality(rules)
(rulesc=sort(rules, by='confidence',decreasing = TRUE))
(rulesl=sort(rules, by='lift',decreasing = TRUE))
inspect(rulesl[1:5])
#find what factors influenced an event 'x'
rules=apriori(data=Groceries, parameter = list(supp=0.001,conf=0.08),appearance = list(default='rhs',lhs='whole milk'),control = list(verbose=F))
inspect(rules[1:20])
#find out what events were influenced by a given amount
plot(rules,method="graph",engine="interactive",shading=NA)
