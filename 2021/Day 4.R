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

#Start by finding the sum of all unmarked numbers on that board;
#Then, multiply that sum by the number that was just called when the board won

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
        mutate(across(everything(),as.integer))) 


cards_marked = cards 


for(i in 1:length(draws)){
  cards_marked = cards_marked %>%
    map(.,~{mutate(.x,across(everything(),~gsub(paste0("^",draws[i],"$"), "X", .)))})
  
  last_draw = draws[i]
  
  if(any(map(cards_marked, ~{any(map_chr(.x,~{paste(.,collapse = '')}) == "XXXXX")}) == T |
         map(cards_marked, ~{any(map_chr(as.data.frame(t(.x)),~{paste(.,collapse = '')}) == "XXXXX")}) == T
  ) == T) break
}

winner <- cards_marked[[which(map(cards_marked, ~{any(map_chr(.x,~{paste(.,collapse = '')}) == "XXXXX")}) == T |
            map(cards_marked, ~{any(map_chr(as.data.frame(t(.x)),~{paste(.,collapse = '')}) == "XXXXX")}) == T)]]


score <- winner %>%
  mutate(across(everything(),as.numeric)) %>%
  sum(., na.rm = T) * as.numeric(last_draw)


## Part 2 ## 

# Figure out which board will win last. Once it wins, what would its final score be?  



cards_marked = cards 

nwon = NA

for(i in 1:length(draws)){
  # cards_marked = cards_marked %>%
  #   map(.,~{mutate(.x,across(everything(),~{
  #     ifelse(
  #       (any(map(cards_marked, ~{any(map_chr(.,~{paste(.,collapse = '')}) == "XXXXX")}) == T |
  #              map(cards_marked, ~{any(map_chr(as.data.frame(t(.)),~{paste(.,collapse = '')}) == "XXXXX")}) == T)
  #       ) == F,
  #       gsub(paste0("^",draws[i],"$"), "X", .),
  #       .)}
  #     ))
  #     })
  
  cards_marked = cards_marked %>%
    map(.,~{mutate(.x,across(everything(),~gsub(paste0("^",draws[i],"$"), "X", .)))})
  
  
  last_draw = draws[i]

  nwon[i] = sum(map(cards_marked, ~{any(map_chr(.x,~{paste(.,collapse = '')}) == "XXXXX")}) == T |
        map(cards_marked, ~{any(map_chr(as.data.frame(t(.x)),~{paste(.,collapse = '')}) == "XXXXX")}) == T)
  
  print(i)
  
  if(any(nwon == "100") == T) break
}


cards_marked = cards[[length(nwon)]] 

last_draw = NA

for(i in 1:length(draws)){
  cards_marked = cards_marked %>%
    mutate(across(everything(), ~gsub(paste0("^",draws[i],"$"), "X", .)))

  last_draw = draws[i]
  if(any(map_chr(cards_marked,~{paste(.x, collapse = '')}) == "XXXXX" | 
      map_chr(as.data.frame(t(cards_marked)), ~{paste(.x, collapse = '')}) == "XXXXX"
        )) break
}


score <- cards_marked %>%
  mutate(across(everything(),as.numeric)) %>%
  sum(., na.rm = T) * as.numeric(last_draw)














# End of File