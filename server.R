
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require("tidyr")
require("dplyr")
require("leaflet")
require("jsonlite")
require("downloader")
require("stringi")

shinyServer(function(input, output) {

  download(url="http://data.mos.ru/opendata/export/1232/json", dest="katki.zip", mode="wb") 
  a <- unzip ("katki.zip")
  file.rename(a, "katki.json")
  katki <- fromJSON(txt = "katki.json")
  
  c <- katki$Cells
  #c$ObjectShortName <- stri_trans_general(c$ObjectShortName,
  #                                             "cyrillic-latin; nfd; [:nonspacing mark:] remove; nfc")
  b <- c
  
output$map <- renderLeaflet({leaflet() %>%
      addTiles() %>%  setView(lng = 37.6, lat = 55.7, zoom = 9) %>%
    addCircleMarkers(data=b,lat=b$SportZoneLatitudeWGS84, lng=b$SportZoneLongitudeWGS84,
                     popup=b$ObjectShortName)})

observe({
  if(input$rent==TRUE) {
    b <- filter(b, b$ObjectHasEquipmentRental=="да")
  }
  if(input$wc==TRUE) {
    b <- filter(b, b$ObjectHasToilet=="да")
  }
  if(input$wifi==TRUE) {
    b <- filter(b, b$ObjectHasWifi=="да")
  }
  if(input$aid==TRUE) {
    b <- filter(b, b$ObjectHasFirstAidPost=="да")
  }
  if(input$dress==TRUE) {
    b <- filter(b, b$ObjectHasDressingRoom=="да")
  }
  if(input$eat==TRUE) {
    b <- filter(b, b$ObjectHasEatery=="да")
  }
    leafletProxy("map") %>% clearMarkers() %>%
     addCircleMarkers(data=b,lat=b$SportZoneLatitudeWGS84,
                      lng=b$SportZoneLongitudeWGS84, popup=b$ObjectShortName)
  
 })
})
