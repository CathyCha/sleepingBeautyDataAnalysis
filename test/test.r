source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/ActiveDriverWGS.R")
source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/ADWGS_test.R")
source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/fix_all_results.R")
source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/format_muts.R")
library(parallel)
library(plyr)

mm9Elements <- get(load("/u/ccha/ActiveDriverWGSR-genomeVariety/data/elementsmm9.RData"))


slice <- get(load("/u/ccha/SB_Data/slice44.Rdata"))
slice <- slice[!duplicated(slice),]
  
mcres <- parallel::mclapply(1, function(x, ele) {
  results = ActiveDriverWGS(mutations = ele,
                            elements = mm9Elements, 
                            reference = "mm9")
  return(results)
},ele=slice, mc.cores=8)

final <- ldply(mcres, data.frame)

save(final, file="/u/ccha/test/test.rdata")


