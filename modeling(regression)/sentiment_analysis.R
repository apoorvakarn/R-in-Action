#sentiment analysis

library('caTools')
library('tm')
library('RCurl')
test_data_url <- "https://storage.googleapis.com/kaggle-competitions-data/kaggle/2558/testdata.txt?GoogleAccessId=competitions-data@kaggle-161607.iam.gserviceaccount.com&Expires=1511669531&Signature=fRN2%2BLu%2BzmCAMr1hQfo2DRQSOd1642VFfnoIx%2B10vjt711yUEHrc2B6D2exp6EOp%2By1tu46TAMDDr9WCHqU9aIr%2BKtpp4LSPNJ%2BIZtCBdwWebT0kLbIJp5R9npIsKFeMNl1%2B9rkNxQqwJonuZb2fRwueh%2Fxot1jnkF2Qs19008O%2BB6v2l40WzXQTmXL76z9gIi4bjGJNKJOcCaidNwE1CQO1hy5EoZUpiAnTb3ZaAm0gqdmDQu5cnLKyOUBU%2B9nm9zGkDupDif2wDTEQrTcp17RG9v%2Fm7U63BNRxesTF4dNZxWEm5KGkV2osCUlv5fUSTV5ufIrmz3s5I4xuy3g%2BQw%3D%3D"
train_data_url <- "https://storage.googleapis.com/kaggle-competitions-data/kaggle/2558/training.txt?GoogleAccessId=competitions-data@kaggle-161607.iam.gserviceaccount.com&Expires=1511668419&Signature=l856gUpR1h3iEZuPEZAOQ%2BIaU9a2A%2FiKsUgE3RKCuSiYg71lnK%2FR7Svcafplsca47cY0ehkK4JYiQxhneuz%2Bx3I0B3XOfVfUXxNlq9gNFZ5cqVQmfPR0f3DYZnQHc5X3jVjLfG1hVE4xssqJPhbMqzBvabKsNB0pWuCT2bpfFXNqXfoIP0bS2T7SIGyn9dQe%2B8QgvzysBF3bbvWQ1KPFaFdRuBEoLteGuuJQ2PS77%2BxlWfNIyX1kOdwCFEJB%2FpoifiM9RCN2pI3rvn1xyz0SkB%2B6NUsHkJKzcs4hy1JmAvvspb8OLqQC2iVj%2BcayXVQgb7eF8nC4PVE5hNbhbYn54A%3D%3D"
test_data_file <- getURL(test_data_url)
train_data_file <- getURL(train_data_url)
train_data_df <- read.csv(
  text = train_data_file, 
  sep='\t', 
  header=FALSE, 
  quote = "",
  stringsAsFactor=F,
  col.names=c("Sentiment", "Text"))
test_data_df <- read.csv(
  text = test_data_file, 
  sep='\t', 
  header=FALSE, 
  quote = "",
  stringsAsFactor=F,
  col.names=c("Text"))
#changing sentiment as factor
train_data_df$Sentiment <- as.factor(train_data_df$Sentiment)
head(train_data_df)
table(train_data_df$Sentiment)
mean(sapply(sapply(train_data_df$Text,strsplit," "),length))
#corpus-- collection of text fragments that we want to classify in either positive or negative sentiment.
(corpus <- Corpus(VectorSource(c(train_data_df$Text, test_data_df$Text))))
corpus[1]$content
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)# convert the word like fishing, fish etc
corpus <- tm_map(corpus, removeWords, stopwords("english"))
dtm <- DocumentTermMatrix(corpus)
dtm
sparse <- removeSparseTerms(dtm, 0.99)
sparse
important_words_df <- as.data.frame(as.matrix(sparse))
colnames(important_words_df) <- make.names(colnames(important_words_df))#convert into a valid column name
# split into train and test
(important_words_train_df <- head(important_words_df, nrow(train_data_df)))
(important_words_test_df <- tail(important_words_df, nrow(test_data_df)))

# Add to original dataframes
(train_data_words_df <- cbind(train_data_df, important_words_train_df))
(test_data_words_df <- cbind(test_data_df, important_words_test_df))

# Get rid of the original Text field
train_data_words_df$Text <- NULL
test_data_words_df$Text <- NULL
library(caTools)
set.seed(1234)
# first we create an index with 80% True values based on Sentiment
spl <- sample.split(train_data_words_df$Sentiment, .85)
# now we use it to split our data into train and test
eval_train_data_df <- train_data_words_df[spl==T,]
eval_test_data_df <- train_data_words_df[spl==F,]
log_model <- glm(Sentiment~., data=eval_train_data_df, family=binomial)
summary(log_model)
log_pred <- predict(log_model, newdata=eval_test_data_df, type="response")
table(eval_test_data_df$Sentiment, log_pred>.5)
(accuracy = (453 + 591) / nrow(eval_test_data_df))
log_pred_test <- predict(log_model, newdata=test_data_words_df, type="response")
test_data_df$Sentiment <- log_pred_test>.5

set.seed(1234)
(spl_test <- sample.split(test_data_df$Sentiment, .0005))
test_data_sample_df <- test_data_df[spl_test==T,]
test_data_sample_df[test_data_sample_df$Sentiment==T, c('Text')]
test_data_sample_df[test_data_sample_df$Sentiment==F, c('Text')]
