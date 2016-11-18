library(dplyr)
library(tm)
library(topicmodels)
library(tidytext)
library("caret")



get.feature <- function(h5file){
  list_bars_confidence <- vector(mode = "list",length = length(h5file))
  list_bars_start <- vector(mode = "list",length = length(h5file))
  list_beats_confidence <- vector(mode = "list",length = length(h5file))
  list_beats_start <- vector(mode = "list",length = length(h5file))
  #list_sections_confidence <- vector(mode = "list",length = length(h5file))
  #list_sections_start <- vector(mode = "list",length = length(h5file))
  list_segments_confidence <- vector(mode = "list",length = length(h5file))
  list_segments_loudness_max <- vector(mode = "list",length = length(h5file))
  list_segments_loudness_max_time <- vector(mode = "list",length = length(h5file))
  list_segments_loudness_start <- vector(mode = "list",length = length(h5file))
  list_segments_pitches <- vector(mode = "list",length = length(h5file))
  list_segments_start <- vector(mode = "list",length = length(h5file))
  list_segments_timbre <- vector(mode = "list",length = length(h5file))
  list_tatums_confidence <- vector(mode = "list",length = length(h5file))
  list_tatums_start <- vector(mode = "list",length = length(h5file))
  
  
  for( i in 1:length(h5file)){
    list_bars_confidence[[i]] <- h5file[[i]]$bars_confidence
    list_bars_start[[i]] <- h5file[[i]]$bars_start
    list_beats_confidence[[i]] <- h5file[[i]]$beats_confidence
    list_beats_start[[i]] <- h5file[[i]]$beats_start
    #list_sections_confidence[[i]] <- h5file[[i]]$sections_confidence
    #list_sections_start[[i]] <- h5file[[i]]$sections_start
    list_segments_confidence[[i]] <- h5file[[i]]$segments_confidence
    list_segments_loudness_max[[i]] <- h5file[[i]]$segments_loudness_max
    list_segments_loudness_max_time[[i]] <- h5file[[i]]$segments_loudness_max_time
    list_segments_loudness_start[[i]] <- h5file[[i]]$segments_loudness_start
    list_segments_pitches[[i]] <- h5file[[i]]$segments_pitches
    list_segments_start[[i]] <- h5file[[i]]$segments_start
    list_segments_timbre[[i]] <- h5file[[i]]$segments_timbre
    list_tatums_confidence[[i]] <- h5file[[i]]$tatums_confidence
    list_tatums_start[[i]] <- h5file[[i]]$tatums_start
  }
  
  
  smoothing <- function(data){
    y <- data
    if(length(y) != 0){
      x <- 1:length(y)
      result <- predict(smooth.spline(x,y,spar = 0.1),(length(y)/200)*1:200)
      result <- result$y
    }else {
      result <- rep.int(0,200)
    }
    return(result)
  }
  
  #h5_song <- vector(mode = "list",length = 2350)
  
  #for( i in 1:length(h5file)){
  #unlist, removes all non-characters, changes to numeric, unames
  # this <- unlist(h5file[[1]]$songs)
  #h5_song[[1]] <- unname(as.numeric(this[!is.na(as.numeric(as.character(this)))]))
  #}
  
  
  
  bars_confidence <- lapply(list_bars_confidence,smoothing)
  bars_start <- lapply(list_bars_start,smoothing)
  beats_confidence <- lapply(list_beats_confidence,smoothing)
  beats_start <- lapply(list_beats_start,smoothing)
  #sections_confidence <- lapply(list_sections_confidence,smoothing_less)
  #sections_start <- lapply(list_sections_start,smoothing_less)
  segments_confidence <- lapply(list_segments_confidence,smoothing)
  segments_loudness_max <- lapply(list_segments_loudness_max,smoothing)
  segments_loudness_max_times <- lapply(list_segments_loudness_max_time,smoothing)
  segments_loudness_start <- lapply(list_segments_loudness_start,smoothing)
  segments_pitches <- lapply(list_segments_pitches,smoothing)
  segments_start <- lapply(list_segments_start,smoothing)
  segments_timbre <- lapply(list_segments_timbre,smoothing)
  
  
  bars_confidence <-matrix(unlist(bars_confidence), ncol = 200, byrow = TRUE)
  bars_start <- matrix(unlist(bars_start),ncol = 200, byrow = TRUE)
  beats_confidence <- matrix(unlist(beats_confidence),ncol = 200, byrow = TRUE)
  beats_start <- matrix(unlist(beats_confidence),ncol = 200, byrow = TRUE)
  # sections_confidence <- matrix(unlist(sections_confidence),ncol = 200, byrow = TRUE)
  # sections_start <- matrix(unlist(sections_start),ncol = 200, byrow = TRUE)
  # h5_song <- matrix(unlist(h5_song),ncol = 200, byrow = TRUE)
  segments_confidence <- matrix(unlist(segments_confidence), ncol = 200, byrow = TRUE)
  segments_loudness_max <- matrix(unlist(segments_loudness_max), ncol = 200, byrow = TRUE)
  segments_loudness_max_times <- matrix(unlist(segments_loudness_max_times), ncol = 200, byrow = TRUE)
  segments_loudness_start <- matrix(unlist(segments_loudness_start), ncol = 200, byrow = TRUE)
  segments_pitches <- matrix(unlist(segments_pitches), ncol = 200, byrow = TRUE)
  segments_start <- matrix(unlist(segments_start), ncol = 200, byrow = TRUE)
  segments_timbre <- matrix(unlist(segments_timbre), ncol = 200, byrow = TRUE)
  
  
  
  set.seed(43)
  fit_bars_confidence <- kmeans(bars_confidence, 20,iter.max = 50)
  fit_bars_start <- kmeans(bars_start,20,iter.max = 50)
  fit_beats_confidence <- kmeans(beats_confidence,20,iter.max = 50)
  fit_beats_start <- kmeans(beats_start,20,iter.max = 50)
  fit_segments_confidence <- kmeans(segments_confidence, 20,iter.max = 50)
  fit_segments_loudness_max <- kmeans(segments_loudness_max, 20,iter.max = 50)
  fit_segments_loudness_max_times <- kmeans(segments_loudness_max_times, 20,iter.max = 50)
  fit_segments_loudness_start <- kmeans(segments_loudness_start, 20,iter.max = 50)
  fit_segments_pitches <- kmeans(segments_pitches, 20,iter.max = 50)
  fit_segments_start <- kmeans(segments_start, 20,iter.max = 50)
  fit_segments_timbre <- kmeans(segments_timbre, 20,iter.max = 50)
  #fit_h5_song <- kmeans(h5_song,20,iter.max = 50)
  
  
  
  kmeans_binded <- cbind(fit_bars_confidence$cluster,
                         fit_bars_start$cluster,
                         fit_beats_confidence$cluster,
                         fit_beats_start$cluster,
                         #fit_h5_song$cluster,
                         fit_segments_confidence$cluster,
                         fit_segments_loudness_max$cluster,
                         fit_segments_loudness_max_times$cluster,
                         fit_segments_loudness_start$cluster,
                         fit_segments_pitches$cluster,
                         fit_segments_start$cluster,
                         fit_segments_timbre$cluster)

  return(kmeans_binded)
}
