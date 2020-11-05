rm(list = ls())
library(tidyverse)
library(jsonlite)

url = 'https://www.predictit.org/api/marketdata/all'
# download.file(url,'PI.json')
# data <- fromJSON("PI.json",simplifyDataFrame = TRUE) %>% tibble()
# data <- data$'.'$markets
# data <- tibble(data)
# 
# for(t in 1:480){
#   download.file(url,'PIt.json')
#   datat <- fromJSON("PIt.json",simplifyDataFrame = TRUE) %>% tibble()
#   datat <- datat$'.'$markets
#   datat <- tibble(datat)
#   data2 <- full_join(data,datat)
# head}
# 

data_list <- list()

API_call <- function(){
  download.file(url,'PI.json')
  data <- fromJSON("PI.json",simplifyDataFrame = TRUE) %>% tibble()
  data <- data$'.'$markets
  tibble(data)
}


for(t in 1:2){
  time_used <- system.time(data_list[[t]] <- API_call())
  sleep <- 60 - time_used
  Sys.sleep(sleep)
  # print(length(data_list))
}


for(t in 1:480){
  time_used <- system.time(data_list[[t]] <- API_call())
  sleep <- 60 - time_used
  Sys.sleep(sleep)
}
write_rds(data_list,"data.rds")

