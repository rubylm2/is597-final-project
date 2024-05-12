# Install R and R Studio

# Install necessary packages

install.packages("tm")
install.packages("topicmodels")

# Load the required libraries

library(tm)
library(topicmodels)

# Prepare your data
## Replace "path_to_files" with actual file path 
### Partial file path from Github repository ("IS597-final-project\fulltext_corpus\fulltext_processed")

setwd("path_to_files")
file_list <- list.files(pattern = "*.txt")
corpus <- Corpus(DirSource(".", pattern = "*.txt"))

# Preprocess the text data remove stopwords
## Replace "path_to_stopwords.txt" with the actual file path ("IS597-final-project\code\stopwords.txt")

stopwords_path <- "path_to_stopwords.txt" 

## Read the stopwords file


stopwords <- readLines(stopwords_path)

### remove stopwards

corpus <- tm_map(corpus, removeWords, stopwords)


# Create a document-term

dtm <- DocumentTermMatrix(corpus)

# Perform Topic Modeling


lda_model <- LDA(dtm, k = 10)  # Specify the number of topics (k)

# Inspect the topics


terms <- terms(lda_model, 10)  # Get the top 10 terms for each topic
terms

## Export terms to csv 

write.csv(terms, "lda_model_terms.csv")

# Assign topics to documents

doc_topics <- posterior(lda_model)$topics

