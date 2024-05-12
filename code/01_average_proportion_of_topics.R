# Code to calculate average proportion across decades

## Plot ALL topics

doc_topics <- posterior(lda_model)$topics

### Convert the matrix to a data frame
doc_topics_df <- as.data.frame(doc_topics)

### Assign column names
colnames(doc_topics_df) <- paste0("Topic_", 1:ncol(doc_topics_df))  # Assuming the columns represent topics

### Add a 'doc_id' column using the row names
doc_topics_df$doc_id <- rownames(doc_topics_df)

### Inspect the structure and first few rows of the data frame
str(doc_topics_df)
head(doc_topics_df)

### Merge data frames using the 'doc_id' column
metadata <- read.csv("metadata.csv")  # Replace "metadata.csv" with the actual file path ("IS597-final-project\metadata\fulltext_corpus_metadata.csv")
merged_data <- merge(doc_topics_df, metadata, by = "doc_id", all.x = TRUE)

### Convert datePublished to Date format
merged_data$datePublished <- as.Date(merged_data$datePublished, format = "%m/%d/%Y")

### Extract year from datePublished
merged_data$publicationYear <- format(merged_data$datePublished, "%Y")

### Convert the year to numeric and then calculate the decade
merged_data$decade <- as.numeric(merged_data$publicationYear) %/% 10 * 10

### Load the dplyr package
library(dplyr)
library(ggplot2)

### Group by decade and calculate the mean presence of each topic
average_presence <- merged_data %>%
  group_by(decade) %>%
  summarise(across(starts_with("Topic_"), mean, na.rm = TRUE))

### Convert data from wide to long format
average_presence_long <- tidyr::pivot_longer(average_presence, 
                                             cols = starts_with("Topic_"), 
                                             names_to = "Topic", 
                                             values_to = "Proportion")

### Extract the numeric part of the topic names
average_presence_long$Topic <- gsub("Topic_", "", average_presence_long$Topic)

### Convert Topic to numeric for sorting
average_presence_long$Topic <- as.numeric(average_presence_long$Topic)

### Sort the data by Topic
average_presence_long <- average_presence_long[order(average_presence_long$Topic), ]

### Plot the line graph with bolder lines
ggplot(average_presence_long, aes(x = decade, y = Proportion, color = factor(Topic))) +
  geom_line(size = 1) +  # Adjust the size as needed
  labs(x = "Decade", y = "Average Proportion", color = "Topic", 
       title = "Average Proportion of Topics Over Decades") +
  theme_minimal()


## Plot SPECIFIC topics

library(ggplot2)

### Assign topic over the years
topic_number <- #

### Filter the data for the specific topic
topic_data <- average_presence_long[average_presence_long$Topic == topic_number, ]

### Plot the line graph for the specific topic
ggplot(topic_data, aes(x = decade, y = Proportion)) +
  geom_line(size = 1, color = "blue") +  # Adjust the size and color as needed
  labs(x = "Decade", y = "Average Proportion", 
       title = paste("Average Proportion of Topic", topic_number, "Over Decades")) +
  theme_minimal()