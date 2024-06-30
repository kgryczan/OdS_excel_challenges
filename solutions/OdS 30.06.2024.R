library(tidyverse)

input = tibble(
  ID = c("M-0356", "M-0815", "M-0994", "M-1113", "M-1521",
         "M-1709", "M-1871", "M-2363", "M-2886", "M-3079",
         "M-3992", "M-4215", "M-4410"),
  Employee = c("Nolan Harris", "Norton, Kyla", "Dee J. Farley",
               "Kahue, Sam", "Lewis Gardner", "Perry, L'Arron", 
               "Cedric Martin", "Kingwood, Juanita", "Barrera, Albertina",
               "Lovey G. Montoya", "Elberto Lang", "James Penn", "Nicolazzo, Thiago")
)

extract_surname = function(x) {
  if (str_detect(x, ",")) {
    return(str_extract(x, "\\w+"))
  } else if (str_detect(x, "\\.")) {
    return(str_extract(x, "\\w+$"))
  } else {
    return(str_extract_all(x, "\\w+")[[1]][length(str_extract_all(x, "\\w+")[[1]])])
  }
}

result = input %>% 
  mutate(Surname = map_chr(Employee, extract_surname)) %>%
  arrange(Surname) %>%
  select(-Surname)

result
