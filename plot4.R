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


# PLOT 4: Creates a 2x2 matrix of plots that shows how the global active power, 
# voltage, energy sub metering and reactive power change in the time
png("plot4.png")
# Set the 2x2 matrix to contain the 4 plots and set the margins
par(mfcol=c(2,2), mar=c(4,4,0,1))
with(powerGAP,{  

  # PLOT 1.2: Plots the active power as it changes in the time
  plot(dt, Global_active_power, 
       type="l", 
       xlab="", 
       ylab="Global Active Power (kilowatts)")
  
  
  # PLOT 2.1: Plots the sub metering 1, 2 and 3 as they change in the time
  plot(dt, Sub_metering_1, 
       type="l", 
       xlab="", 
       ylab="Energy sub metering",
       col = "black")
  points(dt, Sub_metering_2, 
         type="l", 
         col = "red")
  points(dt, Sub_metering_3, 
         type="l", 
         col = "blue")
  legend("topright",
         bty = "n",
         xjust = 1,
         yjust = 0,
         x.intersp = 0.3,
         y.intersp = 0.7,
         inset = 0,
         pch = NA,
         pt.lwd = 1,
         lwd = 1,
         col = c("black","red","blue"), 
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))  
  
  # PLOT 1.2: Plots the voltage  as they change in the time
  plot(powerGAP$dt, powerGAP$Voltage, 
       type="l", 
       xlab="datetime", 
       ylab="Voltage")
  
  # PLOT 2.2: Plots the reactive power as they change in the time
  plot(powerGAP$dt, powerGAP$Global_reactive_power, 
       type="l", 
       xlab="datetime", 
       ylab="Global reactive power")
  
})
dev.off()
