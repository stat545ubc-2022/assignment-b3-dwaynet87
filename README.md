# BC LIQUOR APP

\In this repository you can find information and codes used to produce the BC liquor app for STA545B assignments 3 and 4 combined. 

## Assignment choice: 
1. Assignment_B3: OPTION-A BC Liquor app. 
2. Assignment_B4: OPTION C- Continue to build on BC Liquor app.

## Link to apps for assigments b3 and b4:
https://dwaynet87.shinyapps.io/assignment_B3/
https://dwaynet87.shinyapps.io/assignment_B4/

## Description: This version adds to the basic version by:
1. Adding the option to filter type search by country.
2. Adjusting the ui widget so that users can search for multiple product types simultaneously.
3. Converts the static table into an interactive table whereby users van control the number of indexes presented and curate search feature e.g. by the letter "s".
4. For better presentation, the colour was added to the histogram visuals to display by product type. 
5. Changed the theme for a warmer appearance.
6. Added an image to UI.
7. Added a summary text of the search results.
8. Added Tab panel so the user can decide how they want to view the data graphically (histogram) or in table form.

## Data
The dataset utilized is a cleaned and curated version of the products sold by BC Liquor Store and is provided OpenDataBC. The data used to developed the app is available on github and can be read in from using the read.csv finction in r: 
bcl <- read.csv("https://raw.githubusercontent.com/stat545ubc-2022/assignment-b3-dwaynet87/Shiny_progress/assignment_B3/bcl-data.csv")


The pre-cleaned version of the data can be accessed by the following link:https://catalogue.data.gov.bc.ca/dataset/bc-liquor-store-product-price-list-historical-prices


