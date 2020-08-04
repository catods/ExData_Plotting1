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

# PLOT 2: Plots the active power as it changes in the time
png("plot2.png")
with(powerGAP,  
     plot(dt, Global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power (kilowatts)"))
dev.off()
