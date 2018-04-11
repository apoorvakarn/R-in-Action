#ad_org
getwd()
ad_org_train=read.csv("C:/rWork/rProjects/R-in-Action/analytics/vidooly_analytics/vidooly_ad.csv",stringsAsFactors = FALSE)
str(ad_org_train)

#Working with train data
colSums(is.na(ad_org_train)) #Checking for NA values

#Replacing 'F' with NA
for (i in 1:14999){
  for(j in 2:6){
    if(ad_org_train[i,j]=='F'){
      ad_org_train[i,j]=NA;
    }
  }
} 

#Converting required columns into integer
for (k in 3:6)
{
  ad_org_train[,k]=as.integer(ad_org_train[,k])
}

#Replacing NA values with median
ad_org_train$views[is.na(ad_org_train$views)]=median(ad_org_train$views,na.rm=T)
ad_org_train$likes[is.na(ad_org_train$likes)]=median(ad_org_train$likes,na.rm=T)
ad_org_train$dislikes[is.na(ad_org_train$dislikes)]=median(ad_org_train$dislikes,na.rm=T)
ad_org_train$comment[is.na(ad_org_train$comment)]=median(ad_org_train$comment,na.rm=T)

#Video duration given in text format
#We intend to get the duration in terms of seconds from the 'duration' column
for (i in 1:nrow(ad_org_train))
{
  if((grepl('H',ad_org_train$duration[i])==TRUE) & (grepl('M',ad_org_train$duration[i])==TRUE) & (grepl('S',ad_org_train$duration[i])==TRUE))
  {
    ad_org_train$hour[i]=substr(ad_org_train$duration[i],regexpr('T',ad_org_train$duration[i])+1,regexpr('H',ad_org_train$duration[i])-1);
    ad_org_train$min[i]=substr(ad_org_train$duration[i],regexpr('H',ad_org_train$duration[i])+1,regexpr('M',ad_org_train$duration[i])-1);
    ad_org_train$sec[i]=substr(ad_org_train$duration[i],regexpr('M',ad_org_train$duration[i])+1,regexpr('S',ad_org_train$duration[i])-1);
  }
  else if((grepl('H',ad_org_train$duration[i])==FALSE) & (grepl('M',ad_org_train$duration[i])==TRUE) & (grepl('S',ad_org_train$duration[i])==TRUE))
  {
    ad_org_train$hour[i]=0;
    ad_org_train$min[i]=substr(ad_org_train$duration[i],regexpr('T',ad_org_train$duration[i])+1,regexpr('M',ad_org_train$duration[i])-1);
    ad_org_train$sec[i]=substr(ad_org_train$duration[i],regexpr('M',ad_org_train$duration[i])+1,regexpr('S',ad_org_train$duration[i])-1);
  }
  else if((grepl('H',ad_org_train$duration[i])==FALSE) & (grepl('M',ad_org_train$duration[i])==FALSE) & (grepl('S',ad_org_train$duration[i])==TRUE))
  {
    ad_org_train$hour[i]=0;
    ad_org_train$min[i]=0;
    ad_org_train$sec[i]=substr(ad_org_train$duration[i],regexpr('T',ad_org_train$duration[i])+1,regexpr('S',ad_org_train$duration[i])-1);
  }
  else if((grepl('H',ad_org_train$duration[i])==TRUE) & (grepl('M',ad_org_train$duration[i])==TRUE) & (grepl('S',ad_org_train$duration[i])==FALSE))
  {
    ad_org_train$hour[i]=substr(ad_org_train$duration[i],regexpr('T',ad_org_train$duration[i])+1,regexpr('H',ad_org_train$duration[i])-1);
    ad_org_train$min[i]=substr(ad_org_train$duration[i],regexpr('H',ad_org_train$duration[i])+1,regexpr('M',ad_org_train$duration[i])-1);
    ad_org_train$sec[i]=0;
  }
  else if((grepl('H',ad_org_train$duration[i])==TRUE) & (grepl('M',ad_org_train$duration[i])==FALSE) & (grepl('S',ad_org_train$duration[i])==FALSE))
  {
    ad_org_train$hour[i]=substr(ad_org_train$duration[i],regexpr('T',ad_org_train$duration[i])+1,regexpr('H',ad_org_train$duration[i])-1);
    ad_org_train$min[i]=0;
    ad_org_train$sec[i]=0;
  }
  else if((grepl('H',ad_org_train$duration[i])==FALSE) & (grepl('M',ad_org_train$duration[i])==TRUE) & (grepl('S',ad_org_train$duration[i])==FALSE))
  {
    ad_org_train$hour[i]=0;
    ad_org_train$min[i]=substr(ad_org_train$duration[i],regexpr('T',ad_org_train$duration[i])+1,regexpr('M',ad_org_train$duration[i])-1);
    ad_org_train$sec[i]=0;
  }
  else if((grepl('H',ad_org_train$duration[i])==TRUE) & (grepl('M',ad_org_train$duration[i])==FALSE) & (grepl('S',ad_org_train$duration[i])==TRUE))
  {
    ad_org_train$hour[i]=substr(ad_org_train$duration[i],regexpr('T',ad_org_train$duration[i])+1,regexpr('H',ad_org_train$duration[i])-1);
    ad_org_train$min[i]=0;
    ad_org_train$sec[i]=substr(ad_org_train$duration[i],regexpr('H',ad_org_train$duration[i])+1,regexpr('S',ad_org_train$duration[i])-1);
  }
}
#We get three columns - 'hour', 'minutes', and 'seconds' -> depicting video duration
#Converting hour, mins and secs into integer for further calculations
for (j in 10:12)
{
  ad_org_train[,j]=as.integer(ad_org_train[,j])
}

#We convert the three columns into a single duration column 'durationnew'
(ad_org_train$durationnew=(ad_org_train$hour*3600)+(ad_org_train$min*60)+(ad_org_train$sec))

#Changing 'category' column into factor
ad_org_train$category=as.factor(ad_org_train$category)

#Copying the dataframe into 'train' dataframe for further analysis
train=ad_org_train

#Boxplots show huge skewness in data and presence of outliers
boxplot(train$views)
boxplot(train$likes)
boxplot(train$dislikes)
boxplot(train$comment)
boxplot(train$durationnew)

#Replacing outliers with median
V=c(3,4,5,6,13)
for(j in c(3,4,5,6,13))
{
  out1=(quantile(train[,j],0.25))-(1.5*IQR(train[,j]))
  out2=(quantile(train[,j],0.75))+(1.5*IQR(train[,j]))
  for (i in 1:nrow(train))
  {
    if((train[i,j]<out1) | (train[i,j]>out2))
    {
      train[i,j]=median(train[,j])
    }
  }
}

#Outliers removed, data much improved than before
boxplot(train$views)
boxplot(train$likes)
boxplot(train$dislikes)
boxplot(train$comment)
boxplot(train$durationnew)

#Converting required columns of train into integer type
for (i in c(3,4,5,6,13))
{
  train[,i]=as.integer(train[,i])
}

#Converting category into factor
train$category=as.factor(train$category)


#To fit Random Forest, we would like to convert the continuous independent variables into categorical variables
#We divide each variable into 5 categories - 1,2,3,4,5
#views2 = categorical variable of 'views'
for (i in 1:nrow(train))
{
  if((train[i,3]>=49) & (train[i,3]<=282943))
  {
    train[i,14]=1;
  }
  if((train[i,3]>=282944) & (train[i,3]<=565837))
  {
    train[i,14]=2;
  }
  if((train[i,3]>=565838) & (train[i,3]<=848731))
  {
    train[i,14]=3;
  }
  if((train[i,3]>=848732) & (train[i,3]<=1131625))
  {
    train[i,14]=4;
  }
  if((train[i,3]>=1131626) & (train[i,3]<=1414521))
  {
    train[i,14]=5;
  }
}
#duration2=categorical variable of durationnew
for (i in 1:nrow(train))
{
  if((train[i,13]>=0) & (train[i,13]<=308))
  {
    train[i,15]=1;
  }
  if((train[i,13]>=309) & (train[i,13]<=617))
  {
    train[i,15]=2;
  }
  if((train[i,13]>=618) & (train[i,13]<=926))
  {
    train[i,15]=3;
  }
  if((train[i,13]>=927) & (train[i,13]<=1235))
  {
    train[i,15]=4;
  }
  if((train[i,13]>=1236) & (train[i,13]<=1541))
  {
    train[i,15]=5;
  }
}

#likes2 = categorical variable for 'likes'
for (i in 1:nrow(train))
{
  if((train[i,4]>=0) & (train[i,4]<=881))
  {
    train[i,16]=1;
  }
  if((train[i,4]>=882) & (train[i,4]<=1763))
  {
    train[i,16]=2;
  }
  if((train[i,4]>=1764) & (train[i,4]<=2645))
  {
    train[i,16]=3;
  }
  if((train[i,4]>=2646) & (train[i,4]<=3527))
  {
    train[i,16]=4;
  }
  if((train[i,4]>=3528) & (train[i,4]<=4403))
  {
    train[i,16]=5;
  }
}
#dislikes2 = categorical variable of dislikes
summary(train$dislikes)
for (i in 1:nrow(train))
{
  if((train[i,5]>=0) & (train[i,5]<=81))
  {
    train[i,17]=1;
  }
  if((train[i,5]>=82) & (train[i,5]<=163))
  {
    train[i,17]=2;
  }
  if((train[i,5]>=164) & (train[i,5]<=245))
  {
    train[i,17]=3;
  }
  if((train[i,5]>=246) & (train[i,5]<=327))
  {
    train[i,17]=4;
  }
  if((train[i,5]>=328) & (train[i,5]<=404))
  {
    train[i,17]=5;
  }
}
#comment2 = categorical variable for comment
summary(train$comment)
for (i in 1:nrow(train))
{
  if((train[i,6]>=0) & (train[i,6]<=105))
  {
    train[i,18]=1;
  }
  if((train[i,6]>=106) & (train[i,6]<=211))
  {
    train[i,18]=2;
  }
  if((train[i,6]>=212) & (train[i,6]<=317))
  {
    train[i,18]=3;
  }
  if((train[i,6]>=318) & (train[i,5]<=423))
  {
    train[i,18]=4;
  }
  if((train[i,6]>=424) & (train[i,6]<=525))
  {
    train[i,18]=5;
  }
}
#Naming the new columns
colnames(train)[14]="views2"
colnames(train)[15]="duration2"
colnames(train)[16]="likes2"
colnames(train)[17]="dislikes2"
colnames(train)[18]="comment2"

#Converting the new columns into factors
for(i in 14:18)
{
  train[,i]=factor(train[,i],levels=c(1,2,3,4,5))
}
#Final check of the structure of train dataframe
str(train)
save(train,file="train.RDS") #Saving the train dataset into an R object


#We fit a Random Forest into the train dataset
library(randomForest)
fit1=randomForest(adview~views2+duration2+likes2+dislikes2+comment2+category,data=train)
fit1
s=varImpPlot(fit1)#'category' comes least important, so we remove it from the model

fit2=randomForest(adview~views2+duration2+likes2+dislikes2+comment2,data=train)
fit2#Final model

#Now we will work on the test dataset 
ad_org_test=read.csv("C:/rWork/rProjects/R-in-Action/analytics/vidooly_analytics/ad_test_data.csv",stringsAsFactors = FALSE)
str(ad_org_test)
colSums(is.na(ad_org_test))

#Changing 'F' present in the columns into NA
for (i in 1:nrow(ad_org_test)){
  for(j in 2:5){
    if(ad_org_test[i,j]=='F'){
      ad_org_test[i,j]=NA;
    }
  }
}

#Converting required columns into numeric
for (k in 2:5){
  ad_org_test[,k]=as.numeric(ad_org_test[,k])
}

#Replacing NAs with median
ad_org_test$views[is.na(ad_org_test$views)]=median(ad_org_test$views,na.rm=T)
ad_org_test$likes[is.na(ad_org_test$likes)]=median(ad_org_test$likes,na.rm=T)
ad_org_test$dislikes[is.na(ad_org_test$dislikes)]=median(ad_org_test$dislikes,na.rm=T)
ad_org_test$comment[is.na(ad_org_test$comment)]=median(ad_org_test$comment,na.rm=T)

#Obtaining 'durationnew' variable for test dataset
for (i in 1:nrow(ad_org_test))
{
  if((grepl('H',ad_org_test$duration[i])==TRUE) & (grepl('M',ad_org_test$duration[i])==TRUE) & (grepl('S',ad_org_test$duration[i])==TRUE))
  {
    ad_org_test$hour[i]=substr(ad_org_test$duration[i],regexpr('T',ad_org_test$duration[i])+1,regexpr('H',ad_org_test$duration[i])-1);
    ad_org_test$min[i]=substr(ad_org_test$duration[i],regexpr('H',ad_org_test$duration[i])+1,regexpr('M',ad_org_test$duration[i])-1);
    ad_org_test$sec[i]=substr(ad_org_test$duration[i],regexpr('M',ad_org_test$duration[i])+1,regexpr('S',ad_org_test$duration[i])-1);
  }
  
  else if((grepl('H',ad_org_test$duration[i])==FALSE) & (grepl('M',ad_org_test$duration[i])==TRUE) & (grepl('S',ad_org_test$duration[i])==TRUE))
  {
    ad_org_test$hour[i]=0;
    ad_org_test$min[i]=substr(ad_org_test$duration[i],regexpr('T',ad_org_test$duration[i])+1,regexpr('M',ad_org_test$duration[i])-1);
    ad_org_test$sec[i]=substr(ad_org_test$duration[i],regexpr('M',ad_org_test$duration[i])+1,regexpr('S',ad_org_test$duration[i])-1);
  }
  else if((grepl('H',ad_org_test$duration[i])==FALSE) & (grepl('M',ad_org_test$duration[i])==FALSE) & (grepl('S',ad_org_test$duration[i])==TRUE))
  {
    ad_org_test$hour[i]=0;
    ad_org_test$min[i]=0;
    ad_org_test$sec[i]=substr(ad_org_test$duration[i],regexpr('T',ad_org_test$duration[i])+1,regexpr('S',ad_org_test$duration[i])-1);
  }
  else if((grepl('H',ad_org_test$duration[i])==TRUE) & (grepl('M',ad_org_test$duration[i])==TRUE) & (grepl('S',ad_org_test$duration[i])==FALSE))
  {
    ad_org_test$hour[i]=substr(ad_org_test$duration[i],regexpr('T',ad_org_test$duration[i])+1,regexpr('H',ad_org_test$duration[i])-1);
    ad_org_test$min[i]=substr(ad_org_test$duration[i],regexpr('H',ad_org_test$duration[i])+1,regexpr('M',ad_org_test$duration[i])-1);
    ad_org_test$sec[i]=0;
  }
  else if((grepl('H',ad_org_test$duration[i])==TRUE) & (grepl('M',ad_org_test$duration[i])==FALSE) & (grepl('S',ad_org_test$duration[i])==FALSE))
  {
    ad_org_test$hour[i]=substr(ad_org_test$duration[i],regexpr('T',ad_org_test$duration[i])+1,regexpr('H',ad_org_test$duration[i])-1);
    ad_org_test$min[i]=0;
    ad_org_test$sec[i]=0;
  }
  else if((grepl('H',ad_org_test$duration[i])==FALSE) & (grepl('M',ad_org_test$duration[i])==TRUE) & (grepl('S',ad_org_test$duration[i])==FALSE))
  {
    ad_org_test$hour[i]=0;
    ad_org_test$min[i]=substr(ad_org_test$duration[i],regexpr('T',ad_org_test$duration[i])+1,regexpr('M',ad_org_test$duration[i])-1);
    ad_org_test$sec[i]=0;
  }
  else if((grepl('H',ad_org_test$duration[i])==TRUE) & (grepl('M',ad_org_test$duration[i])==FALSE) & (grepl('S',ad_org_test$duration[i])==TRUE))
  {
    ad_org_test$hour[i]=substr(ad_org_test$duration[i],regexpr('T',ad_org_test$duration[i])+1,regexpr('H',ad_org_test$duration[i])-1);
    ad_org_test$min[i]=0;
    ad_org_test$sec[i]=substr(ad_org_test$duration[i],regexpr('H',ad_org_test$duration[i])+1,regexpr('S',ad_org_test$duration[i])-1);
  }
}

for (j in 9:11){
  ad_org_test[,j]=as.numeric(ad_org_test[,j])
}
ad_org_test$durationnew=(ad_org_test$hour*3600)+(ad_org_test$min*60)+(ad_org_test$sec)
#Converting 'category' into factor
ad_org_test$category=as.factor(ad_org_test$category)

#Copying the dataframe into test for further calculations
test=ad_org_test
#Outlier treatment
boxplot(test$views)
boxplot(test$likes)
boxplot(test$dislikes)
boxplot(test$comment)
boxplot(test$durationnew)

V=c(2,3,4,5,12)
for(j in V)
{
  out1=(quantile(test[,j],0.25))-(1.5*IQR(test[,j]))
  out2=(quantile(test[,j],0.75))+(1.5*IQR(test[,j]))
  for (i in 1:nrow(test))
  {
    if((test[i,j]<out1) | (test[i,j]>out2))
    {
      test[i,j]=median(test[,j])
    }
  }
}

boxplot(test$views)
boxplot(test$likes)
boxplot(test$dislikes)
boxplot(test$comment)
boxplot(test$durationnew)

for (i in c(2,3,4,5,12))
{
  test[,i]=as.integer(test[,i])
}

#Checking presence of NA values
colSums(is.na(test))
#convrting category of test dataset into factor
test$category=as.factor(test$category)

#Converting continuous independent variables into categorical variables
#views2 = categorical variable for views
summary(test$views)
for (i in 1:nrow(test))
{
  if((test[i,2]>=27) & (test[i,2]<=287495))
  {
    test[i,13]=1;
  }
  if((test[i,2]>=287496) & (test[i,2]<=574964))
  {
    test[i,13]=2;
  }
  if((test[i,2]>=574965) & (test[i,2]<=862433))
  {
    test[i,13]=3;
  }
  if((test[i,2]>=862434) & (test[i,2]<=1149902))
  {
    test[i,13]=4;
  }
  if((test[i,2]>=1149903) & (test[i,2]<=1437368))
  {
    test[i,13]=5;
  }
}
#duration2 = categorical variable for durationnew
summary(test$durationnew)
for (i in 1:nrow(test))
{
  if((test[i,12]>=5) & (test[i,12]<=302))
  {
    test[i,14]=1;
  }
  if((test[i,12]>=303) & (test[i,12]<=599))
  {
    test[i,14]=2;
  }
  if((test[i,12]>=600) & (test[i,12]<=897))
  {
    test[i,14]=3;
  }
  if((test[i,12]>=898) & (test[i,12]<=1195))
  {
    test[i,14]=4;
  }
  if((test[i,12]>=1196) & (test[i,12]<=1486))
  {
    test[i,14]=5;
  }
}
#likes2 = categorical variable for 'likes'
summary(test$likes)
for (i in 1:nrow(test))
{
  if((test[i,3]>=0) & (test[i,3]<=896))
  {
    test[i,15]=1;
  }
  if((test[i,3]>=897) & (test[i,3]<=1793))
  {
    test[i,15]=2;
  }
  if((test[i,3]>=1794) & (test[i,3]<=2690))
  {
    test[i,15]=3;
  }
  if((test[i,3]>=2691) & (test[i,3]<=3587))
  {
    test[i,15]=4;
  }
  if((test[i,3]>=3588) & (test[i,3]<=4478))
  {
    test[i,15]=5;
  }
}
#dislikes2 = categorical variable for dislikes
summary(test$dislikes)
for (i in 1:nrow(test))
{
  if((test[i,4]>=0) & (test[i,4]<=80))
  {
    test[i,16]=1;
  }
  if((test[i,4]>=81) & (test[i,4]<=161))
  {
    test[i,16]=2;
  }
  if((test[i,4]>=162) & (test[i,4]<=242))
  {
    test[i,16]=3;
  }
  if((test[i,4]>=243) & (test[i,4]<=323))
  {
    test[i,16]=4;
  }
  if((test[i,4]>=324) & (test[i,4]<=402))
  {
    test[i,16]=5;
  }
}
#comment2 = categorical variable for comment
summary(test$comment)
for (i in 1:nrow(test))
{
  if((test[i,5]>=0) & (test[i,5]<=109))
  {
    test[i,17]=1;
  }
  if((test[i,5]>=110) & (test[i,5]<=219))
  {
    test[i,17]=2;
  }
  if((test[i,5]>=220) & (test[i,5]<=329))
  {
    test[i,17]=3;
  }
  if((test[i,5]>=330) & (test[i,5]<=439))
  {
    test[i,17]=4;
  }
  if((test[i,5]>=440) & (test[i,5]<=545))
  {
    test[i,17]=5;
  }
}
#Naming the columns and converting them to factors
colnames(test)[13]="views2"
colnames(test)[14]="duration2"
colnames(test)[15]="likes2"
colnames(test)[16]="dislikes2"
colnames(test)[17]="comment2"
for(i in 13:17)
{
  test[,i]=factor(test[,i],levels=c(1,2,3,4,5))
}
save(test,file="test.RDS") #Saving the test dataset into an R object

pred=predict(fit2,newdata=test,type="response")
pred=round(pred,0)
pred #Predicted adviews for test dataset
class(pred)

final=as.data.frame(cbind(test$vidid,pred),row.names=FALSE)
colnames(final)=c("vid_id","ad_view")
#We write the final output into a csv file
write.csv(final,"C:/rWork/rProjects/R-in-Action/analytics/vidooly_analytics/ad_org.csv")