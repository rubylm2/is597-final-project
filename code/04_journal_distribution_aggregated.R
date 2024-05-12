# Topic Distribution Aggregated

## Filter the data for the journal you want to visualize (replace 'JournalName' with the actual journal name)
filtered_data <- melted_data %>%
  filter(isPartOf == "journalName")

## Aggregating data by year (assuming you want to display yearly data)
aggregated_data <- filtered_data %>%
  group_by(publicationYear, Topic) %>%
  summarize(Proportion = mean(Proportion))  # You can use sum, mean, or any other appropriate aggregation function

## Define a subset of publicationYears to display (e.g., every 2 years)
years_to_display <- seq(min(aggregated_data$publicationYear), max(aggregated_data$publicationYear), by = 2)

## Filter the aggregated data to include only the years you want to display
subset_data <- aggregated_data %>%
  filter(publicationYear %in% years_to_display)

## Plot the distribution of topics within the selected journal
ggplot(data = subset_data, aes(x = publicationYear, y = Proportion, fill = Topic)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Year", y = "Proportion", fill = "Topic") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
