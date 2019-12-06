#add ref seq to data frame 
getRefSeq <- function(slice){
  for (i in 1:length(slice$ref)) {
    slice$ref[i] <- toString(getSeq(BSgenome.Mmusculus.UCSC.mm9, GRanges(slice$Chr[i], IRanges(slice$Location[i], slice$Location.1[i]))))
  }
  save(slice, file=paste0("../finishedSB_Data" , slice, ".Rdata"))
} 

#read in individual slice specified by cluster job
myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
myfn <- get(load(myfn))
print(typeof(myfn))

getRefSeq(myfn)
