# Load the data 
load("../SB_Data/phasebatch.Rdata")

# split() dataframe into 500 slices and stored as a large list of dataframes 
splitted <- split(phasebatch, sample(rep(1:500, 26500)))

# save slices into separate Rdatas 
for (i in 1:length(splitted)) {
  slice <- splitted[[i]]
  save(slice, file=paste0("slice", i, ".Rdata"))
}

# #save as RData
# save(splitted, file="splitted.Rdata")