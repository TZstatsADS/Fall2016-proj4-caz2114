#setuo
###This will downloard the LAvisData package if not installed
install.packages("devtools")
devtools::install_github("cpsievert/LDAvisData")

library("LDAvisData", lib.loc="~/R/win-library/3.3")
data(reviews, package = "LDAvisData")

library(NLP)
library(tm)
library(lda)
library(LDAvis)

#load file
setwd("C:/Users/CATHY/Desktop/Fall2016-proj4-caz2114-master/Fall2016-proj4-caz2114-master/doc")
load("../data/lyr.RData")

##### Pre-processing  
word_freq <- colSums(lyr[,-1])


directory <- names(word_freq)  #this is 1x5000

# now put the documents into the format required by the lda package:
setwd("C:/Users/CATHY/OneDrive/Documents/2016-2017 Junior/03 Applied Data Science/Project 4/Project4_data/data/data")
h5file_path <- list.files(path = "./", recursive = TRUE)
setwd("C:/Users/CATHY/Desktop/Fall2016-proj4-caz2114-master/Fall2016-proj4-caz2114-master/doc")

lyric_song<-vector(mode = "list",length = length(lyr)-1)

combine <- function(x) {
  index <- grepl(x, lyr[,1])
  non_zero <- lyr[index,which(lyr[index,]>0)]
  index <- match(colnames(non_zero)[-1],directory)
  index <- index[!is.na(index)]
  hi<-rbind(as.integer(index),as.integer(non_zero[-1]))
}

lyric_song<-lapply(lyr[,1],combine)
names(lyric_song) <- lyr[,1]
save(lyric_song,file = "lyric_song.RData")


#"Turning parameters"
# MCMC and model tuning parameters:
K <- 20
G <- 5000
alpha <- 0.02
eta <- 0.02


# Fit the model:
library(lda)
set.seed(357)
t1 <- Sys.time()
fit <- lda.collapsed.gibbs.sampler(documents = lyric_song, K = K, vocab = directory, 
                                   num.iterations = G, alpha = alpha, 
                                   eta = eta, initial = NULL, burnin = 0,
                                   compute.log.likelihood = TRUE)
t2 <- Sys.time()
t2 - t1 #runtime 13 min 

fit
save(fit,file = "fit.RData")


setwd("D:/Fall2016-proj4-caz2114/data")
load("./fit.RData")
topic_model <- fit$document_expects
fit_topic_model <- vector()
for( i in 1:ncol(topic_model)){
  fit_topic_model<- c(fit_topic_model,which.min(topic_model[,i]))
}
save(fit_topic_model,file = "fit_topic_model.RData")

