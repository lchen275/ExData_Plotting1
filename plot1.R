library(readr)
library(tidyverse)
library(lubridate)
#
#
# Read/create subsetted DF
#
#

# Download the dataset
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./.zip")

# Unzip the dataset to "power_consumption_data" folder
unzip(zipfile = "./.zip", exdir = "./power_consumption_data")

#Read in dataset to R
full_data <- read_csv2("./power_consumption_data/household_power_consumption.txt", col_names = TRUE, na = "?")
#Convert cols to correct class
full_data$Global_active_power <-as.numeric(full_data$Global_active_power)
full_data$Global_reactive_power <-as.numeric(full_data$Global_reactive_power)
full_data$Global_intensity <-as.numeric(full_data$Global_intensity)
full_data$Sub_metering_1 <-as.numeric(full_data$Sub_metering_1)
full_data$Sub_metering_2 <-as.numeric(full_data$Sub_metering_2)
full_data$Sub_metering_3 <-as.numeric(full_data$Sub_metering_3)
full_data$Date <- as.Date(full_data$Date, "%d/%m/%Y")
#Check col classes are correct
sapply(full_data, class)
head(full_data)

#Subset data for plots - only rows from 1st and 2nd of Feb. 2007
plot_data <- subset(full_data, Date == "2007-02-01" | Date == "2007-02-02")

#
#
# Create Plot 1
#
#

png(file = "plot1.png", width =  480, height = 480)
hist(plot_data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
