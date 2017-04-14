# Exploratory Data Analysis
# Coursera Data Science specialization
# Assignment #1  Plot 4
# Prepared by skewdlogix
# April 14, 2017

# Remove any old files and clean up workspace

rm(list=ls(all=TRUE))

# Call appropriate libraries for functions

library(dplyr)
library(lubridate)

# Create working directory if it does not already exist

if (!getwd() == 
    "D:/R_workplace/DataScienceSpecialization/exploratory_data_analysis/data")
{ dir.create("D:/R_workplace/DataScienceSpecialization/exploratory_data_analysis/data")
}

# Set working directory and assign it to wd

setwd("D:/R_workplace/DataScienceSpecialization/exploratory_data_analysis/data")
wd <- getwd()

# Download Data Files and Unzip Files to be Analyzed

# Assign dataset zipfile to a name 
# Assign url for file location to fileUrl  
# Download file using assigned parameters

a <- "Dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, file.path(wd, a))

# Extract all files from zip file

unzip(file.path(wd, a))

# Read Data Files into Workspace and Examine Characteristics

# Read data file into data frame in working directory  
# Examine size of data frame to get first indication of their dimensions

powconsmptn <- read.table(file.path(wd,"household_power_consumption.txt"), 
    header=TRUE, sep=";", stringsAsFactors=FALSE, na.strings='?',
    colClasses=c('character','character',rep('numeric',times=7)))

# Extract only data necessary for analysis

mydata <- which(powconsmptn$Date %in% c("1/2/2007","2/2/2007"))
powconsmptn <- powconsmptn[mydata,]

# Convert Date character variable to date format
# Create DateTime variable and convert to POSIXct format
# Delete Time variable since it is not used in analysis

powconsmptn$Date <- dmy(powconsmptn$Date)
powconsmptn$DateTime <- ymd_hms(paste(powconsmptn$Date,powconsmptn$Time))
powconsmptn$Time <- NULL

# Examine final data frame to ensure correct variables and correct format

str(powconsmptn)

# Create Plot 4
# Plot of Energy sub metering vs. DateTime

par(mfrow= c(2,2)) 
plot(powconsmptn$Global_active_power ~ powconsmptn$DateTime, type="l",
     ylab="Global Active Power", cex.lab= 0.9, cex.axis= 0.9, 
     xlab= "") 

plot(powconsmptn$Voltage ~ powconsmptn$DateTime, type="l", ylab="Voltage", 
     xlab= "datetime", cex.lab= 0.9, cex.axis= 0.9) 

plot(powconsmptn$Sub_metering_1 ~ powconsmptn$DateTime, type="l", 
     ylab="Energy sub metering", cex.lab= 0.9, cex.axis= 0.9, 
     xlab= "")
lines(powconsmptn$Sub_metering_2 ~ powconsmptn$DateTime, col="red")
lines(powconsmptn$Sub_metering_3 ~ powconsmptn$DateTime, col="blue")
legend("topright", lty= 1, col= c("black","red","blue"), 
       legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty= "n", cex= 0.7)

plot(powconsmptn$Global_reactive_power ~ powconsmptn$DateTime, type="l", 
     ylab="Global_reactive_power", xlab= "datetime", cex.lab= 0.9, 
     cex.axis= 0.9)

# Save file as Plot4.png

dev.copy(png, file = "Plot4.png", height = 480, width = 480)
dev.off()
