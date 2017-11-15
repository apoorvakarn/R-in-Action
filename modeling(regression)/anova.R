sup1 = c(18.5,24,17.2,19.9,18)
sup2 = c(26.3,25.3,24,21.2,24.5)
sup3 = c(20.6,25.2,20.8,24.7,22.9)
sup4 = c(25.4,19.9,22.6,17.5,20.4)
#create dataframe----
df = data.frame(sup1,sup2,sup3,sup4)
df
colMeans(df)
colSums(df)
addmargins(as.matrix(df,c(1,2),FUN = list(list(mean,sd,length),list(length))))
(dfstack= stack(df))                                                       
unstack(stack(df))
str(dfstack)
aggregate(dfstack$values,by=list(dfstack$ind),FUN=mean)#mean against each group
aggregate(dfstack$values,by=list(dfstack$ind),FUN = sd)#sd against each group
(fit2w = aov(values~ind, data=dfstack))
(summary(fit2w))
qf(p = 0.95, df1 = 3, df2 = 16)# calculate f statistics
boxplot(dfstack$values)
boxplot(df)
boxplot(values~ind,data = dfstack)
gplots::plotmeans(values~ind, data= dfstack)
abline(h = 19.52)
abline(h = colMeans(df))
#from the graphs we can say that means are not same
TukeyHSD(fit2w)
plot(TukeyHSD(fit2w))
# there is a large difference between sup2 nd sup1,from graph we can say that
library(multcomp)
tuk = glht(fit2w,linfct= mcp(ind = "Tukey"))#glht --> general linear hypothesis
tuk
plot(cld(tuk,level = 0.05))
car::qqPlot(fit2w, simulate= T, labels = F)# check the normality of dependent variables
bartlett.test(values ~ ind , data =  dfstack)#test of homogeneity of variances
car::outlierTest(fit2w)

