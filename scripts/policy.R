library(dplyr)
library(plotly)
library(ggplot2)

legislation <- read.csv("./data/legislation.csv", fileEncoding="UTF-8-BOM") %>%
     rename(State = LocationDesc) # need to rename column so that we can join the two data sets later
obesity <- read.csv("./data/Obesity_GDP_PanelData.csv")


combined <- merge(legislation, obesity, by=c("State", "Year"))

grouped_states_year <- combined %>%
  group_by(State, Year, LocationAbbr, Adult.Obesity.100)

# counts number of legislatiosn proposed or enacted
annual_count <- count(grouped_states_year, "Title") %>%
  rename(num_legislation = n) %>%
  select(State, LocationAbbr, Year, num_legislation, Adult.Obesity.100)

View(annual_count)

annual_count$Adult.Obesity.100 <- paste("Obesity Percentage: ", annual_count$Adult.Obesity.100)

generate_map <- function(input_year) {
  filtered_count <- annual_count %>%
    filter(Year == input_year)
  
  geography <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = FALSE
  )
  
  fig <- plot_geo(filtered_count, locationmode = 'USA-states') %>%
    add_trace(z = ~num_legislation, text = ~Adult.Obesity.100, locations = ~LocationAbbr,
              color = ~num_legislation, colors = 'Blues') %>%
    layout(title = "Obesity Related State Legislation Introduced",
           geo = geography)
    
  fig <- fig %>%
         colorbar(title = "Legislation")
  fig
}
