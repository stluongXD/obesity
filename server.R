library(shiny)
source("./scripts/policy.R")
source("./scripts/income.R")

server <- function(input, output) {
  output$policy_map <- renderPlotly({
    generate_map(input$years)
  })
  
  output$income_plot <- renderPlot({
    generateplot(input$factors)
  })
}