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
setwd("D:/Fall2016-proj4-caz2114/output")
source("feature.R")
source("h5_input.R")

#load data file
load("../data/fit_topic_model.RData")


#loading h5 file for test

setwd("D:/TestSongFile100/TestSongFile100")
test_h5 <- loadh5("D:/TestSongFile100/TestSongFile100")

#loading h5 file for train
setwd("D:/Project4_data/data/data")
train_h5 <- loadh5("D:/Project4_data/data/data")


train <- get.feature(train_h5)
test <- get.feature(test_h5)
cl <- factor(fit_topic_model)
fit_knn <- knn3Train(train,test,cl,k=20,prob=TRUE)
p.value <-attributes(fit_knn)[[1]]
grouped <- fit$topics

FINAL<-t(p.value %*% grouped)

for( i in 1:ncol(FINAL)){
  FINAL[,i] <- rank(-FINAL[,i],ties.method = "random")
}

FINAL
