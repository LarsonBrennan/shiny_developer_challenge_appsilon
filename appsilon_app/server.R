# Beginning of the server file.
shinyServer(function(input, output, session) {

  # Create continent selector button that is called to the ui.R file.
  # Button is used for filtering in the country selector button below.
  output$continent_selector = shiny::renderUI({
    selectInput(inputId = "continent",
                label = HTML('<h6><b><span style="color:#373635;">CONTINENT</span></b></h6>'),
                choices = as.character(unique(country_continent_infrastructure$continent))
                )
  })

  # Create the country selector button that is called to the ui.R file.
  # Country selector button is primarily used for getting country files from AWS.
  output$country_selector = shiny::renderUI({
    subset_data <- country_continent_infrastructure[country_continent_infrastructure$continent == input$continent, "country"]
    selectInput(inputId = "country",
                label = HTML('<h6><b><span style="color:#373635;">COUNTRY</span></b></h6>'),
                choices = unique(subset_data),
                selected = unique(subset_data)[1]
                )
  })

  # Use the country selector button to get a country's csv file from AWS and
  # then load that file as a dataframe. Function is called get_data_aws
  get_data_aws <- reactive({
    chosen_country_data <- dplyr::filter(country_continent_infrastructure, country == input$country)
    country_choose <- sprintf("s3://appsilon.coding.challenge/%s.csv", chosen_country_data$country[1])
    chosen_country_data <- s3read_using(FUN = data.table::fread, object = country_choose)
  })

  # Call the get_data_aws function to get the dataframe, then once text data
  # has been entered into the search bar subset the dataframe by the search
  # bar text data by either vernacular name or scientific name.
  load_data <- function() {
    example_data<-get_data_aws()
    req(input$searchText)
    example_data = example_data[tolower(vernacularName) %like% tolower(input$searchText) |
                                  tolower(scientificName) %like% tolower(input$searchText)]
  }

  # Create a default observation graph function which is called when no
  # text data has been entered into the text bar, or and error has occured.
  # This function returns a graph telling a user to use the search bar.
  default_observation_graph <- function() {
    text = paste("\n   Please use the search bar to find animals.\n",
                 "     Once you have searched for an animal the \n chart and map will be displayed.\n")
    ggplot_no_data<-ggplot() +
      annotate("text", x = 4, y = 25, size=6, label = text) +
      theme_void()
    ggplotly(ggplot_no_data) %>% config(displayModeBar = F)
  }

  # This is the main graph displayed if text data has been entered.
  # When text data has been entered a timeline is shown for the animal searched
  # and it also shows how many of that animal were seen on a given day.
  output$animal_observation_timeline <- renderPlotly({

    # If no text data has been entered call the default_observation_graph
    # to tell a user to enter text data into the search bar.
    if (nchar(input$searchText) < 1) {
      default_observation_graph()
    }
    # Else use a try catch statement. If an error occurs call the
    # default_observation_graph again. Else display the timeline data
    # and the number of observations for that animal on a given day.
    else {
      tryCatch(
        {
          example_data <- load_data()

          # Count the number of observations for each categorical variable.
          example_data <- example_data %>%
            group_by(vernacularName, eventDate) %>%
            summarise(Count = n())

          # Sort the dataframe by the last observed date first.
          example_data <- example_data[rev(order(as.Date(example_data$eventDate,
                                                         format="%Y/%m/%d"))),]

          # Get the total number of observations for the animal.
          observations_total <- sum(example_data$Count)

          # Get the last seen date for the animal.
          last_seen_date <- example_data$eventDate[1]

          # Create the graph headline title and xaxis titles.
          headline_title = paste("<b><span style='color:#26BAD4;'>",
                               input$searchText,"</span>total observations:<span style='color:#26BAD4;'>",
                               observations_total,"</span><br>Located in<span style='color:#26BAD4;'>",
                               input$country, "</span></b>", sep=" ")
          xaxis_title = paste("<b>Last date observed:<span style='color:#26BAD4;'>",
                              last_seen_date,"</span></b>")

          # Rename the dataframe count, vernacularname, and eventdate variables
          # so they display nicer on plotly.
          example_data <- example_data %>%
            rename(Date = eventDate, Observed = Count, Animal = vernacularName)

          # Graph the timeline data using ggplot then display the results with
          # ggplotly.
          ggplot_timeline <- ggplot(
            data = example_data,
            aes(colour = Animal, x = Date, y = Observed)) +
            geom_point(size=2.5) +
            scale_x_date(breaks = scales::pretty_breaks(n = 10)) +
            labs(title = headline_title, x = xaxis_title, y = "") +
            theme(
              axis.text.x = element_text(angle = 55, vjust = 0.5, hjust=1),
              axis.title.y=element_blank(), panel.grid.major = element_blank(),
              panel.grid.minor = element_blank(), panel.background = element_blank(),
              axis.line = element_line(colour = "black")
              ) +
            scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(0, (max(x) + 1) * 1.1)))))

          ggplotly(ggplot_timeline)  %>% config(displayModeBar = F)

        },
        # If error occured call the default_observation_graph
        error = function(e){
          default_observation_graph()
        }
      )
    }
  })

    # Display the leaflet map on the UI.R file as mymap.
    # If the search bar has no text data show a default leaflet map.
    # Else if an error does not occur show the leaflet map with all of the
    # animal observations on the map. If an error occurs show a default leaflet
    # map.
    output$mymap <- renderLeaflet({
      if (nchar(input$searchText) < 1) {
        leaflet()
      } else {
          tryCatch(
            {
              example_data <- load_data()
              leaflet() %>%
                addTiles() %>%
                addCircleMarkers(
                  lat=example_data$latitudeDecimal, label = example_data$vernacularName,
                  # Popup will display scientific names for animals if the marker
                  # is clicked on.
                  lng=example_data$longitudeDecimal, popup = example_data$scientificName,
                  color= "#26BAD4", weight = 5, fill = TRUE)
            },
            error = function(e){
              leaflet()
            }
          )
        }
    })

# End of the server file.
})
