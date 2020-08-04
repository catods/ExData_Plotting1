library(lubridate)
library(dplyr)
par(mfcol=c(1,1))
# Load the file converting the fields with "?" in NA
power <- read.table(file = "household_power_consumption.txt", 
                    header = TRUE,
                    sep = ";", 
                    na.strings = "?")
# Using a lubridate function creates a new column "dt" with the date and
# time from the two first columns in teh table 
power$dt <- dmy_hms(paste(power[,1],power[,2]))

# Coverts the table in a dplyr table to ease manipulation
power <- as_tibble(power)

# Takes only the dates from 2007-02-01 to 2007-02-02
powerGAP <- filter(power, 
                   power$dt>=ymd_hms("2007-02-01 00:00:00"), 
                   power$dt<=ymd_hms("2007-02-02 23:59:59"))

# PLOT 1: Histogram of Global Active Power
png("plot1.png")
hist(powerGAP$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()
