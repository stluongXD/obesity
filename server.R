library(shiny)
source("./scripts/policy.R")
source("./scripts/region.R")

server <- function(input, output) {
  output$policy_map <- renderPlotly({
    generate_map(input$years)
  })
  output$regional_plot <- renderPlotly({
    create_plot(input$regions)
  })
  output$chosen_region <- renderText({
    input$regions
  })
  output$map <- renderPlotly({
    fig2
  })
  output$bar <- renderPlot({
    bar_plot
  })
}
