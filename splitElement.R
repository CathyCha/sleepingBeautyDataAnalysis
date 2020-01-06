# Load the data 
load("/u/ccha/ActiveDriverWGSR/data/elementsmm9.RData")

# split() dataframe into 1000 slices and stored as a large list of dataframes 
splitted <- split(elementsmm9, sample(rep(1:1000, 1150)))

# save slices into separate Rdatas 
for (i in 1:length(splitted)) {
  slice <- splitted[[i]]
  save(slice, file=paste0("../SB_Data/element/slice", i, ".Rdata"))
}