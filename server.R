library(shiny)

server <- function(input, output) {
  output$policy_map <- renderPlotly({
    generate_map(input$years)
  })
}