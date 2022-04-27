#install.packages("shiny")
#install.packages("shinyvalidate")
#install.packages("shinyWidgets")

library(shiny)
library(shinyvalidate)
#library(shinyWidgets)

ui <- fluidPage(
  titlePanel("Epidemic Parameters"),

  sidebarLayout(
    sidebarPanel(

      numericInput(inputId = "beta",
                   label = "Daily Exposure Rate", 
                   value = 0.05, min = 0, max = 1, step = 0.00001),
      
      numericInput(inputId = "timestep",
                   label = "Number of Iterations (days)",
                   min = 1, max = 3650, value = 3, step = 1),
      
      actionButton(inputId = "validate", label = "Validate")
    ),
    
    mainPanel(

    )
  )
)

server <- function(input, output, session) {
  iv <- InputValidator$new()
  iv$add_rule("beta", sv_required())
  iv$add_rule("beta", sv_gte(0))
  iv$add_rule("timestep", sv_required())
  iv$add_rule("timestep", sv_integer())
  iv$add_rule("timestep", sv_gt(0))
  

  iv$enable()
}

shinyApp(ui, server)