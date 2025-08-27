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
png("plot2.png", width = 480, height = 480)
plot(x = data$Datetime, y = data$Global_active_power, type = "l", xaxt = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
axis(side = 1, at = c(ymd_hms("2007-02-01 00:00:00"), ymd_hms("2007-02-02 00:00:00"), ymd_hms("2007-02-03 00:00:00")), labels = c("Thu", "Fri", "Sat"))
dev.off()