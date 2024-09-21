library(tidyverse)
library(readxl)

path = "files/OdS 07092024.xlsx"
input1 = read_excel(path, range = "A1:B9")
input2 = read_excel(path, range = "G2:I8", col_names = FALSE) %>% as.matrix()

result1 = input1 %>%
  separate_rows(`Color Choices`, sep = "; ") %>%
  select(`Color Choices`) %>%
  distinct() %>%
  pull()

result2 = input2 %>%
  as.vector() %>%
  na.omit()

final = setdiff(result2, result1)
final
# [1] "Teal"           "Mustard Yellow" "Bronze"         "Pea Green"      "Goldenrod"