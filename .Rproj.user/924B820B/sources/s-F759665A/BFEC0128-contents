rm(list = ls())
library(tidyverse)
library(jsonlite)

url = 'https://www.predictit.org/api/marketdata/all'

download.file()

API_call <- function(){
  download.file(url,'PI.json')
  data <- fromJSON("PI.json",simplifyDataFrame = TRUE) %>% tibble()
  data <- data$'.'$markets
  tibble(data)
}

data <- API_call()
data$contracts