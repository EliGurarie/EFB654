library(shiny)
ui <- fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
      numericInput("ymax", "Y-axis maximum:", value = 40, min = 1, max = 200),
      selectInput("column", "What to plot:",
                  choices = c("eruptions", "waiting"),
                  selected = "eruptions"), 
    ),
    
    mainPanel(
      plotOutput("distPlot"),
      textOutput("summary"),
      verbatimTextOutput("stats")
    )
  )
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- faithful[, input$column]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins,
         col = "grey", border = 'darkgrey',
         ylim = c(0, input$ymax),
         xlab = ifelse(input$column == "column", 
                       'Waiting time to next eruption (mins)', 
                       "Duration of eruptions (min)"), 
         main = 'Histogram of waiting times')
  })
  
  output$summary <- renderText({
    x    <- faithful[,input$column]
    bins <- seq(min(x), max(x), 
                length.out = input$bins + 1)
    counts <- hist(x, breaks = bins, plot = FALSE)$counts
    
    paste("Showing", input$bins, "bins.",
          "Largest bin count:", max(counts))
  })
  
  output$stats <- renderPrint({
    x <- faithful[,input$column]
    summary(x)
  })
}
shinyApp(ui = ui, server = server)