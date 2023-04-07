# Myanmar Economic Monitor

# Filepaths --------------------------------------------------------------------
db_dir <- file.path("~", "Dropbox", "World Bank", "Side Work", "Myanmar Economic Monitor")

data_dir      <- file.path(db_dir, "data")
ntl_bm_dir    <- file.path(data_dir, "Nighttime Lights BlackMarble")
gas_flare_dir <- file.path(data_dir, "Global Gas Flaring")

fig_dir <- file.path(db_dir, "outputs", "figures")

# Functions --------------------------------------------------------------------
pad3 <- function(x){
  if(nchar(x) == 1) out <- paste0("00", x)
  if(nchar(x) == 2) out <- paste0("0", x)
  if(nchar(x) == 3) out <- paste0(x)
  return(out)
}
pad3 <- Vectorize(pad3)

pad2 <- function(x){
  if(nchar(x) == 1) out <- paste0("0", x)
  if(nchar(x) == 2) out <- paste0(x)
  return(out)
}
pad2 <- Vectorize(pad2)

# Packages ---------------------------------------------------------------------
library(dplyr)
library(readr)
library(janitor)
library(raster)
library(sf)
library(stringr)
library(readxl)
library(exactextractr)
#library(blackmarbler)
library(geodata)
library(lubridate)
library(rgeos)
library(leaflet)
library(leaflet.extras)
library(ggplot2)


library(purrr)
library(furrr)
library(stringr)
library(rhdf5)
library(raster)
library(dplyr)
library(sf)
library(lubridate)