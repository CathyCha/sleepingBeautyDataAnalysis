source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/ActiveDriverWGS.R")
source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/ADWGS_test.R")
source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/fix_all_results.R")
source("/u/ccha/ActiveDriverWGSR-genomeVariety/R/format_muts.R")
library(parallel)
library(plyr)

#read in individual slice specified by cluster job
myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
slice <- get(load(toString(myfn)))
typeof(slice)

# splitix <- parallel::splitIndices(nx=length(slice), ncl=ceiling(length(slice) / 1))
mm9Elements <- get(load("/u/ccha/ActiveDriverWGSR-genomeVariety/data/elementsmm9.RData"))

mcres <- parallel::mclapply(1, function(x, ele) {
  results = ActiveDriverWGS(mutations = ele,
                            elements = mm9Elements, 
                            reference = "mm9")
  return(results)
},ele=slice, mc.cores=8)


final <- ldply(mcres, data.frame)

saveRDS(final, file=paste0("~/complete/", gsub(mybasenm, pattern = ".rds", replacement="_comp.rds", fixed=TRUE)))
