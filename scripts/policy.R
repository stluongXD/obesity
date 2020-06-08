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

generate_map <- function(input_year, input_status) {
  # filters out based on legislation status
  # counts number of legislatiosn proposed or enacted
  if (input_status != 4) { #input_status of 4 signals that we want to see all the legislations
    annual_count <- grouped_states_year %>% 
    filter(StatusAltValue == input_status) %>%
    count() %>%
    rename(num_legislation = n) %>%
    select(State, LocationAbbr, Year, num_legislation, Adult.Obesity.100)
  }
  
  filtered_count <- annual_count
  if (input_year != 0) {
    annual_count$Adult.Obesity.100 <- paste("Obesity Percentage: ", annual_count$Adult.Obesity.100)
    filtered_count <- annual_count %>%
    filter(Year == input_year)
  } else {
    filtered_count <- annual_count %>%
    group_by(State, LocationAbbr) %>%
    summarise(
      num_legislation = sum(num_legislation),
      Adult.Obesity.100 = round(mean(Adult.Obesity.100), 2)
    )
    filtered_count$Adult.Obesity.100 <- paste("Average Percentage: ", filtered_count$Adult.Obesity.100)
  }
  
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


state_table_data <- function(input_state) {
  annual_count <- count(grouped_states_year, "Title") %>%
    rename(num_legislation = n) %>%
    select(State, LocationAbbr, Year, num_legislation, Adult.Obesity.100) %>%
    filter(State == input_state) %>%
    rename("Adult Obesity Percentage" = Adult.Obesity.100) %>%
    rename("All Legislation" = num_legislation) %>%
    rename("State Abbreviation" = "LocationAbbr")
  
  # need to left join for years that we do not have any legislation data
  temp <- left_join(obesity, legislation, by=c("State", "Year")) %>%
    group_by(State, Year, LocationAbbr, Adult.Obesity.100)
  
  # finds the rows where there is no legislation data
  na_rows <- temp %>%
    filter(State == input_state) %>%
    filter(is.na(Title)) %>%
    select(State, Year, LocationAbbr, Adult.Obesity.100)
  na_rows$all_legislation <- NA
  na_rows <- na_rows %>%
    rename("All Legislation" = all_legislation) %>%
    rename("Adult Obesity Percentage" = Adult.Obesity.100) %>%
    rename("State Abbreviation" = "LocationAbbr")
  
  # appends the na_rows to the annual_count 
  annual_count <- rbind(annual_count, na_rows)

  annual_count
}

