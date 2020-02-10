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
slice <- get(load(toString(myfn)))
print("done loading slice")

# splitix <- parallel::splitIndices(nx=length(slice), ncl=ceiling(length(slice) / 1))
SBData <- get(load("/u/ccha/SB_Data/mouseBasedGAlt.Rdata"))
print("done loading SBData")

mcres <- parallel::mclapply(1, function(x, ele) {
  results = ActiveDriverWGS(mutations = SBData,
                            window_size = 50000,
                            elements = ele, 
                            reference = "mm9")
  return(results)
},ele=slice, mc.cores=1)

print("done activedriver")

final <- ldply(mcres, data.frame)

save(final, file=paste0("/u/ccha/complete/ws50000/", paste0(mybasenm)))
