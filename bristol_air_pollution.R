library(tidyverse)
library(tidyquant)
library(sf)
library(leaflet)
library(plotly)

Sys.setlocale("LC_ALL","English")


# Import Lower Super Output Area of Bristol
# Import air quality data
lsoa <- read_sf("bristol_lsoa/lsoa110.shp")
aq <- read_delim("air-quality-data-continuous.csv", ";", escape_double = FALSE, trim_ws = TRUE) %>% arrange(`Date Time`)

# Convert the stringed coordinates to separate columns
aq <- aq %>% 
      separate(geo_point_2d, sep = ", ", into = c("Lat", "Long")) %>% 
      mutate(Long = as.numeric(Long),
             Lat  = as.numeric(Lat))

# Check the locations
aq %>% select(Location, Long, Lat) %>% unique() -> locations_alltime

# Overall locations 16
locations_alltime %>% 
  leaflet() %>% 
  addTiles() %>%
  addMarkers(~Long, ~Lat, label = ~as.character(Location))  


# ggsave temporal plot

aq %>%
  ggplot(aes(`Date Time`, NO2, SiteID)) +
  geom_line() +
  facet_wrap(~Location + SiteID) -> temporal_no2

ggsave("no2_temporal.png", temporal_no2, width = 10, height = 10, dpi = 600)


# Sort stations which are currently measured
aq %>% 
  select(Location, SiteID, Long, Lat) %>% 
  filter(SiteID %in% c(452,203,501,463,270,215,500)) %>% 
  unique() -> locations_realtime


# Overall locations 17
locations_realtime %>% 
  leaflet() %>% 
  addTiles() %>%
  addMarkers(~Long, ~Lat, label = ~as.character(Location))  



###################
aq$days <- lubridate::wday(aq$`Date Time`)
aq$hour <- lubridate::hour(aq$`Date Time`)
aq$Date <- lubridate::date(aq$`Date Time`)
aq$weekdays  <- ifelse(aq$hour >= 6 , "weekend", "weekdays")

nox <- aq %>% 
  select(Date, NOx, Location, weekdays, hour) %>% 
  reshape2::melt(id = c("Date", "Location", "weekdays", "hour"), 
                 variable.name = "Type", value.name = "Value")


nox.tib <- as_tibble(nox) %>% group_by(Location, hour, weekdays)


nox.day <- nox.tib %>%
  tq_transmute(
    select     = Value,
    mutate_fun = apply.daily, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "mean_nox"
  )

nox.day$mean_nox[is.nan(nox.day$mean_nox) == T] <- NA
nox.day <- na.omit(nox.day)

nox.day %>% 
  ggplot(aes(x = Date, y = mean_nox, color = Location)) +
  geom_line() +
  labs(x = "", y = "Concentration") +
  facet_wrap(~ Location, scale = "free_y") +
  theme_bw() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) 



nox.day %>%
  filter(Location == "AURN St Pauls") %>% 
  ggplot(aes(x = Date, y = mean_nox, color = Location)) +
  geom_line() +
  labs(x = "", y = "Concentration") +
  theme_bw() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) -> nox.plot


ggplotly(nox.plot)



nox.month <- nox.tib %>%
  tq_transmute(
    select     = Value,
    mutate_fun = apply.monthly, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "mean_nox"
  )

nox.month$mean_nox[is.nan(nox.month$mean_nox) == T] <- NA
nox.month <- na.omit(nox.month)

##################################

nox.month %>%
  ggplot(aes(x = hour, y = mean_nox, group = hour, fill = Location)) +
  geom_boxplot() +
  labs(x = "", y = "Concentration") +
  facet_wrap(~ Location, scale = "free_y") +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=20)) 


nox.stats <- nox %>%
  group_by(Date, Location) %>%
  summarise(mean=round(mean(Value, na.rm = T),3),
            sd=round(sd(Value, na.rm = T),3),
            min=round(min(Value, na.rm = T),3),
            `25%`=round(quantile(Value, probs=0.25, na.rm = T),3),
            `50%`=round(quantile(Value, probs=0.50, na.rm = T),3),
            `75%`=round(quantile(Value, probs=0.75, na.rm = T),3),
            max=round(max(Value, na.rm = T),3)          
  )

nox.stats <- nox.stats[!is.nan(nox.stats$mean),] %>% arrange(Location)

##############
#--Nox 2018--#
##############

aq %>% select(`Date Time`, Location, SiteID, NO2) %>% 
  filter(`Date Time` >= "2018-01-01", SiteID != 566) -> no2.2018

no2.2018 %>%
  ggplot(aes(`Date Time`, NO2, SiteID)) +
  geom_line() +
  facet_wrap(~Location + SiteID, scales = "free") +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=15)) 

############################
#-- Weekdays vs Weekends --#
############################

no2.2018 %>% mutate(weekdays = wday(no2.2018$`Date Time`, label = TRUE)) -> no2.2018

no2.2018 %>% 
  ggplot(aes(weekdays, NO2, group = weekdays)) +
  geom_boxplot() +
  facet_wrap(~Location + SiteID, scales = "free") +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=15)) 


#############
#--Monthly--#
#############

no2.2018 %>% 
  mutate(Date = date(`Date Time`)) %>%
  select(-`Date Time`) %>% 
  group_by(Location, SiteID, weekdays) %>% 
  tq_transmute(
    select     = NO2,
    mutate_fun = apply.monthly, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "monthly_no2"
  ) -> no2.2018.monthly


no2.2018.monthly <- no2.2018.monthly[!is.nan(no2.2018.monthly$monthly_no2),] %>% arrange(Location)

no2.2018.monthly %>% 
  ggplot(aes(weekdays, monthly_no2, group = weekdays, fill = weekdays)) +
  geom_boxplot(outlier.shape=NA) +
  geom_hline(aes(yintercept= 40), lwd = 1, color="black", linetype="dashed", alpha = .3) +
  facet_wrap(~ Location + SiteID, scales = "free") +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=15)) -> no2.2018.monthly.gg

ggsave("no2_box.png", no2.2018.monthly.gg, width = 15, height = 10, dpi = 600)


#######################
#--Daily 

no2.2018 %>% 
  mutate(Date = date(`Date Time`)) %>%
  select(-`Date Time`) %>% 
  group_by(weekdays, SiteID, Location) %>% 
  tq_transmute(
    select     = NO2,
    mutate_fun = apply.daily, 
    FUN        = mean,
    na.rm      = TRUE,
    col_rename = "daily_no2"
  ) -> no2.2018.daily

no2.2018.daily <- no2.2018.daily[!is.nan(no2.2018.daily$daily_no2),] %>% arrange(Date)


no2.2018.daily.holiday <- no2.2018.daily %>% 
  filter(Date >= "2018-08-01") %>% 
  left_join(holiday, by = c("Date" = "date")) %>% 
  na.omit()


no2.2018.daily.holiday %>% 
  ggplot(aes(holiday_school, daily_no2, group = factor(holiday_school), fill = factor(holiday_school))) +
  geom_boxplot(width=0.5, outlier.shape=NA) +
  geom_hline(aes(yintercept= 40), lwd = 1, color="black", linetype="dashed", alpha = .3) +
  facet_wrap(~ Location + SiteID, scales = "free") +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=15)) -> no2.2018.holiday.gg

ggsave("no2_box_holiday.png", no2.2018.holiday.gg, width = 12, height = 10, dpi = 600)

no2.2018.daily.holiday %>% 
  ggplot(aes(holiday_bank, daily_no2, group = factor(holiday_bank), fill = factor(holiday_bank))) +
  geom_boxplot(width=0.5, outlier.shape=NA) +
  geom_hline(aes(yintercept= 40), lwd = 1, color="black", linetype="dashed", alpha = .3) +
  facet_wrap(~ Location + SiteID, scales = "free") +
  theme_tq() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 15),
        axis.text.y = element_text(size = 20),
        axis.title.y = element_text(size = 20),
        strip.text = element_text(size=15)) -> no2.2018.bank.gg

ggsave("no2_box_bank.png", no2.2018.bank.gg, width = 12, height = 10, dpi = 600)


no2.2018.daily.holiday %>% as.data.frame() %>% 
  select(Date, weekend, daily_no2) %>%
  group_by(Date, weekend) %>% 
  summarise(daily = mean(daily_no2)) %>% 
  reshape2::dcast(Date ~ weekend, value.var = "daily") -> test


t.test(test$`FALSE`, test$`TRUE`)



