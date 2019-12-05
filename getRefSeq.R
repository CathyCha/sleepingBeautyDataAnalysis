
# Load the data 
load("../SB_Data/phasebatch.Rdata")

# split() dataframe into 500 slices and stored as a large list of dataframes 
splitted <- split(phasebatch, sample(rep(1:500, 26500)))

getRefSeq <- function(sb){
  for (i in 1:length(sb$ref)) {
    sb$ref[i] <- toString(getSeq(BSgenome.Mmusculus.UCSC.mm9, GRanges(sb$Chr[i], IRanges(sb$Location[i], sb$Location.1[i]))))
  }
} 