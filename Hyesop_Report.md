# Approach X: Exploring the structrue of air quality data for Bristol
## 1. Background
- There are ample evidence of inverse relationships between NO<sub>x</sub> and children's risk of health e.g. exposure, asthma, headache, and mental health.
    - [Roosbroeck et al.(2007)](https://www.sciencedirect.com/science/article/pii/S1352231006012878) measured personal exposure to traffic-related air pollution in Utercht, the Netherlands. From 54 young participants, the personal exposure to NO<sub>x</sub> was 37% lower on near-road schoolers compared to background schoolers.
    - [Kim et al. (2004)](https://www.atsjournals.org/doi/full/10.1164/rccm.200403-281OC) conducted 10 school-based surveys from students who walk to school to compare NOx exposure levels based on their residential location in San Fransisco, USA. Using a logistic model, children who lived within 300m to major roads and at a downwinded location have higher exposure levels(OR: 1.05±0.1) compared to those who live far and upwind of major roads.
    - [Robert et al. (2019)](https://www.sciencedirect.com/science/article/pii/S016517811830800X) analysed a longitudinal cohort study of London-based teenagers and discovered that the 18-year olds who have had depression was associated with high pollution exposure when they were 12 years old (Age-12 pollution exposure was not associated with age-12 mental health problems).  

- Schoolzones in Bristol are still facing a serious risk of pollution due to a high volume of vehicles on during drop-off and pick-up times, which can badly affect their health. According to [Bristol local news](https://www.bristolpost.co.uk/news/bristol-news/roads-outside-schools-could-closed-3001742), the city council are considering to close roads outside schools. 

- However, we argue that the proposed plans can only take into further consideration with the rigorous exploration of pollutants and related components.

- Here, this section firsly explores the general features of pollutants (NO<sub>x</sub>) and weather determinants, then examines a schoolzone as a case study.


## 2. Data collection
### 2.1. Pollution

- Bristol city council has released a diverse range of dataset on their [Bristol Opendata Portal](https://opendata.bristol.gov.uk/pages/homepage/). Amongst the data, we collected [live and historic air quality continous data (1998-2019)](https://opendata.bristol.gov.uk/explore/dataset/air-quality-data-continuous/information/?disjunctive.location) from 16 monitoring stations.

[Table 1. General information of pollution monitoring sites in Bristol. The seven stations (with bolded text) are the  currently measuring pollution data]
| Location                             | Long     | Lat      | Date_Start | Date_End   |
|--------------------------------------|----------|----------|------------|------------|
| AQ Mesh Temple Way                   | -2.56208 | 51.47528 | 2019-01-01 | 2019-04-23 |
| **AURN St Pauls**                    | -2.55996 | 51.44175 | 2006-06-15 | 2019-08-05 |
| Bath Road                            | -2.60496 | 51.43267 | 2005-10-29 | 2013-01-04 |
| **Brislington Depot**                | -2.59626 | 51.45543 | 2001-01-01 | 2019-08-05 |
| Cheltenham Road \ Station Road       | -2.58448 | 51.44888 | 2008-06-25 | 2011-01-01 |
| **Colston Avenue**                   | -2.56374 | 51.42786 | 2018-03-11 | 2019-08-05 |
| **Fishponds Road* **                 | -2.68878 | 51.48999 | 2009-03-13 | 2019-08-05 |
| IKEA M32                             | -2.56272 | 51.45779 | 1998-01-10 | 2000-12-06 |
| Newfoundland Road Police Station     | -2.58225 | 51.46067 | 2005-01-01 | 2015-12-31 |
| **Parson Street School**             | -2.57138 | 51.44254 | 2002-01-02 | 2019-08-05 |
| Rupert Street                        | -2.58454 | 51.46283 | 2003-01-01 | 2015-12-31 |
| Shiner's Garage                      | -2.59273 | 51.46894 | 2004-06-24 | 2013-01-04 |
| Temple Meads Station                 | -2.53523 | 51.47804 | 2003-02-01 | 2003-10-27 |
| **Temple Way**                       | -2.58399 | 51.45795 | 2017-04-01 | 2019-08-05 |
| Trailer Portway P&R                  | -2.59665 | 51.45527 | 2004-03-01 | 2009-03-01 |
| **Wells Road A37 Airport Road Junction** | -2.58399 | 51.45795 | 2003-05-23 | 2019-08-05 |


- We can observe the start and end date from all stations
- 7 Stations (location with bold text) are currently monitored 
    - AURN St Pauls
    - Brislington Depot 
    - Colston Avenue
    - Fishponds Road
    - Parson Street School
    - Temple Way
    - Wells Road

- 9 Stations (lowest: 3 months, longest: 12 years)
    - IKEA M32: 1998-01-10 - 2000-12-06, approx. 3 years
    - AQ Mesh Temple Way: 2019-01-01 - 2019-04-23, approx. 3 months
    - Bath Road: 2005-10-29 - 2013-01-04, approx 7 years
    - Cheltenham Road\Station Road: 2008-06-25 - 2011-01-01, approx 2.5 years
    - Newfoundland Road Police Station: 2005-01-01 - 2015-12-31, 10 years
    - Rupert Street: 2003-01-01 - 2015-12-31, approx 12 years
    - Shiner's Garage: 2004-06-24 - 2013-01-04, approx 8.5 years
    - Temple Meads Station: 2003-02-01 - 2003-10-27, approx 9 months
    - Trailer Portway P&R: 2004-03-01 - 2009-03-01, approx 5 years



### 2. Meteorological Data



### 3. Case study: Parson street

