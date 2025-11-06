
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
png("plot1.png", width = 480, height = 480)

## generate histogram of Global Active Power
hist(data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0, 1200)
)

## close device
dev.off()
