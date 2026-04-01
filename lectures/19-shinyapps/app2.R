library(shiny)
ui <- fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
      numericInput("ymax", "Y-axis maximum:", value = 40, min = 1, max = 200),
      selectInput("color", "Bar color:",
                  choices = c("darkgray", "steelblue", "tomato",
                              "forestgreen", "goldenrod"),
                  selected = "darkgray")
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)
server <- function(input, output) {
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins,
         col = input$color, border = 'white',
         ylim = c(0, input$ymax),
         xlab = 'Waiting time to next eruption (in mins)',
         main = 'Histogram of waiting times')
  })
}
shinyApp(ui = ui, server = server)
