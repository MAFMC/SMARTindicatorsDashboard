# call libraries for dashboard and set global attributes like themes/colors
library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(purrr)

ggplot2::theme_set(theme_bw())
