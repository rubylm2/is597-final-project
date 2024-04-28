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

