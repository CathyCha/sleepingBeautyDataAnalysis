# Load the data 
elementsmm9 <- readRDS("/u/ccha/element/mm9Ensembl.rds")

# split() dataframe into 1000 slices and stored as a large list of dataframes 
splitted <- split(elementsmm9, sample(rep(1:20, 1900)))

# save slices into separate Rdatas 
for (i in 1:length(splitted)) {
  slice <- splitted[[i]]
  save(slice, file=paste0("/u/ccha/slices/ensemblElement/slice", i, ".Rdata"))
}