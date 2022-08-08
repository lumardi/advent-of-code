# Advent of Code - 2021


#### Day 8: Seven Segment Search ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: In the output values, how many times do digits 1, 4, 7, or 8 appear?


remDr$navigate("https://adventofcode.com/2021/day/8/input") 



raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\n$","",.) %>%
  str_split(pattern = "\n") %>%
  unlist() %>%
  enframe(name=NULL) %>%
  separate(value, c(paste0("left_",1:10),"aux",paste0("right_",1:4)),sep = " |\\| ",extra = "merge",fill = "right")

dat <- raw %>%
  select(contains("r")) %>%
  pivot_longer(cols = everything(),names_to = "name",values_to = "value") %>%
  filter(stringr::str_length(value) %in% c(2,3,4,7)) %>%
  nrow()


## Part 2 ##

# Question: What do you get if you add up all of the output values?

dat <- raw %>%
  select(-aux) %>%
  mutate(id = 1:n()) %>%
  nest(.in = contains("r")) %>%
  mutate(.out = map_dbl())






# End of File