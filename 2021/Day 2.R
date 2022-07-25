# Advent of Code - 2021


#### Day 2: Dive! ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: What do you get if you multiply your final horizontal position by your final depth?

remDr$navigate("https://adventofcode.com/2021/day/2/input")

raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\\\n$","",.) %>%
  str_split(pattern = "\n") %>%
  unlist() %>%
  enframe(name= NULL) %>%
  separate(value, c("movement","n"), sep = " ", extra = "merge", fill = "right") %>%
  mutate(n = as.numeric(n)) 

dat <- raw %>%
  group_by(movement) %>%
  summarise(n = sum(n, na.rm = T)) %>%
  pivot_wider(names_from = movement,
              values_from = n) %>%
  mutate(total = abs((down - up)) * forward)




## Part 2 ##

# Question: What do you get if you multiply your final horizontal position by your final depth?

aim <- 0
hposition <- 0
depth <- 0

for(i in 1:nrow(raw)){
  if(raw$movement[i] == "down"){
    aim = aim + raw$n[i]
  } else if(raw$movement[i] == "up"){
    aim = aim - raw$n[i]
  } else {
    hposition = hposition + raw$n[i]
    depth = depth + aim * raw$n[i]
  }
}

depth * hposition




# End of File