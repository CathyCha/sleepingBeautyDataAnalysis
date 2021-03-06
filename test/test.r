source("/u/ccha/ActiveDriverWGSR/R/ActiveDriverWGS.R")
source("/u/ccha/ActiveDriverWGSR/R/ADWGS_test.R")
source("/u/ccha/ActiveDriverWGSR/R/fix_all_results.R")
source("/u/ccha/ActiveDriverWGSR/R/format_muts.R")
library(parallel)
library(plyr)
library(BSgenome.Mmusculus.UCSC.mm9)

slice <- readRDS("/u/ccha/test/cancerDrivers.rds")
slice <- slice[!(duplicated(slice)),]
print("done loading slice")

# splitix <- parallel::splitIndices(nx=length(slice), ncl=ceiling(length(slice) / 1))
SBData <- readRDS("/u/ccha/SB_Data/mouseBasedGalt.rds")
print("done loading SBData")

mcres <- parallel::mclapply(1, function(x, ele) {
  results = ActiveDriverWGS(mutations = SBData,
                            window_size = 30000,
                            elements = ele, 
                            reference = "mm9")
  return(results)
},ele=slice, mc.cores=1)

print("done activedriver")

final <- ldply(mcres, data.frame)

saveRDS(final, file=paste0("/u/ccha/complete/", "test.rds"))