# Read in saved data ojects()

fetal.integrated <- readRDS(file="./output/RDataObjects/fetal-int.Rds")
load(file="./output/RDataObjects/fetalObjs.Rdata")

load(file="./data/gstlist-fetal.Rdata")

young.integrated <- readRDS(file="./output/RDataObjects/young-int.Rds")
load(file="./output/RDataObjects/youngObjs.Rdata")

adult.integrated <- readRDS(file="./output/RDataObjects/adult-int.Rds")
load(file="./output/RDataObjects/adultObjs.Rdata")


dcm.integrated <- readRDS(file="./output/RDataObjects/dcm-int.Rds")
load(file="./output/RDataObjects/dcmObjs.Rdata")
