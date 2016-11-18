library(dplyr)
library(h2o)
library(tm)
library(topicmodels)
library(tidytext)
#source("http://bioconductor.org/biocLite.R")
#biocLite("rhdf5")
library(rhdf5)
library("flexclust")
library("ggplot2")
library("caret")



#source
setwd("C:/Users/CATHY/Desktop/Fall2016-proj4-caz2114-master/Fall2016-proj4-caz2114-master/output")
#setwd("D:/Fall2016-proj4-caz2114/output")
source("feature.R")
source("../doc/h5_input.R")

#load data file
load("../data/fit.RData")
load("../data/fit_topic_model.RData")


#loading h5 file for test

#remove csv file
setwd("C:/Users/CATHY/Desktop/TestSongFile100/TestSongFile100")
test_h5 <- loadh5()

#loading h5 file for train
setwd("C:/Users/CATHY/OneDrive/Documents/2016-2017 Junior/03 Applied Data Science/Project 4/Project4_data/data/data")
train_h5 <- loadh5()


train <- get.feature(train_h5$h5file)
test <- get.feature(test_h5$h5file)
cl <- factor(fit_topic_model)
grouped <- fit$topics

#knn means
fit_knn <- knn3Train(train,test,cl,k=20,prob=TRUE)
p.value <-attributes(fit_knn)[[1]]
fit_knn_train <- knn3Train(train,train,cl,k=20,prob=TRUE)
p.value_train <-attributes(fit_knn_train)[[1]]


FINAL_TEST<-t(p.value %*% grouped)
FINAL_TRAIN <-t(p.value_train %*% grouped)

for( i in 1:ncol(FINAL_TEST)){
  FINAL_TEST[,i] <- rank(-FINAL_TEST[,i],ties.method = "random")
}
for( i in 1:ncol(FINAL_TRAIN)){
  FINAL_TRAIN[,i] <- rank(-FINAL_TRAIN[,i],ties.method = "random")
}

FINAL_TEST <- as.data.frame(t(FINAL_TEST))
FINAL_TEST$track_id <- test_h5$h5file_path
FINAL_TEST <- FINAL_TEST[,c(5001,1:5000)]

FINAL_TRAIN <- as.data.frame(t(FINAL_TRAIN))
FINAL_TRAIN$track_id <- train_h5$h5file_path
FINAL_TRAIN <- FINAL_TRAIN[,c(5001,1:5000)]

setwd("C:/Users/CATHY/Desktop/Fall2016-proj4-caz2114-master/Fall2016-proj4-caz2114-master/output")
write.csv(rbind(FINAL_TEST,FINAL_TRAIN), file="prediction.csv")
