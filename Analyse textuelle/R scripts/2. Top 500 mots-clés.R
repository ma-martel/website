# charger les packages
library(readtext)
library(quanteda)
library(writexl)
library(tidyverse)

# importer le corpus structuré et diviser en tokens
data <- readxl::read_xlsx("Corpus/Corpus structuré.xlsx") %>% 
  corpus() %>% 
  tokens()

# créer un vecteur de mots à retirer
vecteur <- c(stopwords("fr"),"a", "presse", "+", "lois", "conventions")

# transformer le corpus en dfm et retirer les stopwords
data_dfm <- tokens(data, 
                   remove_numbers = TRUE, 
                   remove_punct = TRUE) %>%
  tokens_remove(vecteur) %>%
  dfm()

# 500 mots les plus fréquents
topfeatures(data_dfm, 500) %>% head()

# convertir en df
results <- dfm_sort(data_dfm) %>% convert(to = "data.frame")

# sélectionner les 500 mots les plus fréquents
top_500 <- results[2:501]

# additionner les lignes de chaque colonne pour obtenir le nombre total d'occurrences de chaque mot
top_500 <- colSums(top_500)

# transformer en df
top_500 <- as.data.frame(top_500)

# ajouter une colonne avec mots
top_500$mot <- rownames(top_500)

# déplacez la colonne 'mot' en première position
top_500 <- top_500[, c(ncol(top_500), 1:(ncol(top_500)-1))]

# supprimer les noms de lignes
rownames(top_500) <- NULL

# exporter en Excel
write_xlsx(top_500, "Top 500 mots-clés.xlsx")


