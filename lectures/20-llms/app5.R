library(shiny)
ui <- fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30),
      selectInput("color", "Bar color:",
                  choices = c("darkgray", "steelblue", "tomato",
                              "forestgreen", "goldenrod"),
                  selected = "darkgray")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Waiting Time",
                 plotOutput("waitPlot"),
                 verbatimTextOutput("waitStats")),
        tabPanel("Eruption Duration",
                 plotOutput("eruptPlot"),
                 verbatimTextOutput("eruptStats"))
      )
    )
  )
)
server <- function(input, output) {
  output$waitPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = input$color, border = "white",
         xlab = "Waiting time (mins)", main = "Waiting Time")
  })
  output$eruptPlot <- renderPlot({
    x <- faithful$eruptions
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    hist(x, breaks = bins, col = input$color, border = "white",
         xlab = "Eruption duration (mins)", main = "Eruption Duration")
  })
  output$waitStats  <- renderPrint({ summary(faithful$waiting) })
  output$eruptStats <- renderPrint({ summary(faithful$eruptions) })
}
shinyApp(ui = ui, server = server)