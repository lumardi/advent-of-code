# Advent of Code - 2021


#### Day 5: Hydrothermal Venture ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: At how many points do at least two lines overlap?

remDr$navigate("https://adventofcode.com/2021/day/5/input")


raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\n$","",.) %>%
  str_split(pattern = "\n") %>%
  unlist() %>%
  gsub("[^0-9,\\-\\>]","",.) %>%
  enframe(name=NULL) 


dat <- raw %>%
  separate(value,c("x1","y1","x2","y2"),sep = "\\,|>",fill = "right",extra = "merge") %>%
  mutate(across(everything(),as.numeric)) %>%
  filter(x1 == x2 | y1 == y2) %>%
  mutate(
    dx = map2(x1,x2,seq),
    dy = map2(y1,y2,seq),
    aux = map2(dx,dy,paste)) %>%
  unnest(cols = c(dx,dy,aux)) %>%
  group_by(aux) %>%
  summarise(n = n()) %>%
  filter(n>1)

nrow(dat)




## Part 2 ##


# Question: You need to also consider diagonal lines. At how many points do at least two lines overlap?


dat <- raw %>%
  separate(value,c("x1","y1","x2","y2"),sep = "\\,|>",fill = "right",extra = "merge") %>%
  mutate(across(everything(),as.numeric)) %>%
  mutate(
    dx = map2(x1,x2,seq),
    dy = map2(y1,y2,seq),
    aux = map2(dx,dy,paste)
    ) %>%
  unnest(cols = c(dx,dy,aux)) %>%
  group_by(aux) %>%
  summarise(n = n()) %>%
  filter(n>1)

nrow(dat)



# End of File