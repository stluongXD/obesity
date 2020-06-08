
library(dplyr)
library(ggplot2)
library(leaflet)
library(usmap)
library(htmltools)
library(plotly)
library(ggplot2)

df <- read.csv("./data/Obesity_GDP_PanelData.csv")

legislation <- read.csv("./data/states.csv")

df <- merge(legislation, df, by = "State")
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
  ylab("Average Obesity Rate Percentage") +
  ggtitle("Average Obesity Rate for each region") 

show(bar_plot)

obesity <- df %>%
  group_by(Region) %>%
  summarize(
    o_rate_region = mean(Adult.Obesity.100),
    i_region = mean(Average.Income),
    p_rate_region = mean(Poverty.Rate.100)
  )

regional_data <- full_join(df, obesity, by = "Region") %>%
  mutate(state = State)

filter_region <- function(region, color_num) {
  regional_data %>%
    filter(Region == region) %>%
    mutate(color = color_num)
}

seventh <- regional_data %>%
  mutate(text = paste(Region, "<br>", "Obesity Rate: ", round(o_rate_region, 2), "%", "<br>", "Poverty Rate: ", round(p_rate_region, 2), "%", "<br>", "Average Income: ", round(i_region, 0), "$"))

geography <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showlakes = FALSE
)

fig2 <- plot_geo(seventh, locationmode = 'USA-states') %>%
  add_trace(z = ~round(o_rate_region, 2), locations = ~Abbreviation, text = ~text,
            color = ~o_rate_region, colors = 'Blues') %>%
  layout(title = "Obesity Rate by Region",
         geo = geography)

fig2 <- fig2 %>%
  colorbar(title = "Obesity Rate")

fig2

state_group <- seventh %>%
  group_by(State, Region) %>%
  summarize(
    o_rate_state = mean(Adult.Obesity.100)
  )

create_plot <- function(region) {
  chosen_region <- state_group %>%
    filter(Region == region)
  
  plot <- ggplot(chosen_region, 
                 aes(x = State, y = o_rate_state)) + 
    geom_bar(aes(fill = State), stat = "identity") +
    coord_flip() +
    xlab("State") +
    ylab("Average Obesity Rate Percentage") +
    ggtitle(paste("Average Obesity Rate by", region))
  
  plot
}

