library(lubridate)

## download data, if necessary
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household_power_consumption.zip"

if(!file.exists(filename)){
        print("downloading data...")
        
        download.file(url = data_url,
                      destfile = filename,
                      method = "curl"
                      )
        
        unzip(filename)
        }

## load data
data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   na.strings = "?",
                   sep = ";"
                   )

## subset data
data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## setup graphic device
png("plot4.png", width = 480, height = 480)

## setup grid
par(mfrow = c(2, 2))

## create time axis for plots
data["DateTime"] <- paste(data$Date, data$Time) # combine dates and times
data["DateTime"] <- dmy_hms(data$DateTime) # convert to numeric vector for plotting

## plot graph at grid location [1, 1]
plot(data$DateTime, data$Global_active_power, 
     type = "n", # plots no data
     ylab = "Global Active Power",
     xlab = "", # plots no labels on the x-axis
     xaxt = "n" # plot no ticks on the x-axis
)

lines(data$DateTime, data$Global_active_power) # add line data

axis(1, at = dmy_hm(c("1/2/2007 00:00", "2/2/2007 00:00", "3/2/2007 00:00")),
     labels = c("Thu", "Fri", "Sat")) # add custom ticks on x-axis to match example

## plot graph at grid location [1, 2]
plot(data$DateTime, data$Voltage, 
     type = "n", # plots no data
     ylab = "Voltage",
     xlab = "datetime",
     xaxt = "n" # plot no ticks on the x-axis
)

lines(data$DateTime, data$Voltage) # add line data

axis(1, at = dmy_hm(c("1/2/2007 00:00", "2/2/2007 00:00", "3/2/2007 00:00")),
     labels = c("Thu", "Fri", "Sat")) # add custom ticks on x-axis to match example

## plot graph at grid location [2, 1]
plot(data$DateTime, data$Sub_metering_1, 
     type = "l", # plots no data
     ylab = "Energy sub metering",
     xlab = "", # plots no labels on the x-axis
     xaxt = "n" # plot no ticks on the x-axis
) # add data sub metering 1

lines(data$DateTime, data$Sub_metering_2, col = "red") # add data sub metering 2
lines(data$DateTime, data$Sub_metering_3, col = "blue")# add data sub metering 3

axis(1, at = dmy_hm(c("1/2/2007 00:00", "2/2/2007 00:00", "3/2/2007 00:00")),
     labels = c("Thu", "Fri", "Sat")) # add custom ticks on x-axis to match example

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1
)

## plot graph at grid location [2, 2]
plot(data$DateTime, data$Global_reactive_power, 
     type = "n", # plots no data
     ylab = "Global_reactive_power",
     xlab = "datetime",
     xaxt = "n" # plot no ticks on the x-axis
)

lines(data$DateTime, data$Global_reactive_power) # add line data

axis(1, at = dmy_hm(c("1/2/2007 00:00", "2/2/2007 00:00", "3/2/2007 00:00")),
     labels = c("Thu", "Fri", "Sat")) # add custom ticks on x-axis to match example

## close device
dev.off()