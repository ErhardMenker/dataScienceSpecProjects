setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/Exploratory_Data_Analysis/project2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# only extract out Baltimore and LA rows
NEI_BALT_LA <- NEI[NEI$fips %in% c("24510", "06037"), ]
# only extract SCC identifiers related to "motor vehicles"
NEI_MV <- NEI_BALT_LA[NEI_BALT_LA$SCC %in% 
                          unique(as.character(SCC[grep("[Mm]otor", SCC$Short.Name), 1])), ]

# aggregate NEI_MV by year
NEI_SUM <- aggregate(NEI_MV$Emissions, by=list(year=NEI_MV$year, fips=NEI_MV$fips), sum)
names(NEI_SUM)[3] = "Emissions"
qplot(year, Emissions, color=fips, data=NEI_SUM, geom="line",
      main="Baltimore (24510) & LA (06037) Motor Vehicle Time Series")

dev.copy(png, file="plot6.png")
dev.off()