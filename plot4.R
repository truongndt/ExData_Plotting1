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
png("plot4.png", width = 480, height = 480)

## Plot the graph
par(mfcol=c(2,2))
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(data$DateTime, data$Sub_metering_1, type="l", col="black",xlab="", ylab="Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty = 1)
plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## Save
dev.off()