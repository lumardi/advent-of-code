# Advent of Code - 2021


#### Day 3: Dive! ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question:  What is the power consumption of the submarine?


remDr$navigate("https://adventofcode.com/2021/day/3/input")

raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\\\n$","",.) %>%
  str_split(pattern = "\n") %>%
  unlist() %>%
  enframe(name=NULL,value="string") %>%
  separate(col = "string", into = LETTERS[1:13], sep = "") %>%
  select(-A)


rays <- function(x,fun) {
  ux = unique(x)
  tab = table(match(x, ux))
  ux[tab == fun(tab)]
}


dat <- tibble(
  gamma = map_chr(raw, ~{rays(.x, max)}),
  epsilon = map_chr(raw, ~{rays(.x, min)})) %>%
  map_dbl(~{paste(.x,collapse = '') %>%
      strtoi(base = 2)}) %>%
  prod(.,na.rm = T)



## Part 2 ##

# Question:  What is the life support rating of the submarine?


o2co2 <- function(data, fun, tiebreak){
  for(i in 1:ncol(data)){
    tab = table(data[,i])
    bit = ifelse(tab[paste0(tiebreak)] == fun(tab), tiebreak, names(subset(tab,rownames(tab) != tiebreak)))
    data = data[data[,i] == bit,]
    if(nrow(data) == 1) break
  }
  data = paste(data, collapse = '') %>%
    strtoi(base = 2)
}

o2 <- o2co2(raw, max, "1")

co2 <- o2co2(raw, min, "0")

o2*co2



# End of File