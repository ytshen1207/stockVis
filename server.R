library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
  
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  dataInput2 <- reactive({
    data <- dataInput()
    if (input$adjust) data <- adjust(dataInput())
    return(data)
  })
  
  output$plot <- renderPlot({
    chartSeries(dataInput2(), theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
  })
})