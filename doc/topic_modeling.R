###This will downloard the LAvisData package if not installed
install.packages("devtools")
devtools::install_github("cpsievert/LDAvisData")

#input the library
library("LDAvisData", lib.loc="~/R/win-library/3.3")

library(NLP)
library(tm)
library(lda)
library(LDAvis)

#load data
setwd("C:/Users/CATHY/Desktop/Fall2016-proj4-caz2114-master/Fall2016-proj4-caz2114-master/output")
load("../data/lyr.RData")
load("../data/lyric_song.RDATA")



#Turning parameters
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

save(fit,file = "fit.RData")

topic_model <- fit$document_expects
fit_topic_model <- vector()
for( i in 1:ncol(topic_model)){
  fit_topic_model<- c(fit_topic_model,which.min(topic_model[,i]))
}
save(fit_topic_model,file = "fit_topic_model.RData")



