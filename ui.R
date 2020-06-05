library(shiny)

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
        tags$p("The main objective of this report is to present an in-depth analysis on known
               causes of obesity in the United States and the preventative measures issued by
               each of the 50 states to reduce obesity. The data that is specifically being looked
               at comes from the years of 2014-2017 and consists of two datasets: one having focus
               on the causes of obesity, and one focusing on policies put in place to reduce obesity.
               These combined provides a picture of the prevalence of obesity in the United States
               and if any of the measures enacted have been impactful.
               "),
        tags$h4("Datasets"),
        tags$p("The first dataset comes from is from Kaggle. It presents several different categories of analysis related to obesity,
               such as region, average incomes, obesity rates, and poverty rate.
               "),
        tags$a(href="https://www.kaggle.com/annedunn/obesity-and-gdp-rates-from-50-states-in-20142017?fbclid=IwAR1ensCsetJhFijLB11c5A2VNBLBASLL7ctCO_ncwYJXHYMBKz4jtnyzj70#Obesity_GDP_PanelData.csv", "Obesity Dataset"),
        br(),
        br(),
        tags$p("The second dataset we are incorporating into our research is from the CDC and maps out health topics and policies implemented that are related to the health topics. In particular,
               the scope of this report was narrowed down to health topics of obesity, so the data was manipulated accordingly.
               "),
        tags$a(href="https://chronicdata.cdc.gov/Nutrition-Physical-Activity-and-Obesity/CDC-Nutrition-Physical-Activity-and-Obesity-Legisl/nxst-x9p4/data?fbclid=IwAR1lxa67cGyhoIch0QqTGW21xXCYhl-rVhM4x6pehIL0ehvzdNre0UzF52w", "Policies Dataset"),
        
         br(),
        tags$h4("Sections of Analysis"),
        tags$p("The first distinct section of the report, entitled 'Effects of Wealth on Obesity',
               involves the effects of wealth and income on 
               obesity. This is meant to demonstrate whether lower or higher incomes play a role
               in lower or higher obesity rates. "),
        tags$p("The second section of the report, 'Regional Differences on Obesity', analyzes the relationship between obesity rates and
                regions. It is meant to establish if there is any correlation between whether the location
                in the United States has an impact on the prevelance of obesity."),
        tags$p("Finally, the last section, 'Effectiveness of Public Policy on Obesity', develops a higher understanding of whether preventative measures
               and health policies that were enacted across the states have been beneficial in reducing
               obesity rates in the United States.")
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
        tags$p("Conclusion goes here")
      )
    )
  )
)