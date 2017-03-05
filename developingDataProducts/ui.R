#
# This Shiny application allows users to fit MPG as a function of weight 
# from the mtcars dataset linearly and see what kind of error their fit causes
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Fit the Dataset!"),
  
  # Sidebar with slider inputs for the y-intercept & slope 
  sidebarLayout(
    sidebarPanel(
        checkboxInput(inputId = "Shocker", label = "Shock Values?", value = FALSE, width = '1500%'),
        sliderInput("slider1",
                   "Y-Intercept:",
                   min = -10,
                   max = 40,
                   value = 0),
       sliderInput("slider2",
                   "Slope:",
                   min = -1,
                   max = 1,
                   step = 0.05, 
                   value = 0),
       checkboxInput(inputId = "userCheck", label = "Show Your Line?", value = FALSE),
       checkboxInput(inputId = "lmCheck", label = "Show Least Squares Line?", value = FALSE),
       submitButton("Change")
    ),
    
    # Show a plot of the fit
    mainPanel(
        h1("can you guess the least squares line?"),
        plotOutput("Plot1")
    )
  )
))
