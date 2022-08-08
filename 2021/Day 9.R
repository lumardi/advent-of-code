# Advent of Code - 2021


#### Day 9: Smoke Basin ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question:  What is the sum of the risk levels of all low points on your heightmap?

remDr$navigate("https://adventofcode.com/2021/day/9/input") 


raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("^\n","", .) %>%
  strsplit("\n") %>%
  unlist() %>%
  enframe(name=NULL) %>%
  separate(value, paste0("col",1:101), sep="(?=[[:digit:]])", extra = "merge") %>%
  select(-col1) %>%
  mutate(across(everything(),as.numeric)) %>%
  as.data.frame()

raw = "
2199943210
3987894921
9856789892
8767896789
9899965678" %>%
  gsub("^\n","", .) %>%
  strsplit("\n") %>%
  unlist() %>%
  enframe(name=NULL) %>%
  separate(value, paste0("col",LETTERS[1:11]), sep="(?=[[:digit:]])", extra = "merge") %>%
  select(-colA) %>%
  mutate(across(everything(),as.numeric)) %>%
  as.data.frame()


low.point <- c()

for(i in 1:nrow(raw)){
  for(j in 1:ncol(raw)){
    aux = c(raw[i,j],raw[i-1,j],raw[i+1,j], raw[i,j-1], raw[i,j+1]) %>%
      as.numeric() %>%
      min(.,na.rm = T)
   if(raw[i,j] <= aux){
     low.point = c(low.point,aux)
   } 
  }
}


risk.level <- low.point + 1

sum(risk.level)









## Part 2 ##

# Question: 





# End of File