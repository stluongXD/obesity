library("shiny")
## ----setup, include = FALSE----------------------------------------------
source("ui.R")
source("server.R")
source("policy.R")


shinyApp(ui = ui, server = server)
