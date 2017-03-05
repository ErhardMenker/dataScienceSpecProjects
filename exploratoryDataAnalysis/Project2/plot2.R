setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/Exploratory_Data_Analysis/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Take out every row not in Baltimore
NEI_BALT <- NEI[NEI$fips == "24510", ]

# split by the year and sum the emissions
emis_sums <- tapply(NEI_BALT$Emissions, NEI_BALT$year, sum)

# plot pollution as a function of year
plot(unique(NEI_BALT$year), emis_sums, xlab="Year", ylab="Total Emissions")
lines(unique(NEI_BALT$year), emis_sums)
title(main="Baltimore Emissions by Year")
dev.copy(png, file="plot2.png")
dev.off()