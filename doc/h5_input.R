#This file load the h5 files
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)


loadh5 <- function(){
  h5file_path <- list.files(path = "./", recursive = TRUE)
  h5file <- list()

  for( i in 1:length(h5file_path)){
    H5close()
    h5file[[i]] <- h5read(h5file_path[i],"/analysis")
  }
  
  return(list("h5file" = h5file, "h5file_path" = h5file_path))
}

