Guide to running code

1. Install R and RStudio
2. **Install necessary packages**: Open RStudio and install the required packages. You will need 'tm' for text mining, 'topicmodels' for topic modeling, and any other packages you might need for data preprocessing.

install.packages("tm")
install.packages("topicmodels")

3. **Load the required libraries**: Load the libraries into your R session

library(tm)
library(topicmodels)

4. **Prepare your data**: Set up your working directory in R to where the .txt files are located. You will then need to load the text data into R.

setwd("path_to_your_directory")
file_list <- list.files(pattern = "*.txt")
corpus <- Corpus(DirSource(".", pattern = "*.txt"))

5. **Preprocess the text data**: Preprocess the text data to clean it and prepare it for analysis. This typically invovles steps like converting to lowercase, removing punctuation, removing numbers, removing stop words, and stemming (optional).

corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, stemDocument)

Stopwords 

stopwords_path <- "path_to_stopwords_file/stopwords.txt"
stopwords <- readLines(stopwords_path)

corpus <- tm_map(corpus, removeWords, stopwords)

6. **Create a document-term matrix (DTM)**: Convert the text data into a document-term matrix, which is a numerical representation of the text data where rows represent documents and columns represent terms.

dtm <- DocumentTermMatrix(corpus)

7. **Perform topic modeling**: Use the 'LDA' function from the 'topicmodels' package to perform Latent Dirichlet Allocation (LDA) topic modeling on the document-term matrix.

lda_model <- LDA(dtm, k = 5)  # Specify the number of topics (k)

8. **Inspect the topics**: Once the model is trained, you can inspect the topics and the most probable terms associated with each topic.

terms <- terms(lda_model, 10)  # Get the top 10 terms for each topic
terms

9. **Assign topics to documents:** You can assign topics to documents based on the probability distribution of topics within each document

corpus <- Corpus(DirSource(".", pattern = "*.txt"))

10. **Explore and interpret results**: Finally, explore the results of your topic modeling analysis, visualize topics, and interpret the findings to gain insights into the underlying themes present in your text data.


# Preprocess the text data
corpus_preprocessed <- tm_map(corpus, content_transformer(tolower))
corpus_preprocessed <- tm_map(corpus_preprocessed, removePunctuation)
corpus_preprocessed <- tm_map(corpus_preprocessed, removeNumbers)
corpus_preprocessed <- tm_map(corpus_preprocessed, removeWords, stopwords)
corpus_preprocessed <- tm_map(corpus_preprocessed, stemDocument)

# Export preprocessed text data to new text files
output_dir <- "preprocessed_text_files"
if (!file.exists(output_dir)) {
  dir.create(output_dir)
}

for (i in seq_along(corpus_preprocessed)) {
  text <- as.character(corpus_preprocessed[[i]])
  file_name <- paste(output_dir, "/", names(corpus_preprocessed)[i], sep = "")
  writeLines(text, file_name)
}

In this code:

'corpus_proprocessed' contains the preprocessed text data after applying the text transformations using 'tm_map'.
A directory called "preprocessed_text_files" to store the output files if it doesn't already exist. 
We then iterate over each document in the preprocessed corpus, extract the text content, and write it to new text files in the "preprocessed_text_files" directory. 

