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

dummydat <- data.frame(Indicator = c(LETTERS),
                       Category = c(rep("Economic", 5),
                                    rep("Social", 2),
                                    rep("Fish", 9),
                                    rep("FoodWebBase", 2),
                                    rep("Habitat", 3),
                                    rep("Climate", 5)),
                       SMARTRate = c(runif(26))
)
