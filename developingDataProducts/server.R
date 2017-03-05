#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
   
  output$Plot1 <- reactivePlot(function() {
    plot.new()
    
    # extract the mpg & weight values from the mtcars dataset
    mpg    <- mtcars[, 1] 
    weight <- mtcars[, 6] 
    
    # extract the user defined intercept & slope from the sliders 
    yInt   <- input$slider1
    slope  <- input$slider2
    
    # shock the data points by random normal values
    if (input$Shocker) {
        mpg <- sapply(mpg, function(x) x + rnorm(1, sd = 10))
        weight <- sapply(weight, function(x) x + rnorm(1, sd = 2))
    }
    
    # plot mpg as a function of weight
    plot(mpg, weight, xlab = "MPG", ylab = "Weight", xlim = c(-10, 60), ylim = c(-4, 10))
    
    # reveal lines upon user's request
    if (input$userCheck) {
        lines(x = c(-15, 65), y = c(yInt - 15 * slope, yInt + 65 * slope), col = "blue")
    }
    if (input$lmCheck) {
        abline(lm(weight ~ mpg), col = "red")
    }
    
  }) 
  
})
