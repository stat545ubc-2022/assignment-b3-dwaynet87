#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(DT)
library(colourpicker)

bcl <- read_csv("~/Desktop/STAT545A/assignment-b3-dwaynet87/assignment_B3/bcl-data.csv")

#Feature changes: OPTION A

#1. There’s at least one new functional widget that modifies at least one output.
#Action: Added the option to filter by country.

#2. There’s at least one change to the UI (aside from the addition of a widget).
#Action: changed the typeInput radio buttons into checkboxes (checkboxGroupInput()) to 
#search for multiple types simultaneously. 

#3. A third feature, whether it’s a change to the UI, or a functional widget.
#Action: Use the DT package to turn the static table into an interactive table to allow adjustments 
#to the number of entries presented and add search specifications e.g.items starting with the letter 's'.

#4. Updated histogram to display per type of product for easier visualization.

ui <- fluidPage(
  titlePanel("BC Liquor Store Data"), 
  h5("Drink Responsibly!"), 
  br(), 
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, 
                  value = c(25, 40), pre = "$"),
      checkboxGroupInput("typeInput", "Type", 
                   choices = c("BEER", "REFRESHMENT", 
                               "SPIRITS", "WINE"), selected = "BEER"),
      uiOutput("typeSelectOutput"),
      checkboxInput("filterCountry", "Filter by country", FALSE),
      conditionalPanel(
        condition = "input.filterCountry",
        uiOutput("countrySelectorOutput")
       
      )
        
  
    ),
    
    mainPanel(
      plotOutput("alcohol_hist"), 
      dataTableOutput("data_table")
    )
  ), 
  a(href="https://github.com/daattali/shiny-server/blob/master/bcl/data/bcl-data.csv", 
    "Link to the original data set")
)

server <- function(input, output) {
  output$countrySelectorOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")  
    })
  filtered_data <- 
    reactive({
      bcl %>% filter(Price > input$priceInput[1] & 
                       Price < input$priceInput[2] & 
                       Type == input$typeInput & Country == input$countryInput
                     )
    })
  
  output$alcohol_hist <- 
    renderPlot({
      filtered_data() %>% 
        ggplot(aes(Alcohol_Content, fill = Type)) + geom_histogram(colour ="black") +
        theme_classic()
    })
  
  output$data_table <- 
    renderDataTable({
      filtered_data()
    }) 
}

shinyApp(ui = ui, server = server)