#add ref seq to data frame 
getRefSeq <- function(sb){
  for (i in 1:length(sb$ref)) {
    sb$ref[i] <- toString(getSeq(BSgenome.Mmusculus.UCSC.mm9, GRanges(sb$Chr[i], IRanges(sb$Location[i], sb$Location.1[i]))))
  }
} 