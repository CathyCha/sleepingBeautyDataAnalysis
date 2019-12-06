library(parallel)

if (! require(BSgenome, quietly=TRUE)) {
  BiocManager::install("BSgenome")
}
library(BSgenome)

if (! require(GenomicRanges, quietly=TRUE)) {
  BiocManager::install("GenomicRanges")
}
library(GenomicRanges)

if (! require(BSgenome.Mmusculus.UCSC.mm9, quietly=TRUE)) {
  BiocManager::install("BSgenome.Mmusculus.UCSC.mm9")
}
library(BSgenome.Mmusculus.UCSC.mm9)

if (! require(IRanges, quietly=TRUE)) {
  BiocManager::install("IRanges")
}
library(IRanges)


#add ref seq to data frame 
getRefSeq <- function(slice){
  for (i in 1:length(slice$ref)) {
    slice$ref[i] <- toString(BSgenome::getSeq(BSgenome.Mmusculus.UCSC.mm9, GenomicRanges::GRanges(slice$Chr[i], IRanges::IRanges(slice$Location[i], slice$Location.1[i]))))
  }
  return(slice)
} 

#read in individual slice specified by cluster job
myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
myfn <- get(load(myfn))
print(typeof(myfn))

result <- getRefSeq(myfn)
save(result, file=paste0("../finishedSB_Data/", mybasenm))

