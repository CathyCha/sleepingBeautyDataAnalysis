library(parallel)
library(GenomicRanges)
library(BSgenome.Mmusculus.UCSC.mm9)
library(IRanges)
library(BSgenome)

myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
slice <- readRDS(toString(myfn))
print("done loading slice")


#add ref seq to data frame 
for (i in 1:length(slice$ref)) {
  slice$ref[i] <- toString(BSgenome::getSeq(BSgenome.Mmusculus.UCSC.mm9, 
                                            GenomicRanges::GRanges(slice$chr[i], 
                                                                   IRanges::IRanges(slice$pos1[i], slice$pos2[i]))))
  slice$alt[i] <- "GTTGAC"
}
save(slice, file=paste0("/u/ccha/finishedGetRef/", mybasenm))

