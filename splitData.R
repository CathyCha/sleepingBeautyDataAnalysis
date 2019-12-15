# Load the data 
load("../SB_Data/SBData.Rdata")

# split() dataframe into 500 slices and stored as a large list of dataframes 
splitted <- split(puttogether, sample(rep(1:1000, 13400)))

# save slices into separate Rdatas 
for (i in 1:length(splitted)) {
  slice <- splitted[[i]]
  save(slice, file=paste0("../SB_Data/slice", i, ".Rdata"))
}

# #save as RData
# save(splitted, file="splitted.Rdata")