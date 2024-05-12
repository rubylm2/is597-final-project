# Distribution of Topics for ALL Journals

## load libraries
library(ggplot2)
library(tidyr)

## Extract topic numbers from column names
topic_numbers <- gsub("Topic_", "", names(merged_data)[grepl("^Topic_", names(merged_data))])
topic_numbers <- as.integer(topic_numbers)

## Melt the data for easier plotting
melted_data <- merged_data %>%
  pivot_longer(cols = starts_with("Topic_"), names_to = "Topic", values_to = "Proportion")

## Convert Topic column to factor with ordered levels
melted_data$Topic <- factor(melted_data$Topic, levels = paste0("Topic_", sort(topic_numbers)))

## Plot the distribution of topics within each journal
ggplot(data = melted_data, aes(x = publicationYear, y = Proportion, fill = Topic)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~ isPartOf, scales = "free") +
  labs(x = "Year", y = "Proportion", fill = "Topic") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Distribution of Topics for SPECIFIC Journals

## load libraries
library(ggplot2)
library(tidyr)
library(dplyr)  # Load the dplyr package for filtering data

## Extract topic numbers from column names
topic_numbers <- gsub("Topic_", "", names(merged_data_evolution)[grepl("^Topic_", names(merged_data_evolution))])
topic_numbers <- as.integer(topic_numbers)

## Melt the data for easy plotting
melted_data <- merged_data_evolution %>%
  pivot_longer(cols = starts_with("Topic_"), names_to = "Topic", values_to = "Proportion")

## Convert Topic column to factor with ordered levels
melted_data$Topic <- factor(melted_data$Topic, levels = paste0("Topic_", sort(topic_numbers)))

## Filter the data for the journal you want to visualize (replace 'journalName' with the actual journal name)
filtered_data <- melted_data %>%
  filter(isPartOf == "journalName")

## Plot the distribution of topics within the selected journal
ggplot(data = filtered_data, aes(x = publicationYear, y = Proportion, fill = Topic)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Year", y = "Proportion", fill = "Topic") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
