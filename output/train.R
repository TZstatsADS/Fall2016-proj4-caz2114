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


#load data file
setwd("C:/Users/CATHY/OneDrive/Documents/2016-2017 Junior/03 Applied Data Science/Project 4/Fall2016-Proj4/Data")
load("./kmeans_binded.RData")


train <- kmeans_binded[1:2000,]
test <- kmeans_binded[2001:2350,]
cl <- factor(fit_topic_model[1:2000])
fit_knn <- knn3Train(train,test,cl,k=20,prob=TRUE)
p.value <-attributes(fit_knn)[[1]]
grouped <- fit$topics

FINAL<-t(p.value %*% grouped)

for( i in 1:ncol(FINAL)){
  FINAL[,i] <- rank(-FINAL[,i],ties.method = "random")
}

FINAL