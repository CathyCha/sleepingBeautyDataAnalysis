#add ref seq to data frame 
getRefSeq <- function(slice){
  for (i in 1:length(slice$ref)) {
    slice$ref[i] <- toString(getSeq(BSgenome.Mmusculus.UCSC.mm9, GRanges(slice$Chr[i], IRanges(slice$Location[i], slice$Location.1[i]))))
  }
} 

#read in individual slice specified by cluster job
myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
slice <- load(paste0("../SB_Data/", myfn))
typeof(slice)

# getRefSeq(slice)
