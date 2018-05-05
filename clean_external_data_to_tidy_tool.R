library(readxl)
library(magrittr)
library(tidyverse)
library(readr)

# This tool assume data is retrived from this URL:
# http://databank.worldbank.org/data/reports.aspx?source=2&country=AUS,USA,AUT,BEL,CAN,CHE,CHL,COL,CZE,DEU,DNK,ESP,EST,FIN,FRA,GBR,GRC,HUN,IRL,ISL,ISR,ITA,JPN,KOR,LUX,LVA,MEX,NLD,NOR,NZL,POL,PRT,SVK,SVN,SWE,TUR,ZAF
# Download wanted data using "Advanced Option", "Both codes and names", blanc for na; then
# Download wanted data using "Advanced Option", "Only names", blanc for na.
# Copy the country code in the first file to the second one. 

data <- read_excel("C:/Users/Kevin/Desktop/Data_Extract_From_World_Development_Indicators (1).xlsx")

to_be_gathered = colnames(data)
to_be_gathered
to_be_gathered = to_be_gathered[3:length(to_be_gathered)]

new = data %>% 
  gather(to_be_gathered, key = "year", value = "cases") %>% 
  spread(key = "Series Name", value = "cases")

#new_combined = rbind(new, new) %>% 
#  .[order(.$`Country Code`, .$year),]

test_country_code = c('CHE','FRA','USA','GRC','MEX','NOR','NZL')

test_data_additional <- new[new$`Country Code` %in% test_country_code,]
train_data_additional <- new[!new$`Country Code` %in% test_country_code,]

colnames(test_data_additional)[1:2]
colnames(test_data_additional)[1:2] = c("LOCATION","TIME")
colnames(train_data_additional)[1:2]
colnames(train_data_additional)[1:2] = c("LOCATION","TIME")

train <- read_csv("E:/bitbucket_warehouse/side_projects/ey_competition/dataset/train.csv")
test <- read_csv("E:/bitbucket_warehouse/side_projects/ey_competition/dataset/test.csv")

train_new = merge(x = train, y = train_data_additional, 
                  by = c("LOCATION","TIME"), all.x = TRUE)
test_new = merge(x = test, y = test_data_additional, 
                  by = c("LOCATION","TIME"), all.x = TRUE)

write.csv(train_new, file = "train.csv", na = "", row.names=FALSE)
write.csv(test_new, file = "test.csv", na = "", row.names=FALSE)
