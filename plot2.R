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
png("plot2.png", width = 480, height = 480)

## plot graph
data["DateTime"] <- paste(data$Date, data$Time) # combine dates and times
data["DateTime"] <- dmy_hms(data$DateTime) # convert to numeric vector for plotting

plot(data$DateTime, data$Global_active_power, 
     type = "n", # plots no data
     ylab = "Global Active Power (kilowatts)",
     xlab = "", # plots no labels on the x-axis
     xaxt = "n" # plot no ticks on the x-axis
     )

lines(data$DateTime, data$Global_active_power) # add line data

axis(1, at = dmy_hm(c("1/2/2007 00:00", "2/2/2007 00:00", "3/2/2007 00:00")),
     labels = c("Thu", "Fri", "Sat")) # add custom ticks on x-axis to match example

## close device
dev.off()


