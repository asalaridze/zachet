
library(shiny)
require("dplyr")
require("leaflet")
require("jsonlite")
require("downloader")

shinyUI(fluidPage(

  # Application title
  titlePanel("Katki"),
  
  leafletOutput("map"),

  absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                width = 200, height = "auto",
                
  checkboxInput(inputId="rent","Object Has Equipment Rental", value = FALSE),
  checkboxInput(inputId="wc","Object Has Toilet", value = FALSE),
  checkboxInput(inputId="wifi","Object Has Wifi", value = FALSE),
  checkboxInput(inputId="aid","Object Has First Aid Post", value = FALSE),
  checkboxInput(inputId="dress","Object Has Dressing Room", value = FALSE),
  checkboxInput(inputId="eat","Object Has Eatery", value = FALSE))
  
    )
  )
