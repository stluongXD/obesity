library(shiny)
source("./scripts/policy.R")
source("./scripts/region.R")

server <- function(input, output) {
  output$policy_map <- renderPlotly({
    generate_map(input$years, input$legislation_status)
  })
  
  output$states_table <- renderTable({state_table_data(input$state_name)})
  
  output$income_plot <- renderPlot({
    generateplot(input$factors)
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