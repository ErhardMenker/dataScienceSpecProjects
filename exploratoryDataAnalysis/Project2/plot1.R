setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/Exploratory_Data_Analysis/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# split by the year and sum the emissions
emis_sums <- tapply(NEI$Emissions, NEI$year, sum)

# plot pollution as a function of year
plot(unique(NEI$year), emis_sums, xlab="Year", ylab="Total Emissions")
lines(unique(NEI$year), emis_sums)
title(main="United States Emissions by Year")
dev.copy(png, file="plot1.png")
dev.off()
