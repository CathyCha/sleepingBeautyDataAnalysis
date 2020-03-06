result = readRDS("/u/ccha/complete/ws1mb/slice1.rds")

for (i in 869:1000) {
  slice = readRDS(paste0("/u/ccha/complete/ws1mb/slice", i , ".rds"))
  result = rbind(result, slice)
} 

saveRDS(result, "result.rds")


result <- get(load("/u/ccha/complete/tumourBasedRData/slice1.rds"))

for (i in 2:20) {
  slice <- get(load(paste0("/u/ccha/complete/tumourBasedRData/slice", i , ".rds")))
  result = rbind(result, slice)
} 

saveRDS(result, "result.rds")