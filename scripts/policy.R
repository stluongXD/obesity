library(dplyr)
legislation <- read.csv("../data/legislation.csv") %>%
  rename(State = LocationDesc) # need to rename column so that we can join the two data sets later
obesity <- read.csv("../data/Obesity_GDP_PanelData.csv")

combined <- merge(legislation, obesity, by=c("State", "Year"))