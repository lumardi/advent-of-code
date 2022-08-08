# Advent of Code - 2021


#### Day 6: Lanternfish ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: How many lanternfish would there be after 80 days?


remDr$navigate("https://adventofcode.com/2021/day/6/input") 


raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("[^0-9,]","",.) %>%
  str_split(pattern = ",") %>%
  as_vector() %>%
  as.numeric()
  
days <- 80

fish.timer <- raw

for(i in 1:days){
  fish.timer = fish.timer - 1 
  
  new.fish = sum(fish.timer == -1)
  
  fish.timer = ifelse(fish.timer == -1, 6, fish.timer)
  
  fish.timer = c(fish.timer, rep(8, new.fish))
  
}

fish <- length(fish.timer)


## Part 2 ##


# Question: How many lanternfish would there be after 256 days?

  
days <- 256

fish.timer <- raw

for(i in 1:days){
  fish.timer = fish.timer - 1 
  
  new.fish = sum(fish.timer == -1)
  
  fish.timer = ifelse(fish.timer == -1, 6, fish.timer)
  
  fish.timer = c(fish.timer, rep(8, new.fish))
  
}

fish <- length(fish.timer)










