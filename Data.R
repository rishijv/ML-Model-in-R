VGData <- read.csv('B:/Random Coding Stuff/ML-Model-in-R/vgsales.csv')
View(VGData)

PlatformSales <- do.call(rbind, Map(data.frame, Platform=VGData$Platform, Sales=VGData$Global_Sales))

VGData %>% filter(VGData$Platform == "PC")-> PCMarket
VGData %>% filter(VGData$Publisher == "Nintendo")-> Nintendo

View(Nintendo)

sum(VGData$NA_Sales)
sum(VGData$EU_Sales)
sum(VGData$JP_Sales)
sum(VGData$Other_Sales)

