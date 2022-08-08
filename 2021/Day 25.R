# Advent of Code - 2021


#### Day 25: Seven Segment Search ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: What is the first step on which no sea cucumbers move?


remDr$navigate("https://adventofcode.com/2021/day/25/input") 


raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\n$","",.) %>%
  strsplit("\n") %>%
  unlist() %>%
  enframe(name=NULL) %>%
  separate(value, c("aux",paste0("col",1:139)),sep = "",extra = "merge",fill="right") %>%
  select(-aux)
  

a = "...>>>>.>.." %>%
  strsplit("") %>%
  enframe()
  rbind()

  e <- which(raw == ">")

## Part 2 ## 


# Question



# End of File 

