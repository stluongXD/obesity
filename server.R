library(shiny)
source("./scripts/policy.R")

server <- function(input, output) {
  output$policy_map <- renderPlotly({
    generate_map(input$years)
  })
}