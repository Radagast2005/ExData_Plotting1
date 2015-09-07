Sys.setlocale("LC_TIME", "English")


# Read file into a data frame
x <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
x$DateTime <- as.POSIXct(paste(x$Date, x$Time), format="%d/%m/%Y %H:%M:%S")
x$Date <- as.Date(x$Date, "%d/%m/%Y")
x$Time <- strptime(x$Time, "%H:%M:%S")


# Filter only the two dates in february 2007
y<-x[x$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

# Make the charts
par(mfrow = c(2,2))
plot(Global_active_power ~ DateTime, y, type = "l", ylab="Global Active Power (kilowatts)", xlab="")
plot(Voltage ~ DateTime, y, type = "l", ylab="Voltage", xlab="datetime")
plot(Sub_metering_1 ~ DateTime, y, type = "l", ylim=c(0,30), ylab="Energy sub metering", xlab="")
par(new=T)
plot(Sub_metering_2 ~ DateTime, y, type = "l", ylim=c(0,30), ylab="Energy sub metering", xlab="", col="red")
par(new=T)
plot(Sub_metering_3 ~ DateTime, y, type = "l", ylim=c(0,30), ylab="Energy sub metering", xlab="", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
plot(Global_reactive_power ~ DateTime, y, type = "l", ylab="Global_reactive_power", xlab="datetime", ylim = c(0.0, 0.5))

# Create PNG file
dev.copy(png, file ="plot4.png", width=480, height=480)
dev.off()

# Clean up
rm(x)
rm(y)