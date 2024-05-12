# Calculate the topic evolution by publicationYear 

## Load necessary packages
library(topicmodels) # For LDA modeling
library(ggplot2)     # For visualization


## Plot topic proportions by publicationYear
### Replace y = Topic_#

ggplot(data = merged_data, aes(x = as.integer(publicationYear), y = Topic_1)) +
  geom_line() +
  labs(x = NULL)
