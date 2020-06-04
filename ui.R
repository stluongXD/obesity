library(shiny)

ui <- shinyUI(
  fluidPage(
    tags$h1("Obesity In America"),
    navbarPage(
      tags$h1(), # needed to add this line so the intro tab will show
      tabPanel(
        tags$h4("Introduction"),
        tags$p("Intro goes here"
        )
      ),
      tabPanel(
        tags$h4("Effects of Wealth on Obesity")
        # graph/sliders and related stuff goes here
        # add a paragraph of the insights gained
      ),
      tabPanel(
        tags$h4("Regional Differences on Obesity")
        # add graph/sliders and related stuff goes here
        # add a paragraph of the insights gained
      ),
      tabPanel(
        tags$h4("Effectiveness of Public Policy on Obesity")
        # add graph/sliders and related stuff goes here
        # add a paragraph of the insights gained
      ),
      tabPanel(
        tags$h4("Conclusion"),
        tags$p("Conclusion goes here")
        
      )
    )
  )
)