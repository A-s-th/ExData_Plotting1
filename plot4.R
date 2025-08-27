# Load the required libraries
library(dplyr)
library(lubridate)

# Download the data and unzip it
if(!file.exists("./data")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "./data")  
  unzip("./data")
}

# Import the dataset using only data from dates 2007-02-01 and 2007-02-02
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) %>%
  mutate(Date = dmy(Date), Time = hms(Time)) %>%
  mutate_at(c(3:9), as.numeric) %>%
  filter(between(Date, ymd("2007-02-01"), ymd("2007-02-02"))) %>%
  mutate(Datetime = Date + Time)

# Opening a png file as graphic device, creating the plot and closing the graphic device when it's done
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

plot(x = data$Datetime, y = data$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power")
axis(side = 1, at = c(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-02 00:00:00"), ymd_hms("2007-02-03 00:00:00")), labels = c("Thu", "Fri", "Sat"))

plot(x = data$Datetime, y = data$Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage")
axis(side = 1, at = c(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-02 00:00:00"), ymd_hms("2007-02-03 00:00:00")), labels = c("Thu", "Fri", "Sat"))

plot(x = data$Datetime, y = data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
points(x = data$Datetime, y = data$Sub_metering_2, type = "l", col = "red")
points(x = data$Datetime, y = data$Sub_metering_3, type = "l", col = "blue")
axis(side = 1, at = c(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-02 00:00:00"), ymd_hms("2007-02-03 00:00:00")), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))

plot(x = data$Datetime, y = data$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime", ylab = "Global Reactive Power")
axis(side = 1, at = c(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-02 00:00:00"), ymd_hms("2007-02-03 00:00:00")), labels = c("Thu", "Fri", "Sat"))

dev.off()