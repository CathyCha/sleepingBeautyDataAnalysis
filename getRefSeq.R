library(parallel)
library(BSgenome)
library(GenomicRanges)
library(BSgenome.Mmusculus.UCSC.mm9)
library(IRanges)

myfn <- commandArgs(trailingOnly=TRUE)[1]
print("done loading")
print(myfn)
mybasenm <- basename(myfn)
print(mybasenm)
slice <- get(load(toString(myfn)))
print("done loading slice")

#remove duplicates 
slice <- slice[!duplicated(slice),]
#remove non-legal chromosomes
legal_chr = paste0("chr", c(1:19, "X", "Y"))
slice <- slice[slice$chr %in% legal_chr,]


#add ref seq to data frame 
for (i in 1:length(slice$ref)) {
  slice$ref[i] <- toString(BSgenome::getSeq(BSgenome.Mmusculus.UCSC.mm9, 
                                            GenomicRanges::GRanges(slice$Chr[i], 
                                                                   IRanges::IRanges(slice$Location[i], slice$Location.1[i]))))
  slice$alt[i] <- slice$ref[i]
}

save(slice, file=paste0("/u/ccha/finishedGetRef/", mybasenm))

