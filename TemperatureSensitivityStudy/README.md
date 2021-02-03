To evaluate the relationship between the temperature data and the number of daily confirmed COVID-19 cases or the daily counts of death, we use a generalized additive model (GAM). GAM is usually used to calculate the linear and non-linear regression models between meteorological factors (e.g.temperature, humidity) with COVID-19 infection and transmission.
The analyses are performed with _R software version 4.0.3._, where p-value<0.05 is considered statistically significant. 
Our model attempts to represent the linear behavior of the growth curve of the counts of the new confirmed cases or deaths in Switzerland. Therefore, a hypothesis rises whether there is a significantly negative correlation between the COVID-19 confirmed daily case or death counts and temperature. 
The result shows that for each 1°C rise in temperature, there is a 3.67% (t-value = −3.244 and p-value = 0.0013) decrease in the daily number of COVID-19 confirmed cases. The result also shows that a 23.8% decrease in the daily number of COVID-19 deaths would be influenced by a 1°C rise in temperature (t-value = −9.312 and p-value = 0.0)

# To run our model: 
**Step 1**: download _R software version 4.0.3._ ["https://www.r-project.org/"]. _R_ is a free software environment for statistical computing and graphics.
**Step 2**: in the R Consloe type: source("/directory of the file/TempCasesRelationship.R"), or 
you can run the code in "TempCasesRelationship.R" step by step by typing each command in the  R Consloe.


