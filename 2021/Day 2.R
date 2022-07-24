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

start <- proc.time()
raw %>%
  group_by(movement) %>%
  summarise(n = sum(n, na.rm = T)) %>%
  pivot_wider(names_from = movement,
              values_from = n) %>%
  mutate(total = abs((down - up)) * forward)

end <- proc.time()
print(end - start)


## Part 2 ##

# Question: What do you get if you multiply your final horizontal position by your final depth?

aim <- function(movement, unit, base){
  aim = ifelse(movement == "down", base + unit, NA)
  aim = ifelse(movement == "up", base - unit, aim)
  aim = ifelse(movement == "forward", base, aim)
  aim = ifelse(is.na(aim), 0, aim)
  return(aim)
}


dat <- raw %>%
  mutate(
    direction = ifelse(movement == "forward", "horizontal", "vertical"),
    aim = aim(movement, n, lag(n)),
    depth = "z"
  ) %>%
  pivot_wider(names_from = movement,
              values_from = aim) %>%
  pivot_longer(cols = c(down,up)) %>%
  filter(is.na(value),
         !is.na(forward))


#    n2 = ifelse(movement == "up", n * -1, n),
#    aim = n2 + lag(n2)

#  mutate(aim = c(0, rep(NA, nrow(raw)-1)))
#  pivot_wider(names_from = movement,
#              values_from = n)


# End of File