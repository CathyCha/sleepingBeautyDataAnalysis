# Load the data 
load("../element/mm9element.RData")

# split() dataframe into 500 slices and stored as a large list of dataframes 
splitted <- split(mm9elements, sample(rep(1:300, 1600)))

# save slices into separate Rdatas 
for (i in 1:length(splitted)) {
  slice <- splitted[[i]]
  save(slice, file=paste0("../mm9elements/slice", i, ".Rdata"))
}