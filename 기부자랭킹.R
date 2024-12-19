# 기부자 상위 10명 추출
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
write.csv(df,"기부자통계데이터16~20_all.csv")
# 
setwd("C:/Users/daybi/Documents/Titano/competi/OpendataHackathon(211105)")
#
cntrbtr <- df[,c(1,4,5,7,8,9)]
names(cntrbtr) <- c("날짜","지원센터코드","기부자구분코드","기부자명","기부금액","기부건수")

# 개인 기부자만
cntrbtr_03 <- subset(cntrbtr,기부자구분코드 == '03')
cntrbtr_03 <- cntrbtr_03[,-3]

# 년도별 기부 횟수왕 10명
cntrbtr_16 <- cntrbtr_03[grep("2016",cntrbtr_03$날짜),]
cntrbtr_16 <- arrange(cntrbtr_16,desc(cntrbtr_16$기부건수))
cntrbtr_16 <- cntrbtr_16[c(1:10),]

cntrbtr_17 <- cntrbtr_03[grep("2017",cntrbtr_03$날짜),]
cntrbtr_17 <- arrange(cntrbtr_17,desc(cntrbtr_17$기부건수))
cntrbtr_17 <- cntrbtr_17[c(1:10),]

cntrbtr_18 <- cntrbtr_03[grep("2018",cntrbtr_03$날짜),]
cntrbtr_18 <- arrange(cntrbtr_18,desc(cntrbtr_18$기부건수))
cntrbtr_18 <- cntrbtr_18[c(1:10),]

cntrbtr_19 <- cntrbtr_03[grep("2019",cntrbtr_03$날짜),]
cntrbtr_19 <- arrange(cntrbtr_19,desc(cntrbtr_19$기부건수))
cntrbtr_19 <- cntrbtr_19[c(1:10),]

cntrbtr_20 <- cntrbtr_03[grep("2020",cntrbtr_03$날짜),]
cntrbtr_20 <- arrange(cntrbtr_20,desc(cntrbtr_20$기부건수))
cntrbtr_20 <- cntrbtr_20[c(1:10),]

cntrbtrking <- cntrbtr_16 %>% 
  full_join(cntrbtr_17) %>% 
  full_join(cntrbtr_18) %>% 
  full_join(cntrbtr_19) %>% 
  full_join(cntrbtr_20) # 전체 합치기이이ㅣ

cntrbtrking <- cntrbtrking[,-4]
centerCd <- read.csv("센터코드.csv")
cntrbtrking <- merge(cntrbtrking,centerCd, by = "지원센터코드")

write.csv(cntrbtrking,"개인기부자상위10명.csv")
#
# 개인 기부자만
cntrbtr_03 <- subset(cntrbtr,기부자구분코드 == '03')
cntrbtr_03 <- cntrbtr_03[,-3]

# 년도별 기부 횟수왕 10명
cntrbtr_16 <- cntrbtr_03[grep("2016",cntrbtr_03$날짜),]
cntrbtr_16 <- arrange(cntrbtr_16,desc(cntrbtr_16$기부금액))
cntrbtr_16 <- cntrbtr_16[c(1:10),]

cntrbtr_17 <- cntrbtr_03[grep("2017",cntrbtr_03$날짜),]
cntrbtr_17 <- arrange(cntrbtr_17,desc(cntrbtr_17$기부금액))
cntrbtr_17 <- cntrbtr_17[c(1:10),]

cntrbtr_18 <- cntrbtr_03[grep("2018",cntrbtr_03$날짜),]
cntrbtr_18 <- arrange(cntrbtr_18,desc(cntrbtr_18$기부금액))
cntrbtr_18 <- cntrbtr_18[c(1:10),]

cntrbtr_19 <- cntrbtr_03[grep("2019",cntrbtr_03$날짜),]
cntrbtr_19 <- arrange(cntrbtr_19,desc(cntrbtr_19$기부금액))
cntrbtr_19 <- cntrbtr_19[c(1:10),]

cntrbtr_20 <- cntrbtr_03[grep("2020",cntrbtr_03$날짜),]
cntrbtr_20 <- arrange(cntrbtr_20,desc(cntrbtr_20$기부금액))
cntrbtr_20 <- cntrbtr_20[c(1:10),]

cntrbtrking <- cntrbtr_16 %>% 
  full_join(cntrbtr_17) %>% 
  full_join(cntrbtr_18) %>% 
  full_join(cntrbtr_19) %>% 
  full_join(cntrbtr_20) # 전체 합치기이이ㅣ

cntrbtrking <- cntrbtrking[,-5]
cntrbtrking <- merge(cntrbtrking,centerCd, by = "지원센터코드")


write.csv(cntrbtrking,"개인기부자상위10명(금액).csv")
