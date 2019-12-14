library(ActiveDriverWGS)
library(parallel)
library(plyr)

#read in individual slice specified by cluster job
myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
slice <- readRDS(myfn)

#perform ActiveDriverWGS on each slice

splitix <- parallel::splitIndices(nx=length(slice), ncl=ceiling(length(slice) / 1))

mcres <- parallel::mclapply(splitix, function(x, ele) {
  mm9Elements = 
  results = ActiveDriverWGS(mutations = mutations_df,
                            elements = mm9Elements,
                            reference = "mm9")
  return(results)
},ele=slice, mc.cores=8)


final <- ldply(mcres, data.frame)

saveRDS(final, file=paste0("~/lymph/parallel/adwgs/computed/", gsub(mybasenm, pattern = ".rds", replacement="_comp.rds", fixed=TRUE)))




