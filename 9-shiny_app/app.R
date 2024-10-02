library(shiny)
library(leaflet)
library(dplyr)
library(sf)
library(here)

# Load GeoJSON for US states
states <- sf::read_sf("https://rstudio.github.io/leaflet/json/us-states.geojson")

# Load your dataset
df <- read.csv(here::here("3-final_data", "takeout_data.csv"))

# Create a mapping of state abbreviations to full state names
state_abbrev_to_full <- c(
  "CT" = "Connecticut", "ME" = "Maine", "MA" = "Massachusetts", "NH" = "New Hampshire", 
  "RI" = "Rhode Island", "VT" = "Vermont", "NJ" = "New Jersey", "NY" = "New York", 
  "PA" = "Pennsylvania", "IL" = "Illinois", "IN" = "Indiana", "MI" = "Michigan", 
  "OH" = "Ohio", "WI" = "Wisconsin", "IA" = "Iowa", "KS" = "Kansas", "MN" = "Minnesota", 
  "MO" = "Missouri", "NE" = "Nebraska", "ND" = "North Dakota", "SD" = "South Dakota", 
  "DE" = "Delaware", "DC" = "District of Columbia", "FL" = "Florida", "GA" = "Georgia", 
  "MD" = "Maryland", "NC" = "North Carolina", "SC" = "South Carolina", "VA" = "Virginia", 
  "WV" = "West Virginia", "AB" = "Alabama", "KY" = "Kentucky", "MS" = "Mississippi", 
  "TN" = "Tennessee", "AR" = "Arkansas", "LA" = "Louisiana", "OK" = "Oklahoma", 
  "TX" = "Texas", "AZ" = "Arizona", "CO" = "Colorado", "ID" = "Idaho", "MT" = "Montana", 
  "NV" = "Nevada", "NM" = "New Mexico", "UT" = "Utah", "WY" = "Wyoming", "AK" = "Alaska", 
  "CA" = "California", "HI" = "Hawaii", "OR" = "Oregon", "WA" = "Washington"
)

# Replace state abbreviations with full state names using dplyr::recode
df <- df %>%
  mutate(state_full = recode(state, !!!state_abbrev_to_full))

# Summarize the dataset to get the average stars by state
state_data <- df %>%
  group_by(state_full) %>%
  summarise(avg_stars = mean(stars_user, na.rm = TRUE))

# Merge the states GeoJSON with your summarized data using full state names
states <- left_join(states, state_data, by = c("name" = "state_full"))

# Define color bins for average stars
bins <- c(0, 1, 2, 3, 4, 5, Inf)
pal <- colorBin("YlOrRd", domain = states$avg_stars, bins = bins)

# Create labels for each state
labels <- sprintf(
  "<strong>%s</strong><br/>%g average stars",
  states$name, states$avg_stars
) %>% lapply(htmltools::HTML)

# UI
ui <- fluidPage(
  titlePanel("Choropleth Map of Average User Ratings by State"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Average User Ratings by State")
    ),
    
    mainPanel(
      leafletOutput("us_map")
    )
  )
)

# Server
server <- function(input, output, session) {
  
  output$us_map <- renderLeaflet({
    # Create a leaflet map centered on the USA
    leaflet(states) %>%
      setView(-96, 37.8, zoom = 4) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(
        fillColor = ~pal(avg_stars),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlightOptions = highlightOptions(
          weight = 5,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE
        ),
        label = labels,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto"
        )
      ) %>%
      addLegend(pal = pal, values = ~avg_stars, 
                title = "Average User Ratings", 
                position = "bottomright")
  })
}

# Run the app
shinyApp(ui, server)
