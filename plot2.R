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

# make line graph  
plot(epc$datetime, epc$Global_active_power,type="l", ylab="Global Active Power (kilowatts)",)   

# save as a png      
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()