# Advent of Code - 2021


#### Day 4: Giant Squid ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: What will your final score be if you choose that board?


remDr$navigate("https://adventofcode.com/2021/day/4/input")

draws <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  str_split(pattern = ",") %>%
  unlist() %>%
  gsub("\\n.*","",.) 

cards <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\\\n$","",.) %>%
  str_split(pattern = "\n") %>%
  unlist() %>%
  tail(600) %>%
  gsub(" {1,}"," ",.) %>%
  gsub("^ {1,}","",.) %>%
  gsub(" {1,}$","",.) %>%
  subset(., . != "") %>%
  enframe(name = NULL) %>%
  separate(col = "value", into = LETTERS[1:5], sep = " ") %>%
  mutate(id = rep(1:100, each = 5)) %>%
  split(.$id) %>%
  map(~dplyr::select(.x,-id) %>%
        mutate(across(everything(),as.integer))) %>%
  map(as.matrix)
#  map(~{cbind(.x, t(.x))}) %>%



cheatsheet <-   
  
  
  start <- proc.time()

for(i in 1:draws){
  
}

dat <- raw %>%
  map(~{mutate(.x,across(everything(),~ifelse(. == 7,"LMAO", .))) %>%
      map(.,~paste(.x,collapse = ''))
  }) 


end <- proc.time()
print(end - start)

a = raw %>%
  as.list()


for(i in 1:length(draws)){
  
  
}


# End of File