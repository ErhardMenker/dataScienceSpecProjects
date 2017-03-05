setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/Exploratory_Data_Analysis/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Find the values of SCC associated with coal and create a new DF with just those values
coal_id <- unique(as.character(SCC[grep("[Cc]oal", SCC$EI.Sector), 1]))
NEI_COAL <- NEI[NEI$SCC %in% coal_id, ]

# Aggregate the coal pollution df based on year
NEI_COAL <- aggregate(NEI_COAL$Emissions, by=list(year=NEI_COAL$year), sum)
names(NEI_COAL)[2] <- "emission.sum"

# Plot 
ggplot2::qplot(year, emission.sum, data=NEI_COAL, col=I("blue"),
               main="Total Emissions in US for Coal Pollution", geom="line")

dev.copy(png, file="plot4.png")
dev.off()
