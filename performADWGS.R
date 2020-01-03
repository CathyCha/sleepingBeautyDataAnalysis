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
slice <- slice[!duplicated(slice),]

# splitix <- parallel::splitIndices(nx=length(slice), ncl=ceiling(length(slice) / 1))
mm9Elements <- get(load("/u/ccha/ActiveDriverWGSR-genomeVariety/data/elementsmm9.RData"))

print("loaded mm9 elements")


mcres <- parallel::mclapply(1, function(x, ele) {
  results = ActiveDriverWGS(mutations = ele,
                            elements = mm9Elements, 
                            reference = "mm9")
  return(results)
},ele=slice, mc.cores=8)

print("done activedriver")

final <- ldply(mcres, data.frame)

saveRDS(final, file=paste0("~/complete/", gsub(mybasenm, pattern = ".rds", replacement="_comp.rds", fixed=TRUE)))
