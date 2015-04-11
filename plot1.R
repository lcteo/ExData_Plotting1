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
hist(reqconsumption$Global_active_power, main = "Global Active power", col = "red", xlab = "Global Active Power (kilowatts)", )

# Saves data to png file
dev.copy(png, file = "plot1.png", height = 480, width = 480)

# Close the PNG device
dev.off()