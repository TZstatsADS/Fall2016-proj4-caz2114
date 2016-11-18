#This file load the h5 files
setwd("C:/Users/CATHY/OneDrive/Documents/2016-2017 Junior/Applied Data Science/Project 4/Fall2016-Proj4-caz/data")


h5file_path <- list.files(path = "./", recursive = TRUE)
h5file <- list()


for( i in 1:length(h5file_path)){
  H5close()
  h5file[[i]] <- h5read(h5file_path[i],"/analysis")
}


setwd("C:/Users/CATHY/OneDrive/Documents/2016-2017 Junior/Applied Data Science/Project 4/Fall2016-Proj4-caz/")
save(h5file,file = "h5file.RData")