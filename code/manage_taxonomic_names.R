# Retrieve taxonomy ####

## librairies ####
library(taxize)

## import data ####
corres <- read.csv(file = "data/correspondance_codes_sp_noms_bino.csv")

# introduce errors ####
corres$nom_dummy <- corres$nom_binomial

# une lettre en plus
corres[corres$tax_id == "LEULEU", "nom_dummy"] <- "Leucaena leucocephalla" 
# un double espace
corres[corres$tax_id == "COPBOR", "nom_dummy"] <- "Coptosperma  borbonicum"
# un synonyme
corres[corres$tax_id == "PSICAT", "nom_dummy"] <- "Psidium cattleianum"

apg()
