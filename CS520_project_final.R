install.packages("readxl")
library("readxl")
getwd()
setwd("G:/R Advanced/r-analytics/Coding")


loandata <- read_excel("LoanData.xlsx")

nodup <- loandata[!duplicated(loandata$id),]

install.packages("stringr")
library("stringr")

str_replace(nodup$verification_status, "verified", "Verified")
str_replace(nodup$verification_status, "not verified", "Not Verified")
str_replace(nodup$verification_status, "source verified", "Source Verified")

nodup1 <- nodup


install.packages(("lubridate"))
library(lubridate)


nodup1$issue_d = format(as.Date(nodup1$issue_d), "%d-%b-%Y")
nodup1$issue_d = substr(as.character(nodup1$issue_d), 4,11)
tail(nodup1$issue_d, n =50)



nodup1$earliest_cr_line = format(as.Date(nodup1$earliest_cr_line), "%d-%b-%Y")
nodup1$earliest_cr_line = substr(as.character(nodup1$earliest_cr_line), 4,11)
tail(nodup1$earliest_cr_line, n =50)

nodup1$last_pymnt_d = format(as.Date(nodup1$last_pymnt_d), "%d-%b-%Y")
nodup1$last_pymnt_d = substr(as.character(nodup1$last_pymnt_d), 4,11)
tail(nodup1$last_pymnt_d, n =50)


nodup1$next_pymnt_d = format(as.Date(nodup1$next_pymnt_d), "%d-%b-%Y")
nodup1$next_pymnt_d = substr(as.character(nodup1$next_pymnt_d), 4,11)
tail(nodup1$next_pymnt_d, n =50)


nodup1$last_credit_pull_d = format(as.Date(nodup1$last_credit_pull_d), "%d-%b-%Y")
nodup1$last_credit_pull_d = substr(as.character(nodup1$last_credit_pull_d), 4,11)
tail(nodup1$last_credit_pull_d, n =50)



empty_title <- which(is.na(nodup1$emp_title))
nodup1$emp_title[empty_title] <- "NA"
head(nodup1$emp_title)

head(zip_city)
?read.xlsx

zip_city <- read_excel("postal_codes.xlsx")
head(zip_city)



zip_city$Zip.Code <- substr(zip_city$Zip.Code, 1,3)
zip_city$Zip.Code <- str_pad(zip_city$Zip.Code , width =5, side = "right", pad = "x")
colnames(zip_city) <- c("Zip"  ,         "Place.Name"      ,   "State"        ,      "State.Abbreviation"
                        ,"County"       ,      "Latitude"     ,      "Longitude", "","zip_code")
names(zip_city)

install.packages("dplyr")
library(dplyr)

zip_city_unique <- zip_city[!duplicated(zip_city$zip_code),c(2,9)]
nrow(zip_city_unique)
joined_data <- left_join(nodup1, zip_city_unique, by = c("zip_code"))
tail(joined_data$Place.Name, n = 65)



install.packages("csv")
library("csv")

write.csv(joined_data, "F:/CS520/Cleaned_LoanData.csv")


memory.limit()
memory.limit(size=20000)

