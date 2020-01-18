# Load the data 
load("../element/mm9element.RData")

# split() dataframe into 30 slices
splitted <- split(mm9elements, sample(rep(1:30, 1840)))

# save slices into separate files
for (i in 1:length(splitted)) {
  slice <- splitted[[i]]
  save(slice, file=paste0("~/mm9elements/slice", i, ".Rdata"))
}