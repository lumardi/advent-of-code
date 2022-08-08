# Advent of Code - 2021


#### Day 7: The Treachery of Whales ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: How much fuel must they spend to align to that position?


remDr$navigate("https://adventofcode.com/2021/day/7/input") 

raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("[^0-9,]","",.) %>%
  str_split(pattern = ",") %>%
  as_vector() %>%
  as.numeric()


dat = 1e64 # random large number 

for(i in max(raw):min(raw)){
  
  aux = sum(abs(raw - i))
  
  if(aux < dat){
    dat = aux
  }
}



## Part 2 ##

# Question: As it turns out, crab submarine engines don't burn fuel at a constant rate. How much fuel must they spend to align to that position?



dat = 1e64 # random large number 

for(i in max(raw):min(raw)){
  
  aux = raw %>%
    map_int(., ~{
      sum(0:abs(.x - i))
    }) %>%
    sum()
  
  if(aux < dat){
    dat = aux
  }
}


# End of File