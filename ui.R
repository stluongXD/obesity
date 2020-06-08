library(shiny)
library(shinythemes)
library(plotly)

source("./scripts/intro.R")
source("./scripts/conclusion.R")
source("./scripts/income.R")
source("./scripts/region_analysis_final.R")

obesity <- read.csv("./data/Obesity_GDP_PanelData.csv")

years <- selectInput(
  "years",
  label = "Years",
  choices = list("2014-2017" = as.numeric(0),
                 "2014" = as.numeric(2014),
                 "2015" = as.numeric(2015),
                 "2016" = as.numeric(2016),
                 "2017" = as.numeric(2017)),
  selected = as.numeric(0)
)

legislation_status <- selectInput(
  "legislation_status",
  label = "Legislation Status",
  choices = list("All Legislations" = as.numeric(4),
                 "Introduced" = as.numeric(0),
                 "Enacted" = as.numeric(1),
                 "Vetoed" = as.numeric(2),
                 "Dead" = as.numeric(3)),
  selected = as.numeric(4)
)

selected_state <- selectInput(
  "state_name",
  label = "Select State For Table",
  choices = sort(unique(obesity$State)),
  selected = "New York",
  multiple = FALSE,
  selectize = TRUE
  )

factors <- selectInput(
  "factors",
  label = "Factors",
  choices = list("Income" = "Income",
                 "Poverty Rate" = "Poverty_Rate",
                 "State GDP" = "State_GDP"),
  selected = "Average.Income"
)

regions <- selectInput(
  "regions",
  label = "Regions",
  choices = list(
    "Far West" = "Far West Region",
    "Great Lakes" = "Great Lakes Region",
    "Mideast" = "Mideast Region",
    "Plains" = "Plains Region",
    "New England" = "New England Region",
    "Rocky Mountain" = "Rocky Mountain Region",
    "Southeast" = "Southeast Region",
    "Southwest" = "Southwest Region"
  ),
  selected = "Far West Region"
)


ui <- shinyUI(
  fluidPage(theme = shinytheme("flatly"),
    tags$h1("Obesity In America"),
    navbarPage(
      tags$h1(), # needed to add this line so the intro tab will show
      tabPanel(
        tags$h4("Introduction"),
        tags$h4("Group Members: Steven Luong, Bridget Haney, Emma Dickenson, Jennifer Li"),
        tags$h4("Objective"),
        tags$p(objective),
        tags$h4("Datasets"),
        tags$p(first_dataset),
        tags$a(href="https://www.kaggle.com/annedunn/obesity-and-gdp-rates-from-50-states-in-20142017?fbclid=IwAR1ensCsetJhFijLB11c5A2VNBLBASLL7ctCO_ncwYJXHYMBKz4jtnyzj70#Obesity_GDP_PanelData.csv", "Obesity Dataset"),
        br(),
        br(),
        tags$p(second_dataset),
        tags$a(href="https://chronicdata.cdc.gov/Nutrition-Physical-Activity-and-Obesity/CDC-Nutrition-Physical-Activity-and-Obesity-Legisl/nxst-x9p4/data?fbclid=IwAR1lxa67cGyhoIch0QqTGW21xXCYhl-rVhM4x6pehIL0ehvzdNre0UzF52w", "Policies Dataset"),
        br(),
        tags$h4("Sections of Analysis"),
        tags$p(analysis_pt1),
        tags$p(analysis_pt2),
        tags$p(analysis_pt3)
      ),
      tabPanel(
        tags$h4("Effects of Wealth on Obesity"),
        sidebarLayout(
          sidebarPanel(
            factors  
          ),
          mainPanel(
            plotOutput("income_plot")
          )
        ),
        br(),
        tags$h4("Sections of Analysis"),
        tags$h5("Analysis on the Relationship Between Income and Obesity Rate"),
        tags$p(Analysis_Income),
        br(),
        tags$h5("Analysis on the Relationship Between Poverty Rate and Obesity Rate"),
        tags$p(Analysis_poverty),
        br(),
        tags$h5("Analysis on the Relationship Between State GDP and Obesity Rate"),
        tags$p(Analysis_GDP)
      ),
      tabPanel(
        tags$h4("Regional Differences on Obesity"),
        # add graph/sliders and related stuff goes here
        # add a paragraph of the insights gained
        sidebarLayout(
          sidebarPanel(
            regions
          ),
          mainPanel(
            plotlyOutput("regional_plot"),
            tags$br(),
            plotlyOutput("map"),
            tags$p(map_analysis),
            plotOutput("bar"),
            tags$br(),
            tags$h4("Analysis"),
            tags$p(bar_chart_analysis)
          )
        )
      ),
      tabPanel(
        tags$h4("Effectiveness of Public Policy on Obesity"),
        # add graph/sliders and related stuff goes here
        # add a paragraph of the insights gained
        sidebarLayout(
          sidebarPanel(
            years,
            legislation_status,
            selected_state
          ),
          mainPanel(
            plotlyOutput("policy_map"),
            tableOutput("states_table"),
            tags$p("Note: NA Values in table means we do not have legislation data for that year and state."),
            tags$h4("Analysis"),
            tags$p("In the scope of the United States, the displays adult obesity rates and number of policies implemented
               to help reduce obesity. Not all states
               participated in enacting health policies during certain years, so they may not show up on the map."),
            tags$p("Overall, it seems like 2015 was the year in which most states enacted most of 
               of their policies. The highest number of legislation that year was New York with 171
               enacted policies, while Georgia had the lowest with 2. It is interesting to see a 
               spike of policies in 2015, only for it to decrease drastically in 2016 and 2017."),
            tags$p("After implementing the policies, it is important to look for the impacts on obesity rate. In specifically looking at New York
               and its obesity rate of 24.2 in 2015, it can be show in 2016 and 2017, 
               the aftermath of the policies was very minimal. The obesity rate stayed around 24%, regardless of
               the attempts to decrease it. It inevitably seems like, from the data, that no policies 
               truly had a heavy impact on any of the obesity rates of any state.")
          )
        )
      ),
      tabPanel(
        tags$h4("Conclusion"),
        tags$p(wealth),
        tags$p(wealth_pt2),
        tags$p(region),
        tags$p(legislation)
      )
    )
  )
)