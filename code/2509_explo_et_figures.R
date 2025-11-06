# Analyses exploratoires des données de l'exp en pots ####

library(readxl)
library(ggplot2)
library(data.table)

dir.create(path = "results/")

tout <- read_xlsx(path = "data/2509_initial_final_temporaire.xlsx")
# 1838

tout <- as.data.table(tout)

endemiques <- c("ABUEXS", "COPBOR", "CROMAU", "DIOBOR", "FERBUX", "OLAPSI", "POLCUT", "POUBOR",
                "TERBEN", "VOLHET", "ZANHET")
eee <- c("ALBLEB", "FURFOE", "HEDGAR", "HIPBEN", "LANCAM", "LEULEU", "LITGLU", "PSICAT", "SEALON")


tout[modalite == "INTER4" & sp1 %in% endemiques, mod_new := "INTER4_end"]
tout[modalite == "INTER4" & sp1 %in% eee, mod_new := "INTER4_eee"]
tout[is.na(mod_new), mod_new := modalite]

tout$mod_new <- factor(tout$mod_new, levels = c("INTRA1", "INTRA2", "INTRA4",
                                                "INTER2", "INTER4_end", "INTER4_eee"))

table(tout$mod_new)

tout$pairs <- paste(tout$sp1, tout$sp2)

# refaire toutes les paires 

pairs <- na.omit(unique(tout[, c("sp1", "sp2")]))
pairs <- pairs[!pairs$sp1 %in% eee,]
pairs$pairs <- paste(pairs$sp1, pairs$sp2)

tout$pairs <- paste(tout$sp1, tout$sp2)
tout$pairs2 <- paste(tout$sp2, tout$sp1)

for(n in 1:24){
  
  tmp <- tout[tout$pairs == pairs[[3]][[n]] |
                tout$pairs2 == pairs[[3]][[n]] |
                tout$sp1 == pairs[[1]][[n]] & is.na(tout$sp2) |
                tout$sp1 == pairs[[2]][[n]] & is.na(tout$sp2),]
 
  
  diffmass <- ggplot(tmp) + geom_boxplot(aes(y = diffmass, x = mod_new)) + 
    labs(title= "différence masse feuillage") +
    facet_wrap(~ sp) + theme_minimal() + xlab("")
  
  diffvol <- ggplot(tmp) + geom_boxplot(aes(y = diffvol, x = mod_new)) + 
    labs(title="différence volume tige") +
    facet_wrap(~ sp) + theme_minimal() + xlab("") 
  
  ggsave(filename = paste0("results/diffmass_", pairs[[3]][[n]], ".png"), 
         plot = diffmass, width = 25, height = 13,
         units = "cm" )
  ggsave(filename = paste0("results/diffvol_", pairs[[3]][[n]], ".png"), 
         plot = diffvol, width = 25, height = 13,
         units = "cm" )
  
}



## sortir polcut / furfoe et polcut hipben à la même échelle pour le csi
# paires 15 et 16
n = 15

tmp <- tout[tout$pairs == pairs[[3]][[n]] |
              tout$pairs2 == pairs[[3]][[n]] |
              tout$sp1 == pairs[[1]][[n]] & is.na(tout$sp2) |
              tout$sp1 == pairs[[2]][[n]] & is.na(tout$sp2),]

n = 16
tmp2 <- tout[tout$pairs == pairs[[3]][[n]] |
              tout$pairs2 == pairs[[3]][[n]] |
              tout$sp1 == pairs[[1]][[n]] & is.na(tout$sp2) |
              tout$sp1 == pairs[[2]][[n]] & is.na(tout$sp2),]


diffmass <- ggplot(tmp) + geom_boxplot(aes(y = diffmass, x = mod_new)) + 
  labs(title= "différence masse feuillage") +
  facet_wrap(~ sp) + theme_minimal() + xlab("") + ylim(c(0, 30))


diffmass2 <- ggplot(tmp2) + geom_boxplot(aes(y = diffmass, x = mod_new)) + 
  labs(title= "différence masse feuillage") +
  facet_wrap(~ sp) + theme_minimal() + xlab("") + ylim(c(0, 30))

diffmass
diffmass2


ggsave(filename = paste0("results/csi_diffmass_polcut_furfoe.png"), 
       plot = diffmass, width = 25, height = 13,
       units = "cm" )
ggsave(filename = paste0("results/csi_diffmass_polcut_hibpen.png"), 
       plot = diffmass2, width = 25, height = 13,
       units = "cm" )
