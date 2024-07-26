library(tidyverse)
library(tidyxl)
library(openxlsx)

path = "files/OdS 26.07.2024.xlsx"

metadata = xlsx_cells(path)

data = readWorkbook(path)

coloured_cells = metadata %>%
  filter(local_format_id > 1, col == 2) %>% 
  select(character, row, col)

data1 = data %>%
  mutate(rn = row_number() + 1) %>%
  left_join(coloured_cells, by = c("rn" = "row")) %>%
  rename("AwayTeam" = character) %>%
  separate(Final.Score, into = c("HomeScore", "AwayScore"), sep = "-") %>%
  filter(!is.na(AwayTeam)) %>%
  mutate(HomeScore = as.numeric(HomeScore),
         AwayScore = as.numeric(AwayScore),
         HomeWin = HomeScore > AwayScore,
         AwayWin = HomeScore < AwayScore) %>%
  summarise(HomeWins = sum(HomeWin, na.rm = TRUE),
            AwayWins = sum(AwayWin, na.rm = TRUE))

print(data1)
# HomeWins AwayWins
#       3        5