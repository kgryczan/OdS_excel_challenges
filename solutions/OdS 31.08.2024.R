library(tidyverse)
library(readxl)

path = "files/OdS 31.08.2024.xlsx"
input = read_excel(path, range = "A1:C16")

rev = input %>%
  mutate(total_no_shipp = `Total (incl. Shipping)` - `Shipping`) %>%
  summarise(total_no_shipp = sum(total_no_shipp)) %>%
  pull()

rev_share = input %>%
  mutate(total_no_shipp = `Total (incl. Shipping)` - `Shipping`) %>%
  mutate(share = case_when(
    `Product Line` %in% c("L", "RA") ~ total_no_shipp * 0.8,
    `Product Line` == "C" ~ 25,
    TRUE ~ total_no_shipp
  )) %>%
  summarise(share = sum(share)) %>%
  pull()

print(rev)
# [1] 3002.37
print(rev_share)
# [1] 2583.608