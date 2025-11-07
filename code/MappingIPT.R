# Create DarwinCore Variables 

## import data ####
corres <- read.csv(file = "data/correspondance_codes_sp_noms_bino.csv")

corres


library(data.table)
setDT(corres)  # transforme 'corres' en data.table

corres[, `:=`(
  basisOfRecord   = "LivingSpecimen",
  individualCount = 25,
  kingdom         = "Plantae",
  recordedBy      = "Margaux Rojat",
  eventDate       = "2024",        # ou "2024-01-01" si tu veux une vraie date
  country         = "France",
  countryCode     = "FR",
  island          = "La Réunion",
  licence         = "http://creativecommons.org/licenses/by/4.0/legalcode"
)]
corres 

write.csv2(corres,file = "data/mappingIPT.csv")

dataraw <- read_xlsx("data/2509_initial_final_temporaire.xlsx")
dataraw

library(dplyr)

data_joined <- dataraw %>%
  left_join(corres, by = c("sp" = "tax_id"))

data_joined

write.csv2(data_joined,file = "data/mappingIPT_ready.csv")
