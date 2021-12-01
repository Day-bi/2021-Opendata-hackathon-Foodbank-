setwd("C:/Users/daybi/Documents/Titano/competi/OpendataHackathon(211105)")
library(readxl)
library(plyr)
library(ggmap)
library(XML)
library(rgdal)
library(ggplot2)
library(gridExtra)
library(ggsci)
library(scales)
library(tidyverse)
#기부자
api_key <- "n3ShZ50BH%2B3BPRnQ0wD0PnX5YxJEoWTOXt7N3GzQN2fkAPCjMLTpo%2FqxHfIW%2FWI344oDzIiTaQJ5ratuQfJOGQ%3D%3D"

temp <- merge(c(2016:2020),c(1:12))
temp$y <- if_else(temp$y <10, paste0(0,temp$y),as.character(temp$y))
deal_ymd <- paste0(temp$x, temp$y) %>% as.integer()
df <- NULL

for (i in deal_ymd){
  url <- paste0('http://apis.data.go.kr/B460014/foodBankInfoService2/getCntrbtrInfo?serviceKey=',api_key,'&stdrYm=',i,'&numOfRows=10000&pageNo=1')
  raw.data <- xmlTreeParse(url, useInternalNodes = T)
  xml_rootnode <- try(xmlRoot(raw.data))
  xml_result <- xmlToDataFrame(xml_rootnode[[2]][['items']])
  df <- rbind(df,xml_result)
}

df2 <- df[,c(1,5,9,10)]
write.csv(df2,"기부자통계데이터(16~20년).csv")
done <- read.csv("기부자통계데이터(16~20년).csv")

# 이제 기부자는,, csv로 부르자

# 이용자
api_key <- "n3ShZ50BH%2B3BPRnQ0wD0PnX5YxJEoWTOXt7N3GzQN2fkAPCjMLTpo%2FqxHfIW%2FWI344oDzIiTaQJ5ratuQfJOGQ%3D%3D"

temp <- merge(c(2016:2020),c(1:12))
temp$y <- if_else(temp$y <10, paste0(0,temp$y),as.character(temp$y))
deal_ymd <- paste0(temp$x, temp$y) %>% as.integer()
df <- NULL

for (i in deal_ymd){
  url <- paste0('http://apis.data.go.kr/B460014/foodBankInfoService2/getUserInfo?serviceKey=',api_key,'&stdrYm=',i,'&numOfRows=10000&pageNo=1')
  raw.data <- xmlTreeParse(url, useInternalNodes = T)
  xml_rootnode <- try(xmlRoot(raw.data))
  xml_result <- xmlToDataFrame(xml_rootnode[[2]][['items']])
  df <- rbind(df,xml_result)
}

df_user <- df[,c(1,5,6,7,9,10)]
write.csv(df, "이용자통계데이터(16~20raw).csv")
