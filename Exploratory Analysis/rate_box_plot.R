
library(dplyr)
library(ggplot2)

df <- read.csv('Obesity_GDP_PanelData.csv')
rates <- df %>%
  group_by(State) %>%
  summarise(
    obesity_rate = mean(Adult.Obesity) * 100,
    poverty_rate = mean(Poverty.Rate) * 100
  )

obesity_avg = mean(rates$obesity_rate)
obesity_median = median(rates$obesity_rate)
obesity_Q1 = quantile(rates$obesity_rate, 0.25)
obesity_Q2 = quantile(rates$obesity_rate, 0.75)
obesity_Q3 = obesity_Q2 - obesity_Q1
obesity_sd = sd(rates$obesity_rate)
obesity_min = min(rates$obesity_rate)
obesity_max = max(rates$obesity_rate)
obesity_range = obesity_max - obesity_min

poverty_avg = mean(rates$poverty_rate)
poverty_median = median(rates$poverty_rate)
poverty_Q1 = quantile(rates$poverty_rate, 0.25)
poverty_Q2 = quantile(rates$poverty_rate, 0.75)
poverty_Q3 = poverty_Q2 - poverty_Q1
poverty_sd = sd(rates$poverty_rate)
poverty_min = min(rates$poverty_rate)
poverty_max = max(rates$poverty_rate)
poverty_range= poverty_max - poverty_min

