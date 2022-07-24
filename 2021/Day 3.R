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
  as.data.frame() %>%
  separate(col = ".", into = LETTERS[1:13], sep = "") 


start <- proc.time()

rays <- function(x,fun) {
  ux <- unique(x)
  tab <- tabulate(match(x, ux))
  ux[tab == fun(tab)]
}

dat = tibble(
  gamma = map_chr(raw, ~{rays(.x, max)}),
  epsilon = map_chr(raw, ~{rays(.x, min)})
) %>%
  map_dbl(~{paste(.x,collapse = '') %>%
      strtoi(base = 2) 
  }) %>%
  prod(.,na.rm = T)

end <- proc.time()
print(end - start)


## Part 2 ##

# Question:  What is the life support rating of the submarine?


raw <-  data.table::fread("test.txt",colClasses = "character") %>%
  as.data.frame() %>%
  separate(col = "V1", into = LETTERS[1:6], sep = "") 


o2co2 <- function(x, fun, trigger){
  aux = c()
  
  for(j in 2:ncol(x)){
    ux = unique(x[,j])
    tab = tabulate(match(x[,j], ux))
    
    if(tab[1] == tab[2]){
      key = trigger
    } else {
      key = ux[tab == fun(tab)]
    }
    aux =  c(aux, key)
  }
  
  return(aux)
}


dat <- tibble(
  o2 = o2co2(raw, max, "1"),
  co2 = o2co2(raw, min, "0")
) %>%
  map_dbl(~{
    paste(.x, collapse = '') %>%
      strtoi(base = 2)
  }) %>%
  prod(., na.rm = T)


# End of File