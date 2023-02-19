library(aws.s3)
library(data.table)
library(dplyr)
library(ggplot2)
library(leaflet)
library(plotly)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
# App was created by Brennan Larson. Email: BrennanLarson@protonmail.com
# App can be accessed here: https://zzz-polished-a3181562-86b4-4a27-9e71-5a8e483b1b19-amai4lhqja-ue.a.run.app

# Call AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_DEFAULT_REGION
# using the Sys.getenv command.
bucketlist(key = Sys.getenv("AWS_ACCESS_KEY_ID"),
           secret = Sys.getenv("AWS_SECRET_ACCESS_KEY"),
           location = Sys.getenv("AWS_DEFAULT_REGION"))


# Load a dataframe called country_continent_infrastructure from AWS S3.
# The dataframe is used as a schema of sorts linking the file structure
# in the AWS S3 bucket, so we can call the country files from AWS S3 easily.
country_continent_infrastructure <<- s3read_using(FUN = data.table::fread,
  object = sprintf("s3://appsilon.coding.challenge/app_country_continent_structure.csv"))


# Create a search button module that is displayed on our app.
searchButtonUI <- function(id, label = "Search Button") {
  ns <- NS(id)
  tagList(
    shinydashboardPlus::box(align = "right", width = 12,
                            sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                              label = "Search animals by common name or scientific name")
    )
  )
}

# Create a continent selector dropdown menu module.
continentSelectorUI <- function(id, label = "Continent Selector") {
  ns <- NS(id)
  tagList(
    shinydashboardPlus::box(align = "center", width = 12,
                            htmlOutput("continent_selector")
    )
  )
}

# Create a country selector dropdown menu module.
countrySelectorUI <- function(id, label = "Country Selector") {
  ns <- NS(id)
  tagList(
    shinydashboardPlus::box(align = "center", width = 12,
                            htmlOutput("country_selector")
    )
  )
}

# Create a module for displaying the animal observation timeline graph.
graph_display_observationsUI <- function(id, label = "Graph Observations") {
  ns <- NS(id)
  tagList(
    shinydashboardPlus::box(align = "center", width = 12,
                            plotlyOutput("animal_observation_timeline")
    )
  )
}

# Create a module for displaying the map observations.
map_display_observationsUI <- function(id, label = "Map Observations") {
  ns <- NS(id)
  tagList(
    shinydashboardPlus::box(align = "center", width = 12,
                            leafletOutput("mymap", height = 600, width = "100%")
    )
  )
}

# Create the app's header as a module.
appHeaderUI <- function(id, label = "App Header") {
  ns <- NS(id)
  tagList(
    fluidRow(style = "background-color:#FFFFFF;",
             fluidRow(
               column(width = 12,
                      shinydashboardPlus::box(align = "center",
                        img(src="https://connect.appsilon.com/arctic-fauna/_w_be84186a/static/images/appsilon-logo.png",
                            width=100),
                        HTML('<span style="font-family:Roboto">
                          <font size="4"><b>Global Animal Sightings</b></font></span>')
          ),
        )
      ),
    )
  )
}

# Create the app's footer as a module.
appFooterUI <- function(id, label = "App Footer") {
  ns <- NS(id)
  tagList(
    fluidRow(style = "background-color:#FFFFFF;",
             fluidRow(
               column(width = 3,
                      shinydashboardPlus::box(align = "center", width = 12,
                        img(src="https://connect.appsilon.com/arctic-fauna/_w_be84186a/static/images/appsilon-logo.png", width=150),
                        HTML('<h4><center><span style="font-family:Roboto">Built with ❤ by Appsilon</h4></span></center>'),
                        HTML('<h4><center><span style="font-family:Roboto">
                          <a href="https://appsilon.com/#contact" style="color: #0078D4">
                          <b>Let&apos;s Talk</b></span></center></a></h4>')
          )
        )
      ),
    )
  )
}

# Main part of the UI file where the modules are called and some structure is
# used for the body portion of the app.
shinyUI(fluidPage(

  # Call the style.css file, which is used to display scientific animal names
  # when a user click on a map marker.
  includeCSS("style.css"),
  tags$style('.container-fluid {
                background-color: #F8F7F7;
             }'),

  # Display the app's header.
  appHeaderUI("appHeader", "App Header"),

  # Create some structure to the body of the app using a mixture of fluidRows
  # columns. Call the searchButtonUI, continentSelectorUI, countrySelectorUI,
  # graph_display_observationsUI, and map_display_observationsUI modules
  # so they are display on the app.
  fluidRow(
    column(width = 6,
       fluidRow(
         column(width = 12, searchButtonUI("searchButton", "Search Button"))
        ),
       fluidRow(style = "background-color:#FFFFFF;",
          column(width = 6, continentSelectorUI("continentSelector", "Continent Selector")),
          column(width = 6, countrySelectorUI("countrySelector", "Country Selector"))
        ),
       fluidRow(graph_display_observationsUI("graph_display", "Graph Display")
        )
      ),
    column(width = 6, map_display_observationsUI("map_display", "Map Display"))
      ),

  # Display the app's footer.
  appFooterUI("appFooter", "App Footer")
))

