library(dplyr)
library(ggplot2)
library(tidyr)
library(knitr)
obesity <- read.csv("./data/Obesity_GDP_PanelData.csv")
obesity_small <- obesity %>%
  select(Adult.Obesity.100, Year, Average.Income, Poverty.Rate.100, Real.GDP) %>%
  rename(
    Income = Average.Income,
    Poverty_Rate = Poverty.Rate.100,
    State_GDP = Real.GDP
  )

generateplot <- function(input) {
  income_plot <- ggplot(obesity_small, 
       aes(x = get(input),
           y = Adult.Obesity.100,
           color = Year), inherit.aes = FALSE) +
  geom_point() +
  xlab(input) +
  ylab("Percentage of Adult Obesity By State And Year") +
  ggtitle(paste(input, " Vs. Obesity Rate")) +
  geom_smooth(method=lm)
  income_plot
}

Analysis_Income <- 
  "Unsuprisingly, we see a correlation between income and obesity. In general as the average 
income increases, we see the obesity rate decreases as well. This isn't a surprise due 
to the issue that less wealthy people are more likely to live in food deserts and have less access
to purchasing healthier foods. Another issue that can influence this correlation is that 
junk food are typically cheaper than healthier foods. We see this with fast food restaurants
and how they are able to offer very cheap meals as compared to a standard restaurant.Based on the best fit line, 
the overall trend appears to be the higher the income is, the lower the obesity rate is."

Analysis_poverty <- 
  "We continue to see the trend with wealth and obesity rates as well when we compare poverty
rates and obestiy rates. In this graph, we see that as poverty rates rises, so does the 
obesity rate. This falls in line with our conclusions with average income because income 
is the determining factor if someone lives in poverty or not. Based on the best fit line, 
the overall trend appears to be the higher the poverty rate is, the higher the obesity rate is."

Analysis_GDP <-
  "A surprising discovery we made from our analysis is the lack of strong correlation between state GDP and obesity rates.
We naturally assumed that richer states will have more funds to invest in public health, specifically in areas
that may reduce the state's obesity rates. Although, we see that the richer states do have a lower obesity rate,
we see a large spread of obesity rates for poorer states; some poorer states have one of the highest obesity rates
seen in the country, but we also see that other poor states also have the lowest obesity rates in the country.
This discovery made us want to explore the regional differences in obesity rates as well. Based on the best fit line, 
the overall trend appears to be the higher the state GDP is, the lower the obesity rate is."