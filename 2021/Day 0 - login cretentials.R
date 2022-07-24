# Advent of Code

# Setup

# Needed Packages
pkgs <- c("tidyverse", "rvest", "RSelenium", "zoo")


# Install Packages
install <- function(x) {
  if (x %in% rownames(installed.packages()) == F) {
    install.packages(x, dependencies = T,
                     repos = "http://cran.us.r-project.org")
  }
}

lapply(pkgs, install)

# Load packages
lapply(pkgs, require, character.only = T)
rm(pkgs, install)


# Login to Advent of Code
rD <- rsDriver(browser = "firefox")
remDr <- rD$client
remDr$navigate("https://github.com/login?client_id=7bb0a7ec13388aa67963&return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3D7bb0a7ec13388aa67963%26duration%3Dtemporary%26redirect_uri%3Dhttps%253A%252F%252Fadventofcode.com%252Fauth%252Fgithub%252Fcallback%26response_type%3Dcode%26scope%3D%26state%3Dx")

abs(rnorm(1, 55, 0.4)) # (it may take a while to connect to selenium server)


username <- remDr$findElement(using = 'id', 'login_field')
username$sendKeysToElement(list(paste0(EMAIL)))

password <-  remDr$findElement(using = 'id', 'password')
password$sendKeysToElement(list(paste0(PASSWORD), key = "enter"))


# End of File