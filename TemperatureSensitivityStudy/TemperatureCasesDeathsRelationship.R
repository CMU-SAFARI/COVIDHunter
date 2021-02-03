data <- read.csv("COVID19SwitzerlandDataset.csv",header = FALSE) #upload the dataset for COVID-19 data in Switzerland from 4.3.2020 until 8.12.2020
colnames(data) <- c("Cases","SmoothCases","Temp","Deaths","SmoothDeaths","Index") #add headers for the columns
head(data) 
install.packages( "ggplot2") #download ggplot2 package
library(ggplot2)
library(nlme)
library(mgcv)  
#GAM for evaluating the relationship between the temperature data and the number of daily confirmed COVID-19 cases     
model <- gam(Cases ~ Temp, data=data, method="REML")  
summary(model)
#plot the results
ggplot(data, aes(y=Cases,x=Temp)) + geom_smooth(method = "gam", formula = y ~ x) +  labs(y="COVID-19 confirmed daily cases", x="Temperature °C") + theme_bw() + theme(text = element_text(size=16))

#GAM for evaluating the relationship between the temperature data and the number of daily confirmed COVID-19 cases
model <- gam(Deaths ~ Temp, data=data, method="REML") 
summary(model)
#plot the results
ggplot(data, aes(y=Deaths,x=Temp)) + geom_smooth(method = "gam", formula = y ~ x) +  labs(y="COVID-19 confirmed daily deaths", x="Temperature °C") + theme_bw() + theme(text = element_text(size=16))