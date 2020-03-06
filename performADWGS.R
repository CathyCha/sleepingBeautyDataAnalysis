source("/u/ccha/ActiveDriverWGSR/R/ActiveDriverWGS.R")
source("/u/ccha/ActiveDriverWGSR/R/ADWGS_test.R")
source("/u/ccha/ActiveDriverWGSR/R/fix_all_results.R")
source("/u/ccha/ActiveDriverWGSR/R/format_muts.R")
library(parallel)
library(plyr)
library(BSgenome.Mmusculus.UCSC.mm9)

#read in individual slice specified by cluster job
myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
slice <- readRDS(toString(myfn))
print("done loading slice")

# splitix <- parallel::splitIndices(nx=length(slice), ncl=ceiling(length(slice) / 1))
SBData <- readRDS("/u/ccha/SB_Data/mouseBasedGalt.rds")
print("done loading SBData")

  results = ActiveDriverWGS(mutations = SBData,
                            window_size = 100000,
                            elements = slice, 
                            reference = "mm9")

print("done activedriver")

saveRDS(result, file=paste0("/u/ccha/complete/exonBased/", paste0(mybasenm)))
