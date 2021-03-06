## Get data & Unzip

if (!file.exists('household_power_consumption.txt')) {
  url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile = "dataset.zip")
  unzip("dataset.zip")
}

## Read data
temp <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?",sep = ";")
data <- temp[(temp$Date == "1/2/2007" | temp$Date == "2/2/2007"),]
rm(temp)

## Combine Date and Time

data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Open png device
png("plot1.png", width = 480, height = 480)

## Plot the graph
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Save
dev.off()
