# plot distribution of documents

## Load libraries

library(ggplot2)
library(dplyr)

### Assuming you followed previous code and'merged_data' is part of your objects

## Select the top 10 topics (adjust the range accordingly)
selected_topics <- paste0("Topic_", 1:10)

## Subset the data to include only the selected topics
selected_data <- merged_data %>%
  select(isPartOf, publicationYear, starts_with(selected_topics))

## Melt the data for easy plotting
melted_data_2 <- selected_data %>%
  pivot_longer(cols = starts_with("Topic_"), names_to = "Topic", values_to = "Score") %>%
  mutate(Topic = gsub("Topic_", "", Topic) %>% as.integer()) %>%
  arrange(Topic)

## Plot the distribution of documents per topic, color coded by journal
ggplot(data = melted_data_2, aes(x = reorder(factor(Topic), Topic), y = Score, color = isPartOf)) +
  geom_point(size = 3, alpha = 0.6) +
  labs(x = "Topic", y = "Score", color = "Journal") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
