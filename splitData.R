# Load the data 
load("../SB_Data/phasebatch.Rdata")

# split() dataframe into 500 slices and stored as a large list of dataframes 
splitted <- split(phasebatch, sample(rep(1:500, 26500)))

#save as RData
save(splitted, file="splitted.Rdata")