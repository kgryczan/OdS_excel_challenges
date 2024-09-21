library(tidyverse)
library(readxl)

path = "files/OdS 21092024.xlsx"
input = read_excel(path, range = "A1:B13")

test = 1393.03
hour_pay = 31.75
standard_time = 40
ovrtime_rate = 1.5

result = input %>%
  mutate(overpay = ifelse(Hours > standard_time, (Hours - standard_time) * ovrtime_rate * hour_pay, 0)) %>%
  summarise(total_overpay = round(sum(overpay),2)) %>%
  pull()

result == test
# [1] TRUE