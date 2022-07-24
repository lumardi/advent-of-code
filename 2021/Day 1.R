# Advent of Code - 2021

#### Day 1: Sonar Sweep ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: How many measurements are larger than the previous measurement?


# Scraping Data
remDr$navigate("https://adventofcode.com/2021/day/1/input")


# Scraping & some data cleaning
raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\\\n$","",.) %>%
  str_split(pattern = "\n") %>%
  unlist() %>%
  enframe(name= NULL) %>%
  mutate(value = as.numeric(value))

# Answer
dat <- raw %>%
  mutate(inc = as.numeric(value > lag(value))) %>%
  .$inc %>%
  sum(na.rm = T) 




## Part 2 ##

# Question: How many sums are larger than the previous sum?

raw %>%
  zoo::rollapply(., 3, sum) %>%
  as.data.frame() %>%
  mutate(inc = as.numeric(value > lag(value))) %>%
  .$inc %>%
  sum(na.rm = T) 


# End of File