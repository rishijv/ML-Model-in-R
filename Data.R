library(data.table)
library(dplyr)
library(DT)
library(ggplot2)
library(glue)
library(kernlab)
library(LiblineaR)
library(randomForest)
library(RCurl)
library(rlang)
library(shiny)
library(shinythemes)

VGData <- read.csv('/Users/rishivora/Downloads/R-Assignments/ML-Model-in-R/ML-Model-in-R/vgsales.csv')
View(VGData)

PlatformSales <- do.call(rbind, Map(data.frame, Platform=VGData$Platform, Sales=VGData$Global_Sales))
View(PlatformSales)

PlatformSales_Combined = PlatformSales %>% group_by(Platform)  %>%
  summarise(totalSales = sum(Sales))
View(PlatformSales_Combined)

VGData %>% filter(VGData$Platform == "PC")-> PCMarket
VGData %>% filter(VGData$Publisher == "Nintendo")-> Nintendo

View(Nintendo)

sum(VGData$NA_Sales)
sum(VGData$EU_Sales)
sum(VGData$JP_Sales)
sum(VGData$Other_Sales)





