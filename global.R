# call libraries for dashboard and set global attributes like themes/colors
library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(readr)
library(purrr)

ggplot2::theme_set(theme_bw())

# this is dummy data for testing purposes, replace with real dataset
min_val <- 1968
max_val <- 2025
EPUs <- c("MAB", "GB", "GOM", "All")

dummydat <- data.frame(Indicator = c(LETTERS),
                       Category = c(rep("Economic", 5),
                                    rep("Social", 2),
                                    rep("Fish", 9),
                                    rep("FoodWebBase", 2),
                                    rep("Habitat", 3),
                                    rep("Climate", 5)),
                       SMARTRate = c(runif(26)),
                       StartYear = replicate(length(LETTERS), sample(min_val:(min_val+20), 1)),
                       EndYear = replicate(length(LETTERS), sample((max_val-5):max_val, 1)),
                       EPU = replicate(length(LETTERS), sample(EPUs, size = 1, replace = TRUE))
)

smartratingdat <- readRDS(url("https://github.com/MAFMC/SMARTindicatorsData/raw/main/data-raw/smartratingdat.rds"))