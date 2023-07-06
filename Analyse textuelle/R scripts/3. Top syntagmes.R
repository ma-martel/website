require(quanteda)
require(quanteda.textstats)
require(quanteda.corpora)
library(writexl)
# options(width = 110)

# importer le corpus
corp_news <- readxl::read_xlsx("Corpus/Corpus structuré.xlsx") %>% 
  corpus() %>% 
  tokens()

corp_news

# We remove punctuation marks and symbols in tokens() and stopwords in tokens_remove() with padding = TRUE to keep the original positions of tokens.
toks_news <- tokens(corp_news, remove_punct = TRUE, remove_symbols = TRUE, padding = TRUE) %>% 
  tokens_remove(stopwords("fr"), padding = TRUE)

tstat_col_cap <- textstat_collocations(toks_news, min_count = 5, tolower = T)

# exporter les données
write_xlsx(tstat_col_cap, "Top synagmes.xlsx")
