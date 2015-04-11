# Download the Dataset: Electric power consumption [20Mb] into the R working 
# directory
# Description: Measurements of electric power consumption in one household with a 
# one-minute sampling rate over a period of almost 4 years. Different electrical 
# quantities and some sub-metering values are available.

# Clean up workspace
rm(list=ls())

# Unzip the file
unzip(zipfile="./exdata-data-household_power_consumption.zip")

# Read in the data 
epconsumption <- read.table("household_power_consumption.txt",header=T,sep=";",colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")

# convert to Date 
epconsumption$Date <- as.Date(epconsumption$Date, "%d/%m/%Y")

# Subset the data for the two dates of interest
reqconsumption <- subset(epconsumption, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Create Date_Time variable
reqconsumption$Datetime <- paste(reqconsumption$Date, reqconsumption$Time)

# Convert Date_Time variable
reqconsumption$Datetime <- strptime(reqconsumption$Datetime, "%Y-%m-%d %H:%M:%S")

# test on screen
windows()
par(mfrow = c(2, 2))
with(reqconsumption, {
    plot(Datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    
    plot(Datetime, Voltage, xlab = "datetime", type = "l", ylab = "Voltage")
    
    ylmt = range(c(reqconsumption$Sub_metering_1, reqconsumption$Sub_metering_2, reqconsumption$Sub_metering_3))
    plot(Datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylmt, col = "black")
    
    par(new = TRUE)
    plot(Datetime, Sub_metering_2, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylmt, col = "red")
    
    par(new = TRUE)
    plot(Datetime, Sub_metering_3, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylmt, col = "blue")
    
    legend("topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           bg = "transparent",
           bty = "n",
           lty = c(1,1,1),
           col = c("black", "red", "blue")
    )
    
    plot(Datetime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    
})

# Saves data to png file
dev.copy(png, file = "plot4.png", height = 480, width = 480)

# Close the PNG device
dev.off()