Sys.setlocale("LC_ALL","English")
library(sf)
library(tidyverse)
library(geojsonsf)
library(ggspatial)
library(mapview)


# Import Lower Super Output Area of Bristol
# Import air quality data
lsoa <- read_sf("bristol_lsoa/lsoa110.shp")
road <- read_sf("bristol_road/bristol_road_main.shp")
aq <- read_delim("air-quality-data-continuous.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>% arrange(`Date Time`)

# Convert the stringed coordinates to separate columns
aq <- aq %>% 
  separate(geo_point_2d, sep = ", ", into = c("Lat", "Long")) %>% 
  mutate(Long = as.numeric(Long),
         Lat  = as.numeric(Lat))

stations <- aq %>%  select(Location, SiteID, Long, Lat) %>% filter(SiteID %in% c(452,203,501,463,270,215,500)) %>% unique() 
stations_sf <- st_as_sf(stations, coords = c("Long", "Lat"), crs = 4326, agr = "constant") %>% st_transform(27700)




journey <- geojson_sf("historic-journey-times.geojson")

journey[1:30,]-> test
test$datetime <- sapply(strsplit(test$time, split='+', fixed=TRUE), function(x) (x[1]))
test$datetime <- str_replace(test$datetime, "[T]", " ")
test$datetime <- lubridate::ymd_hms(test$datetime, tz="Europe/London")


p <- test %>% 
  group_by(section_id, datetime, section_description) %>% 
  #summarise(mean_speed = mean(est_speed)) %>% 
  #st_cast("LINESTRING") %>% 
  st_transform(27700)



#ggplot() +
#  geom_sf(data = lsoa, alpha = .2) +
#  geom_sf(data = road, colour = "blue", size = 2) +
#  theme_minimal()


mapview(road["function"], col.regions = sf.colors(10)) + p["est_speed"] #+ stations_sf["Location"]



