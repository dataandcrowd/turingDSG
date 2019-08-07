library(tidyverse)
library(lubridate)
Sys.setlocale("LC_ALL","English")

# hard-coded school holidays
school_year <- ymd('2018-08-01') + days(0:364)

term1 <- interval(
  start = dmy('3 September 2018'),
  end = dmy('26 October 2018'))
term2 <- interval(
  start = dmy('5 November 2018'),
  end = dmy('21 December 2018'))
term3 <- interval(
  start = dmy('7 January 2019'),
  end = dmy('15 February 2019'))
term4 <- interval(
  start = dmy('25 February 2019'),
  end = dmy('5 April 2019'))
term5 <- interval(
  start = dmy('23 April 2019'),
  end = dmy('24 May 2019'))
term6 <- interval(
  start = dmy('3 June 2019'),
  end = dmy('23 July 2019'))
school_terms <- c(term1, term2, term3, term4, term5, term6)

bank_holidays <- c(
  'August 27 2018',
  'December 25 2018',
  'December 26 2018',
  'January 1 2019',
  'April 19 2019',
  'April 22 2019',
  'May 6 2019',
  'May 27 2019') %>%
  mdy()

# combine
holiday <- tibble(
  date = school_year,
  day_of_week = wday(date, label = TRUE),
  weekend = case_when(day_of_week %in% c('Sat', 'Sun') ~ TRUE, TRUE ~ FALSE),
  holiday_school = !map_lgl(.x = date, .f = ~ any(.x %within% school_terms)),
  holiday_bank = date %in% bank_holidays
)

holiday %>% summary()
