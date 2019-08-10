# Exploring air quality data in Bristol - with a focus on schoolzone exposure
## 1. Background
- There are ample evidence of inverse relationships between NO<sub>x</sub> and children's risk of health e.g. exposure, asthma, headache, and mental health.
    - [Roosbroeck et al.(2007)](https://www.sciencedirect.com/science/article/pii/S1352231006012878) measured personal exposure to traffic-related air pollution in Utercht, the Netherlands. From 54 young participants, the personal exposure to NO<sub>x</sub> was 37% lower on near-road schoolers compared to background schoolers.
    - [Kim et al. (2004)](https://www.atsjournals.org/doi/full/10.1164/rccm.200403-281OC) conducted 10 school-based surveys from students who walk to school to compare NOx exposure levels based on their residential location in San Fransisco, USA. Using a logistic model, children who lived within 300m to major roads and at a downwinded location have higher exposure levels(OR: 1.05±0.1) compared to those who live far and upwind of major roads.
    - [Robert et al. (2019)](https://www.sciencedirect.com/science/article/pii/S016517811830800X) analysed a longitudinal cohort study of London-based teenagers and discovered that the 18-year olds who have had depression was associated with high pollution exposure when they were 12 years old (Age-12 pollution exposure was not associated with age-12 mental health problems).  

- Schoolzones in Bristol that have a high volume of traffic during drop-off and pick-up times are facing a serious risk of pollution exposure, and children whose schools are closer to the road will be more suceptible to these disease symptoms than the schools distant from road. 

- In line with the [Bristol clean air zone proposals](https://airqualitynews.com/2019/07/01/bristol-launch-clean-air-zone-consultation/), the city council is in consideration of closing roads outside schools ([Bristol local news](https://www.bristolpost.co.uk/news/bristol-news/roads-outside-schools-could-closed-3001742)). 

- However, we argue that the proposed plans can only take into further consideration once a critical exploration of pollution, weather, and traffic is done.

- Here, this study firsly explores the general features of pollutants (NO<sub>x</sub>) and weather determinants, then examines a schoolzone as a case study. Integrated work with traffic will be examined on our next study.


## 2. Data collection

This section introduces pollution and local weather data derived from the [Bristol Opendata Portal](https://opendata.bristol.gov.uk/pages/homepage/), which was achived and published by the city council. Amongst the data, we collected [live and historic air quality continous data (1998-2019)](https://opendata.bristol.gov.uk/explore/dataset/air-quality-data-continuous/information/?disjunctive.location) from 16 monitoring stations, and meteorological variables from the UK Met Office (==URL??? ask Lawrens==). 

### 2.1. Pollution

Bristol has been monitored nitro oxides (NO<sub>x</sub>, that include NO and NO<sub>2</sub>) from a single site since January 1998, and has expanded it to multiple stations around the city centre. This might be because the NO<sub>x</sub> level is time-variant, meaning that rush hour congestion can cause negative health outcomes in a long-term ([Zhang and Batterman, 2013](https://www.sciencedirect.com/science/article/pii/S0048969713001290?via%3Dihub)).

At present, the city has 7 Stations (location with bold text) that monitors NO<sub>x</sub>, NO<sub>2</sub>, NO, and PM<sub>10</sub> (see Figure 1 or `ctrl + ` [click](https://user-images.githubusercontent.com/25252172/62687341-82bf2300-b9be-11e9-9424-d0ad4e8aac92.png)). Each station has its own intention of monitoring: Colston avenue (detects wose case exposre in city centre), AURN St Pauls (detects background exposure in residential area), Brislington depot (Freight), Fishponds road (residential and shopping), Parson street school (residential area + school zone), Wells road (continous traffic in and out of city centre).
    

[Table 1. General information of pollution monitoring sites in Bristol. The seven stations (with bolded text) are the  currently measuring pollution data]
| Location                             | Long     | Lat      | Date_Start | Date_End   | Total period (for terminated stations) |
|:-------------------------------------|---------:|---------:|:-----------|:-----------|:------------------|
| AQ Mesh Temple Way                   | -2.56208 | 51.47528 | 2019-01-01 | 2019-04-23 | approx. 3 months  |
| **AURN St Pauls**                    | -2.55996 | 51.44175 | 2006-06-15 | 2019-08-05 |                   |
| Bath Road                            | -2.60496 | 51.43267 | 2005-10-29 | 2013-01-04 | approx. 7 years   |
| **Brislington Depot**                | -2.59626 | 51.45543 | 2001-01-01 | 2019-08-05 |                   |
| Cheltenham Road \ Station Road       | -2.58448 | 51.44888 | 2008-06-25 | 2011-01-01 | approx 2.5 years  |
| **Colston Avenue**                   | -2.56374 | 51.42786 | 2018-03-11 | 2019-08-05 |                   |
| **Fishponds Road**                   | -2.68878 | 51.48999 | 2009-03-13 | 2019-08-05 |                   |
| IKEA M32                             | -2.56272 | 51.45779 | 1998-01-10 | 2000-12-06 | approx 3 years |
| Newfoundland Road Police Station     | -2.58225 | 51.46067 | 2005-01-01 | 2015-12-31 | 10 years |
| **Parson Street School**             | -2.57138 | 51.44254 | 2002-01-02 | 2019-08-05 | |
| Rupert Street                        | -2.58454 | 51.46283 | 2003-01-01 | 2015-12-31 | approx. 12 years|
| Shiner's Garage                      | -2.59273 | 51.46894 | 2004-06-24 | 2013-01-04 | approx 8.5 years |
| Temple Meads Station                 | -2.53523 | 51.47804 | 2003-02-01 | 2003-10-27 | approx 9 months |
| **Temple Way**                       | -2.58399 | 51.45795 | 2017-04-01 | 2019-08-05 | |
| Trailer Portway P&R                  | -2.59665 | 51.45527 | 2004-03-01 | 2009-03-01 |approx 5 years |
| **Wells Road A37 Airport Road Junction** | -2.58399 | 51.45795 | 2003-05-23 | 2019-08-05 | |


[Figure 1. Location of Bristol air pollution monitoring sites] ![Figure 1](https://user-images.githubusercontent.com/25252172/62687341-82bf2300-b9be-11e9-9424-d0ad4e8aac92.png)


### 2. Meteorological Data
Comapred to the number of pollution sites, there is only one meteorological monitoring station in Bristol. The variables in clude temperature, precipitation, wind speed, wind direction, and so on.   


## 3. Method
- Explore temporal features of NO<sub>2</sub> across Bristol monitoring sites - overall and after 2019

- *Explore temporal features of meteorolgical factors - overall and after 2019 (if we have time)*
- Case study: air pollution at Parson street primary school


## 4. Result
### 4.1. Exploration of NO<sub>2</sub> in Bristol City 

#### Temporal
- In general, all stations (except AQ Mesh Temple way site,) have a daily and sesonal oscilation of NO<sub>2</sub>.
  - However, there was a variation by stations. In [Table 2], the averaged NO<sub>2</sub> was the highest on Rupert street (city centre) at 93.1µg/m<sup>3</sup>, followed by Colston Avenue and Temple Meads station at 65.7, 63.2 respectively.
  - Parson Street school which have been monitored since 2002 had an average of 47.7µg/m<sup>3</sup>, but the hourly concentration of NO2 had exceed the legal limit for 154,189 times. Although it had declined in the recent years, the exceedance counts are very much of a concern.

![](https://i.imgur.com/HT9iFoe.png)

[Table 2. Mean NO<sub>2</sub> and counts of exceedance of 200µg/m<sup>3</sup> by each station]
| Station Name        | Mean NO<sub>2</sub> | Number of Exceedance |
|:---------------------|----------:|------------:|
| Trailer Portway P&R  | 24.4     | 43,824      |
| Brislington Depot    | 26.3     | 162,971     |
| AURN St Pauls        | 28.3     | 115,139     |
| Cheltenham Rd        | 34.5     | 22,071      |
| Bath Road            | 38.7     | 62,990      |
| Temple Way           | 40.4     | 20,553      |
| Fishponds Road       | 41.1     | 90,945      |
| Shiner's Garage      | 42       | 74,787      |
| Wells Rd             | 44       | 142,001     |
| Parson Street School | 47.7     | 154,189     |
| Newfoundland Rd      | 54.4     | 96,407      |
| IKEA M32             | 61.2     | 25,464      |
| Temple Meads Station | 63.2     | 6,446       |
| Colston Avenue       | 65.7     | 12,284      |
| Rupert Street        | 93.1     | 113,951     |


#### Monthly aggreated boxplots by hours
  - Overall, the averaged NO<sub>2</sub> tends to soar  rapidly between 7am and 10am, which roughly peaks at twice the amount than the concentration at 5 am. It remains the concentration until 6pm, then gradually decreases late at night. 
  - For example, Parson street school has the lowest NO<sub>2</sub> concentration just above 20µg/m<sup>3</sup> at 4am, then rose up to 54µg/m<sup>3</sup> at 10am.
 

![](https://i.imgur.com/rJfwS6X.png)


#### Monthly aggregated boxplots by days of week after 2018
  - The boxplot used the the monthly average of NO<sub>2</sub> at 7 stations in 2018-2019.
  - Overall, the weekday concentration was higher than that of weekends. Amongst all stations, colston avenue (city centre) had the highest amount of NO<sub>2</sub> that ranged 50-70µg/m<sup>3</sup> during weekdays and falled 60
µg/m<sup>3</sup> on Saturdays, then decreased futher on Sundays at around 50µg/m<sup>3</sup>. Parson Street school just managed to go below the national NO<sub>2</sub> limit of 40µg/m<sup>3</sup> during weekdays.

![](https://i.imgur.com/2Xpq8RC.png)


* School Holiday
  - Overall, while there is a small difference in between holidays and non-holidays (5µg/m<sup>3</sup>), it has a distiction by locations.
  - Colston Avenue a consistantly high concentration of NO<sub>2</sub> above 50 regardless of holidays, but the concentration varied during holidays. The same happened to Temple Way.
  - During term time, children who were commuting to schools near Parson street primary school or passing Fishponds road might have experienced a high level of NO<sub>2</sub> since the concentration ranges up to 80µg/m<sup>3</sup>.

![](https://i.imgur.com/kZs0N5j.png)


![](https://i.imgur.com/QAIYJQ4.png)


## Exploring Meteorological Data 


![](https://i.imgur.com/FC2Gyg9.png)



### 3. Case study: Parson street School
![](https://i.imgur.com/4YjXk9e.png)

![](https://i.imgur.com/LpBptkY.png)




## Conclusion and Future Work

- This study firstly explored the temporal features of pollutants (NOx), then examined Parson Street School as a case study.
 
- Our initial finding was that most stations had a daily and seasonal oscillation of NO<sub>2</sub> throughout the whole period ranging from less than 20µg/m<sup>3</sup> to over 1000µg/m<sup>3</sup> based on hourly measurement. 
  - Looking in to an averaged hourly NO<sub>2</sub>, there was a clear trough around 20µg/m<sup>3</sup> at 3-5am but peaked at around 60µg/m<sup>3</sup> after 10am. 
  - However, the concentration was always higher in the city centre sites (Parson Street School, Rupert Street). Although the average NO<sub>2</sub> levels of Parson street schooler were just below the UK legal limit (40µg/m<sup>3</sup>), the children might have consistently encountered instantaneous NO<sub>2</sub> exposure during drop-off and pick up times.

* Our second finding was that the NO<sub>2</sub> concentration between holidays and non-holidays (school holidays and bank holidays 2018-2019) was on average less than 5µg/m<sup>3</sup>, however varied by locations.

- In our case study, Parson street school



- Limitation and future work
    - This study attempted to relate NO<sub>2</sub> to holidays to speculate the effect traffic levels, however failed to find the association due to the lack of data and time. Future work should therefore consider to link vehicle data to understand the relationship between Bristol's vehicle flow and air pollution and how it affects school students.

