# Dan Allen 
# Exploratory Data Analysis - Week 1 - Course Project 1
# Plot 4
# 13Dec2020

# this is not needed but will clear out old variables
rm(list= ls())

# Load Libraries
library(dplyr)

#Prepare to download file
dataFileZip <- "exdata_data_household_power_consumption.zip"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Check for/make sub-directory "coursera"  
mainDir <- "C:"
subDir <- "coursera"
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

# Check for/make sub-directory "GetAndCleanData"  
mainDir <- paste(mainDir, "/", subDir,sep="")
subDir <- "ExploratoryDataAnalysis"
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

# Check for/make sub-directory "final"  
mainDir <- paste(mainDir, "/", subDir,sep="")
subDir <- "Week1"
ifelse(!dir.exists(file.path(mainDir, subDir)), dir.create(file.path(mainDir, subDir)), FALSE)

# Check if file exists downlaod.
mainDir <- paste(mainDir, "/", subDir,sep="")
filename <- paste(mainDir, "/", dataFileZip,sep="")
if (!file.exists(filename)){
   download.file(url, filename, method="curl")
}  

#Unzip 
unzip(filename) 

# Remove unneeded variables
rm(list="dataFileZip","url","mainDir","subDir","filename")

# read files
epc <- read.csv2("household_power_consumption.txt", header= TRUE)

# only keep 1-2Feb2007  
epc<-epc[epc$Date %in% c("1/2/2007","2/2/2007") ,]   

# Making a dateTime
epc$datetime <- strptime(paste(epc$Date, epc$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# convert string to number  
epc$Global_active_power <- as.numeric(as.character(epc$Global_active_power))
epc$Sub_metering_1 <- as.numeric(as.character(epc$Sub_metering_1))
epc$Sub_metering_2 <- as.numeric(as.character(epc$Sub_metering_2))
epc$Sub_metering_3 <- as.numeric(as.character(epc$Sub_metering_3))
epc$Voltage <- as.numeric(as.character(epc$Voltage))
epc$Global_reactive_power <- as.numeric(as.character(epc$Global_reactive_power))

# setup output
par(mfrow=c(2,2))

# make line graphs 
plot(epc$datetime, epc$Global_active_power,type="l", xlab="", ylab="Global Active Power (kilowatts)",)   
plot(epc$datetime, epc$Voltage,type="l", col = "black", xlab="datetime", ylab="Voltage",)   
plot(epc$datetime, epc$Sub_metering_1,type="l", col = "black", xlab="", ylab="Energy sub meeting",)   
lines(epc$datetime, epc$Sub_metering_2,type="l", col = "red")
lines(epc$datetime, epc$Sub_metering_3,type="l", col = "blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, cex=0.8)
plot(epc$datetime, epc$Global_reactive_power,type="l", col = "black", xlab="datetime", ylab="Global_reactive_power",)   

# save as a png      
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()