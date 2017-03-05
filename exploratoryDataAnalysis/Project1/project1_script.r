setwd("C:/Data/Analytics_Studies/R/Data_Science_Specialization/Exploratory_Data_Analysis/project1/input")

# PREP DATA:
# unzip the file
unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")

# read the table in 
CONS <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", 
                   stringsAsFactors=FALSE)

# only subset rows with dates 2007-02-01 or 2007-02-02
CONS <- CONS[CONS$Date %in% c("1/2/2007","2/2/2007"),]

# CLEAN DATA:
require(lubridate)
# coerce the Date to the Date type
#CONS$Date <- lubridate::dmy(CONS$Date)
#CONS$Time <- lubridate::hms(CONS$Time)

# coerce last 7 rows to numerics
for(col in 3:9) {
    CONS[, col] <- as.numeric(CONS[, col])
}

# replace all "?" with the NA they represent
for(idx in 1:ncol(CONS)) {
    CONS[, idx][CONS[, idx] %in% "?"] <- NA
}

# create POSIX date time column that stores entire date from both date and time columns
CONS$DateTime <- lubridate::dmy_hms(paste(CONS$Date, CONS$Time))

#########################################################################################

# create an output directory if non exists and point the working directory there
if(!dir.exists("../output")) {dir.create("../output")}
setwd("../output")

# PLOT 1:
plot.new()
hist(CONS$Global_active_power, breaks=11, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
# export plot
dev.copy(png, "plot1.png")
dev.off()

# PLOT 2:
plot.new()
plot(x=CONS$DateTime, y=CONS$Global_active_power, type="l", 
     ylab="Global Active Power (kilowats)", xlab="")
# export plot
dev.copy(png, "plot2.png")
dev.off()

# PLOT 3:
plot.new()
matplot(x=CONS$DateTime, y=matrix(c(CONS$Sub_metering_1, CONS$Sub_metering_2, CONS$Sub_metering_3), ncol=3),
        xlab="", ylab="Energy sub metering", col=1:3, type="b", pch="|", xaxt='n')
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=1:3, pch="|")
axis(1, at=CONS$DateTime[c(800, 1800)], labels=format(CONS$DateTime[c(800, 1800)], "%a")) # format x-axis as date of week
# export plot
dev.copy(png, "plot3.png")
dev.off()

# PLOT 4:
plot.new()
# create a 2 by 2 graph presentation, filling columnwise
par(mfcol=c(2, 2))
# subplot i
plot(x=CONS$DateTime, y=CONS$Global_active_power, type="l", 
     ylab="Global Active Power (kilowats)", xlab="")
# subplot ii
matplot(x=CONS$DateTime, y=matrix(c(CONS$Sub_metering_1, CONS$Sub_metering_2, CONS$Sub_metering_3), ncol=3),
        xlab="", ylab="Energy sub metering", col=1:3, type="b", pch="|", xaxt='n')
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.5, col=1:3, pch="|")
axis(1, at=CONS$DateTime[c(800, 1800)], labels=format(CONS$DateTime[c(800, 1800)], "%a")) # format x-axis as date of week
# subplot iii
plot(x=CONS$DateTime, y=CONS$Voltage, type="l", 
     ylab="Voltage", xlab="datetime")
# subplot iii
plot(x=CONS$DateTime, y=CONS$Global_reactive_power, type="l", 
     ylab="Global_reactive_power", xlab="datetime")
# export plot
dev.copy(png, "plot4.png")
dev.off()