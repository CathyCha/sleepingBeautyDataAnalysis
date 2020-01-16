result = readRDS("/u/ccha/complete/slice1.rds")

for (i in 2:300) {
  slice = readRDS(paste0("/u/ccha/complete/slice", i , ".rds"))
  result = rbind(result, slice)
} 

saveRDS(result, "result.rds")