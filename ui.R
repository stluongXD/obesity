library(shiny)
library(plotly)
source("./scripts/intro.R")
source("./scripts/conclusion.R")

years <- selectInput(
  "years",
  label = "Years",
  choices = list("2014" = as.numeric(2014),
                 "2015" = as.numeric(2015),
                 "2016" = as.numeric(2016),
                 "2017" = as.numeric(2017)),
  selected = as.numeric(2014)
)


ui <- shinyUI(
  fluidPage(
    tags$h1("Obesity In America"),
    navbarPage(
      tags$h1(), # needed to add this line so the intro tab will show
      tabPanel(
        tags$h4("Introduction"),
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
        tags$h4("Effects of Wealth on Obesity")
      ),
      tabPanel(
        tags$h4("Regional Differences on Obesity")
        # add graph/sliders and related stuff goes here
        # add a paragraph of the insights gained
      ),
      tabPanel(
        tags$h4("Effectiveness of Public Policy on Obesity"),
        # add graph/sliders and related stuff goes here
        # add a paragraph of the insights gained
        sidebarLayout(
          sidebarPanel(
            years
          ),
          mainPanel(
            plotlyOutput("policy_map")
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