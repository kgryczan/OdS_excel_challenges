library(tidyverse)

data <- tribble(
  ~Name, ~`Time (Hours)`, ~Rating,
  "Rokesh", 15, "★★★",
  "Ansel", 4, "★★",
  "Ansel", 9, "★",
  "Lovina", 6, "★★★",
  "Rokesh", 5.5, "★★★",
  "Osei", 9, "★★★★",
  "Kate", 4, "★★★★",
  "Kate", 18.5, "★★★",
  "Kate", 3, "★★★",
  "Rokesh", 5.5, "★★★",
  "Ansel", 3, "★",
  "Osei", 4, "★★★★",
  "Ansel", 16, "★★★★",
  "Kate", 5.5, "★★★★",
  "Kate", 4, "★",
  "Ansel", 7.5, "★★★★",
  "Lovina", 21, "★★★",
  "Ansel", 10, "★★"
)

output1 = data %>%
  pivot_wider(names_from = "Rating", values_from = "Time (Hours)",
              values_fn = sum, values_fill = list(`Time (Hours)` = 0)) %>%
  select(Name, sort(names(.)[2:5]))

# get name of person with max in 4 stars
output2 = data %>%
  group_by(Name) %>%
  summarise(`4 stars` = sum(`Time (Hours)`[Rating == "★★★★"])) %>%
  filter(`4 stars` == max(`4 stars`)) %>%
  select(Name) %>%
  pull()
# Ansel

# get name of person with hours only in 4 stars
output3 = data %>%
  group_by(Name) %>%
  mutate(`4 stars` = sum(`Time (Hours)`[Rating == "★★★★"])) %>%
  filter(`4 stars` == sum(`Time (Hours)`)) %>%
  select(Name) %>%
  distinct() %>%
  pull()
# Osei
