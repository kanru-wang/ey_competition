library(readxl)
library(magrittr)
library(tidyverse)
library(readr)

train_manual <- read_csv("E:/bitbucket_warehouse/side_projects/ey_competition/dataset/manual_handle/train_manual.csv")
test_manual <- read_csv("E:/bitbucket_warehouse/side_projects/ey_competition/dataset/manual_handle/test_manual.csv")


train <- read_csv("E:/bitbucket_warehouse/side_projects/ey_competition/dataset/train.csv")
test <- read_csv("E:/bitbucket_warehouse/side_projects/ey_competition/dataset/test.csv")

train_new = merge(x = train, y = train_manual, 
                  by = c("LOCATION","TIME"), all.x = TRUE)
test_new = merge(x = test, y = test_manual, 
                  by = c("LOCATION","TIME"), all.x = TRUE)

write.csv(train_new, file = "train.csv", na = "", row.names=FALSE)
write.csv(test_new, file = "test.csv", na = "", row.names=FALSE)
