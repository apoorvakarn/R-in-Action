#SGN
#K-Means Clustering Project


#SGN
rm(list = ls())

##############################################################################################
###### Build an analytical model to create clusters of airline travellers ####################
##############################################################################################

#---------------------Step1: Loading the Data in R
Path<-setwd("C:/Ganesha_Accenture/Ganesha_IVY/R/20180112-20180114 Ivy Data Science Hackshop/03 CLUSTERING/CASE STUDY1/02DATA")
airlines<-read.csv("AirlinesCluster.csv", header = TRUE, as.is = TRUE, na.strings = c(""))


#Understand the data type and summary of each coloumn
str(airlines)
summary(airlines)


#Checking missing values
as.data.frame(colSums(is.na(airlines)))



#Normalizing the Data for clustering 
preproc<-preProcess(airlines)
airlinesNorm<-predict(preproc,airlines)
summary(airlinesNorm)


#Hiearchical Clustering
distan<-dist(airlinesNorm, method = "euclidean")
ClusterAirline<-hclust(distan, method = "ward.D")
plot(ClusterAirline)


#Assigning points to the clusters
AirlineCluster<-cutree(ClusterAirline, k = 5)
table(AirlineCluster)

#Computing the average values of the cluster groups
MeanComp<-function(var, clustergrp, meas){
  z<-tapply(var, clustergrp, meas)
  print(z)
}

Bal_mean<-MeanComp(airlines$Balance, AirlineCluster, mean)


#k-Means Clustersing
set.seed(88)
k<-5
AirlineCluster_K<-kmeans(airlinesNorm, centers = k, iter.max = 1000)
table(AirlineCluster_K$cluster)
AirlineCluster_K$centers
