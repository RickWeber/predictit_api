#!/usr/bin/R
library(tidyverse)
library(jsonlite)

url <- 'https://www.predictit.org/api/marketdata/all'

pull <- function(){
  fromJSON(url)
}

process <- function(){
  pull()$markets %>%
    unnest %>%
    select(contains("id"),status:status1,name,name1) %>%
    mutate(timeStamp = parse_datetime(timeStamp))
}

repeat_pi <- function(n = 60){
  df <- process()
  filename <- paste("~/Downloads/PI_data_",
                    Sys.time(),
                    "_n_",n,
                    ".csv",
                    sep = "")
  if(n <= 1){
    write_csv(df,filename)
    break
  } else {
    n <- n - 1
  }
  for(i in 1:n){
    Sys.sleep(60)
    df <- df %>%
      full_join(process())
  }
  write_csv(df,filename)
}

repeat_pi(60)
