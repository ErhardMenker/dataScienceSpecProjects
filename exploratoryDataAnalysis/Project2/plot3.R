setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/Exploratory_Data_Analysis/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

require(ggplot2)

# Take out every row not in Baltimore
NEI_BALT <- NEI[NEI$fips == "24510", ]
# aggregate DF by the year and type
NEI_BALT <- aggregate(NEI_BALT$Emissions, by=list(year=NEI_BALT$year, type=NEI_BALT$type), sum)
names(NEI_BALT)[3] <- "emission.sum" 

dev.copy(png, file="plot3.png")
qplot(year, emission.sum, data=NEI_BALT, color=type, geom=c("line"), main="Baltimore Emissions by Year & Type")
dev.off()

rm(list=ls())