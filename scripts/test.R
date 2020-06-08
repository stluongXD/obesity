library(ggplot2)

obesity_data <- read.csv("./data/Obesity_GDP_PanelData.csv")

test <- ggplot(obesity_data,
       aes(x = Poverty.Rate.100,
           y = Adult.Obesity.100,
           color = Year)) +
  geom_point() +
  xlab("Poverty Rate Percentage in State") + 
  ylab("Percentage of Adult Obesity By State And Year") +
  ggtitle("Poverty Rate Vs. Obesity Rate")