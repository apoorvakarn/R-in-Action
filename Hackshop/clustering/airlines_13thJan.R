#SGN
#K-Means Clustering Project----
#setting path
getwd()
setwd("C:/rWork/rProjects/R-in-Action/Hackshop")
airlines=read.csv("AirlinesCluster.csv", header = TRUE, as.is = TRUE, na.strings = c(""))
#Understand the data type and summary of each coloumn----
str(airlines)
summary(airlines)#max balance(1704838),min flight trans(53.00)
min(airlines)
max(airlines)
#Checking missing values----
as.data.frame(colSums(is.na(airlines)))
#Normalizing the Data for clustering----
install.packages("reshape2")
library(caret)
preproc<-preProcess(airlines)
airlinesNorm<-predict(preproc,airlines)
summary(airlinesNorm)             
#Hiearchical Clustering----
distance<-dist(airlinesNorm, method = "euclidean")
ClusterAirline<-hclust(distance, method = "ward.D")#hclust= hierachical clustering 
plot(ClusterAirline)
#Assigning points to the clusters----
AirlineCluster<-cutree(ClusterAirline, k = 5)
table(AirlineCluster)
#Computing the average values of the cluster groups----
MeanComp<-function(var, clustergrp, meas){
  z<-tapply(var, clustergrp, meas)
  print(z)
}

Bal_mean<-MeanComp(airlines$Balance, AirlineCluster, mean)
Bal_daysSinceEnroll<-MeanComp(airlines$DaysSinceEnroll,AirlineCluster,mean)

#k-Means Clustersing----
set.seed(88)
k<-5
AirlineCluster_K<-kmeans(airlinesNorm, centers = k, iter.max = 1000)
table(AirlineCluster_K$cluster)
AirlineCluster_K$centers
#Appending the Clusters Assignment
Airlines_H<-data.frame(airlines,AirlineCluster)
write.csv(Airlines_H,"Airlines_Hierarchical.csv", row.names = FALSE)

#finding out the mean values of the variable in cluster----
Bal_mean_k = aggregate(airlines,by=list(AirlineCluster_K$cluster),mean)
Bal_mean_k

