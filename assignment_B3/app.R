#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#Load packages
library(shiny)
library(shinythemes)
library(tidyverse)
library(DT)
library(ggplot2)

#bcl <- read_csv("~/Desktop/STAT545A/assignment-b3-dwaynet87/assignment_B3/bcl-data.csv")

#Load data
bcl <- read.csv("https://raw.githubusercontent.com/stat545ubc-2022/assignment-b3-dwaynet87/Shiny_progress/assignment_B3/bcl-data.csv")

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

#ADD ONS FOR ASSINGMENT_B4
#5. Changed the theme for a warmer appearance.
#6. Added an image to UI.
#7. Added a summary text of the search results.
#8. Added Tab panel so the user can decide how they want to view the data graphically (histogram) or in table form.

# Define UI
ui <- fluidPage(titlePanel( "BC Liquore Store Data"),
  theme= shinytheme("journal"), #added a theme for a warmer interface
  h4("Let us help you find the right 
     drink for your mood...Enjoy!"), 
  br(),
  tags$img(src = "image.png", height= "350px", width = "390px"), #added image to UI 
  br(),
  sidebarLayout(
    sidebarPanel(
      sliderInput("priceInput", "Price", 0, 100, 
                  value = c(10, 40), pre = "$"),
      checkboxGroupInput("typeInput", "Type", 
                         choices = c("BEER", "REFRESHMENT", 
                                     "SPIRITS", "WINE"), selected = c("BEER", "WINE")),
      uiOutput("typeSelectOutput"),
      selectInput("countryInput", "Country", sort(unique(bcl$Country)), selected = "CANADA"),
      conditionalPanel(
        condition = "input.filterCountry",
        uiOutput("countrySelectorOutput")
      )
      
      
    ),
    
    mainPanel(
      h1(textOutput("Summary")),
      tabsetPanel(
        tabPanel("Data_table", dataTableOutput("Data_table")),
        tabPanel("Alcohol_histogram", plotOutput("Alcohol_histogram"))
      
    ))
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
  
  
  output$Summary <- renderText({
    numOptions <- nrow(filtered_data())
    if (is.null(numOptions)) {
      numOptions <- 0
    }
    paste0("We found ", numOptions, " options for you")
  })
  
  output$Alcohol_histogram <- 
    renderPlot({
      filtered_data() %>% 
        ggplot(aes(Alcohol_Content, fill = Type)) + geom_histogram(colour ="black") +
        theme_bw()
    })
  
  
  output$Data_table <- 
    renderDataTable({
      filtered_data()
    }) 
  

}

shinyApp(ui = ui, server = server)