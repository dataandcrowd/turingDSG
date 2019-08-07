library(tidyverse)
library(geojsonsf)

###############
bristol_met <- read_delim("met-data-bristol-lulsgate.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>% arrange(`Date Time`)
met_location <- geojson_sf("historic-journey-times.geojson")

plot(met_location)
