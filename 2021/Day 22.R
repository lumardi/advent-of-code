# Advent of Code - 2021


#### Day 22: Seven Segment Search ####

## Manual Input ##
EMAIL <- "YOUR_EMAIL"
PASSWORD <- "YOUR_PASSWORD"
PATH <- "YOUR/PATH/"

# Login Remotely
source(paste0(PATH, "Day 0 - login cretentials.R"))


## Part 1 ##

# Question: fterward, considering only cubes in the region x=-50..50,y=-50..50,z=-50..50, how many cubes are on?


remDr$navigate("https://adventofcode.com/2021/day/22/input") 


raw <- read_html(remDr$getPageSource()[[1]]) %>%
  html_nodes(xpath = "//pre") %>%
  html_text() %>%
  gsub("\n$","",.) %>%
  str_split(pattern = "\n") %>%
  unlist() %>%
  enframe(name=NULL) %>%
  separate(value, c("status","aux","x1","x2","y1","y2","z1","z2"),
           sep = " |\\,*.\\=|\\.{2}",extra = "merge",fill = "right") %>%
  mutate(
         across(c(x1:z2),as.numeric),
         x = map2(x1,x2, ~seq(.x,.y)),
         y = map2(y1,y2, ~seq(.x,.y)),
         z = map2(z1,z2, ~seq(.x,.y))
         ) %>%
  select(status,x,y,z)


dat <- array(rep("off", 101 * 3), dim = c(101, 101, 101))


for(i in 1:nrow(raw)){
  
  # coords in range: x=-50..50,y=-50..50,z=-50..50
  x = raw$x[[i]] + 51
  x = x[x %in% 1:101]

  y = raw$y[[i]] + 51 
  y = y[y %in% 1:101]
  
  z = raw$z[[i]] + 51 
  z = z[z %in% 1:101]
  
  # assigning coord values
  dat[x,y,z] = raw$status[i]
}

sum(dat == "on")


## Part 2 ##


# Question: Starting again with all cubes off, execute all reboot steps. Afterward, considering all cubes, how many cubes are on?











# End of File


