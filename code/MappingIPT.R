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
  island          = "La Réunion"   # pas de virgule finale ici
)]
corres 

write.csv2(corres,file = "data/mappingIPT.csv")
