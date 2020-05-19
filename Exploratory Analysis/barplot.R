library(dplyr)
library(ggplot2)

df <- read.csv('Obesity_GDP_PanelData.csv')

data <- df %>% select(Region, Adult.Obesity.100)

data2 <- data %>% group_by(Region) %>%
  summarize(avg=mean(Adult.Obesity.100)) %>%
  mutate_if(is.numeric, round, 1)


bar_plot <- ggplot(data2, 
                   aes(x = Region, y = avg)) + 
  geom_bar(aes(fill = Region), stat = "identity") +
  geom_text(aes(label=avg), position=position_dodge(width=0.5), vjust= 1, hjust=-0.075) +
  coord_flip() +
  xlab("Region") +
  ylab("Average Obesity Rate (Out of 100)") +
  ggtitle("Average Obesity Rate for each region") 

show(bar_plot)