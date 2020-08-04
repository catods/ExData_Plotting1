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

# PLOT 3: Plots the sub metering 1, 2 and 3 as they change in the time
png("plot3.png")
with(powerGAP,{  
     # Make the base plot for Sub Metering 1
     plot(dt, Sub_metering_1, 
          type="l", 
          xlab="", 
          ylab="Energy sub metering",
          col = "black")
     # Add the Sub Metering 2 series
     points(dt, Sub_metering_2, 
          type="l", 
          col = "red")
     # Add the Sub Metering 3 series
     points(dt, Sub_metering_3, 
            type="l", 
            col = "blue")
     # Add and format the legend to identify the series
     legend("topright", 
            pch=NA,
            pt.lwd=1,
            lwd = 1,
            col = c("black","red","blue"), 
            legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))  
})
dev.off()

