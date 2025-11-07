Margaux
================
Oihana Olhasque
2025-11-06

``` r
library(readxl)
library(ggplot2)
library(data.table)
library(here)
```

``` r
dir.create(here("results"))
```

    ## Warning in dir.create(here("results")):
    ## 'C:\Github\cesab_open_data_project\results' existe déjà

``` r
tout <- read_xlsx(here("data", "2509_initial_final_temporaire.xlsx"))
```

``` r
tout <- as.data.table(tout)
```

``` r
endemiques <- c("ABUEXS", "COPBOR", "CROMAU", "DIOBOR", "FERBUX", "OLAPSI", "POLCUT", "POUBOR",
                "TERBEN", "VOLHET", "ZANHET")
eee <- c("ALBLEB", "FURFOE", "HEDGAR", "HIPBEN", "LANCAM", "LEULEU", "LITGLU", "PSICAT", "SEALON")
```

``` r
tout[modalite == "INTER4" & sp1 %in% endemiques, mod_new := "INTER4_end"]
tout[modalite == "INTER4" & sp1 %in% eee, mod_new := "INTER4_eee"]
tout[is.na(mod_new), mod_new := modalite]
```

``` r
tout$mod_new <- factor(tout$mod_new, levels = c("INTRA1", "INTRA2", "INTRA4",
                                                "INTER2", "INTER4_end", "INTER4_eee"))
```

``` r
table(tout$mod_new)
```

    ## 
    ##     INTRA1     INTRA2     INTRA4     INTER2 INTER4_end INTER4_eee 
    ##         98        198        390        226        454        472

``` r
tout$pairs <- paste(tout$sp1, tout$sp2)
```

``` r
pairs
```

    ##        sp1    sp2         pairs
    ##     <char> <char>        <char>
    ##  1: ABUEXS FURFOE ABUEXS FURFOE
    ##  2: ABUEXS LEULEU ABUEXS LEULEU
    ##  3: COPBOR LANCAM COPBOR LANCAM
    ##  4: COPBOR PSICAT COPBOR PSICAT
    ##  5: COPBOR SEALON COPBOR SEALON
    ##  6: CROMAU HIPBEN CROMAU HIPBEN
    ##  7: CROMAU PSICAT CROMAU PSICAT
    ##  8: DIOBOR HEDGAR DIOBOR HEDGAR
    ##  9: DIOBOR PSICAT DIOBOR PSICAT
    ## 10: FERBUX ALBLEB FERBUX ALBLEB
    ## 11: FERBUX HIPBEN FERBUX HIPBEN
    ## 12: FERBUX LITGLU FERBUX LITGLU
    ## 13: OLAPSI HEDGAR OLAPSI HEDGAR
    ## 14: OLAPSI PSICAT OLAPSI PSICAT
    ## 15: POLCUT FURFOE POLCUT FURFOE
    ## 16: POLCUT HIPBEN POLCUT HIPBEN
    ## 17: POLCUT PSICAT POLCUT PSICAT
    ## 18: POUBOR HIPBEN POUBOR HIPBEN
    ## 19: POUBOR LEULEU POUBOR LEULEU
    ## 20: TERBEN FURFOE TERBEN FURFOE
    ## 21: TERBEN LEULEU TERBEN LEULEU
    ## 22: VOLHET LEULEU VOLHET LEULEU
    ## 23: ZANHET HEDGAR ZANHET HEDGAR
    ## 24: ZANHET PSICAT ZANHET PSICAT
    ##        sp1    sp2         pairs

# Code Margaux

``` r
#for(n in 1:24){
  
#  tmp <- tout[tout$pairs == pairs[[3]][[n]] |
#                tout$pairs2 == pairs[[3]][[n]] |
#                tout$sp1 == pairs[[1]][[n]] & is.na(tout$sp2) |
#                tout$sp1 == pairs[[2]][[n]] & is.na(tout$sp2),]
 
  
#  diffmass <- ggplot(tmp) + geom_boxplot(aes(y = diffmass, x = mod_new)) + 
#    labs(title= "différence masse feuillage") +
#    facet_wrap(~ sp) + theme_minimal() + xlab("")
  
#  diffvol <- ggplot(tmp) + geom_boxplot(aes(y = diffvol, x = mod_new)) + 
#    labs(title="différence volume tige") +
#    facet_wrap(~ sp) + theme_minimal() + xlab("") 
  
#  ggsave(filename = paste0("results/diffmass_", pairs[[3]][[n]], ".png"), 
#         plot = diffmass, width = 25, height = 13,
#         units = "cm" )
 # ggsave(filename = paste0("results/diffvol_", pairs[[3]][[n]], ".png"), 
 #        plot = diffvol, width = 25, height = 13,
 #        units = "cm" )
  
#}
```

Erreur indice Hors limite

\#Code Margaux

``` r
## sortir polcut / furfoe et polcut hipben à la même échelle pour le csi
# paires 15 et 16
#n = 15

#tmp <- tout[tout$pairs == pairs[[3]][[n]] |
              #tout$pairs2 == pairs[[3]][[n]] |
              #tout$sp1 == pairs[[1]][[n]] & is.na(tout$sp2) |
              #tout$sp1 == pairs[[2]][[n]] & is.na(tout$sp2),]
```

\#Code Margaux

``` r
#n = 16
#tmp2 <- tout[tout$pairs == pairs[[3]][[n]] |
              #tout$pairs2 == pairs[[3]][[n]] |
             # tout$sp1 == pairs[[1]][[n]] & is.na(tout$sp2) |
              #tout$sp1 == pairs[[2]][[n]] & is.na(tout$sp2),]
```

Erreur indice hors limite

\#Code Margaux

``` r
#diffmass <- ggplot(tmp) + geom_boxplot(aes(y = diffmass, x = mod_new)) + 
#  labs(title= "différence masse feuillage") +
#  facet_wrap(~ sp) + theme_minimal() + xlab("") + ylim(c(0, 30))
#diffmass
```

\#Code Margaux

``` r
#diffmass2 <- ggplot(tmp2) + geom_boxplot(aes(y = diffmass, x = mod_new)) + 
#  labs(title= "différence masse feuillage") +
# facet_wrap(~ sp) + theme_minimal() + xlab("") + ylim(c(0, 30))
```

``` r
#diffmass
```

``` r
#diffmass2
```

# changement code Oihana

``` r
for (n in seq_len(nrow(pairs))) {

  cur_pair  <- pairs$pairs[n]
  cur_sp1   <- pairs$sp1[n]
  cur_sp2   <- pairs$sp2[n]

  tmp <- tout[
    (pairs  == cur_pair) |
    (pairs2 == cur_pair) |
    ((sp1 == cur_sp1) & is.na(sp2)) |
    ((sp1 == cur_sp2) & is.na(sp2))
  ]

  # Si ta colonne pour le facet s'appelle 'sp' OK; sinon remplace par 'sp1'
  facet_var <- if ("sp" %in% names(tmp)) as.formula("~ sp") else as.formula("~ sp1")

  diffmass <- ggplot(tmp) +
    geom_boxplot(aes(y = diffmass, x = mod_new)) +
    labs(title = "différence masse feuillage") +
    facet_wrap(facet_var) + theme_minimal() + xlab("")

  diffvol <- ggplot(tmp) +
    geom_boxplot(aes(y = diffvol, x = mod_new)) +
    labs(title = "différence volume tige") +
    facet_wrap(facet_var) + theme_minimal() + xlab("")

}
```

\#Code Oihana

``` r
# n = 16, en gardant une garde au cas où
n <- 15
stopifnot(n >= 1, n <= nrow(pairs))

cur_pair <- pairs$pairs[n]
cur_sp1  <- pairs$sp1[n]
cur_sp2  <- pairs$sp2[n]

# Version data.table propre (référence directe aux colonnes de 'tout')
tmp <- tout[
  (pairs  == cur_pair) |
  (pairs2 == cur_pair) |
  ((sp1 == cur_sp1) & is.na(sp2)) |
  ((sp1 == cur_sp2) & is.na(sp2))
]
```

\#Code Oihana

``` r
# n = 16, en gardant une garde au cas où
n <- 16
stopifnot(n >= 1, n <= nrow(pairs))

cur_pair <- pairs$pairs[n]
cur_sp1  <- pairs$sp1[n]
cur_sp2  <- pairs$sp2[n]

# Version data.table propre (référence directe aux colonnes de 'tout')
tmp2 <- tout[
  (pairs  == cur_pair) |
  (pairs2 == cur_pair) |
  ((sp1 == cur_sp1) & is.na(sp2)) |
  ((sp1 == cur_sp2) & is.na(sp2))
]
```

# changement code Oihana

``` r
diffmass_OO <- ggplot(tmp) +
  geom_boxplot(aes(y = diffmass, x = mod_new)) +
  labs(title = "différence masse feuillage") +
  facet_wrap(~ sp) +
  theme_minimal() +
  xlab("") +
  ylim(c(0, 30)) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


ggsave(plot = diffmass_OO, filename = here("results/diffmass_OO.png"))
```

    ## Saving 7 x 5 in image

![](../results/diffmass_00.png)

Ajout des étiquettes inclinés à 45°

Code Oihana

``` r
diffmass2_OO <- ggplot(tmp2) + geom_boxplot(aes(y = diffmass, x = mod_new)) + 
  labs(title= "différence masse feuillage") +
  facet_wrap(~ sp) + theme_minimal() + xlab("") + ylim(c(0, 30))+
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)
  )
diffmass2_OO
```

![](C:/Github/cesab_open_data_project/results/README_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->
Ajout des étiquettes inclinés à 45°
