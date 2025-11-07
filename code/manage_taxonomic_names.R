# Retrieve taxonomy ####

## librairies ####
library(taxize)
library(tidyr)

## import data ####
corres <- read.csv(file = "data/correspondance_codes_sp_noms_bino.csv")

## introduce errors ####
corres$nom_dummy <- corres$nom_binomial

# une lettre en plus
corres[corres$tax_id == "LEULEU", "nom_dummy"] <- "Leucaena leucocephalla" 
# un double espace
corres[corres$tax_id == "COPBOR", "nom_dummy"] <- "Coptosperma  borbonicum"
# un synonyme
corres[corres$tax_id == "PSICAT", "nom_dummy"] <- "Psidium cattleianum"

## comparaison taxonomique ####

# Taxize
corres_verif <- taxize::gna_verifier(corres$nom_dummy)
# corres <- left_join(corres, corres_verif)

temp <- classification(corres_verif$currentName, db = "wiki")
temp_gbif <- classification(corres_verif$currentName, db = "gbif")
temp_itis <- classification(corres_verif$matchedCanonicalSimple, db = "itis")

rbindlist(temp_itis)

tmp_tot <- data.frame(name = NA, 
                      rank = NA,
                      id = NA,
                      sp = NA)

for (n in 1:20){
  
  if (!is.logical(temp_itis[[n]])){
    
    tmp <- temp_itis[[n]]
    tmp$sp <- names(temp_itis)[[n]]
    tmp_tot <- rbind(tmp_tot, tmp)
    
  }
  
}

tmp_tot <- na.omit(tmp_tot)

classif_clean <- pivot_wider(tmp_tot, names_from = "rank", values_from = c("name", "id"))

write.csv(classif_clean, file = "data/taxonomic_coverage.csv", row.names = F)

