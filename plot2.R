Sys.setlocale("LC_TIME", "English")

# Read file into a data frame
x <- read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
x$DateTime <- as.POSIXct(paste(x$Date, x$Time), format="%d/%m/%Y %H:%M:%S")
x$Date <- as.Date(x$Date, "%d/%m/%Y")
x$Time <- strptime(x$Time, "%H:%M:%S")


# Filter only the two dates in february 2007
y<-x[x$Date %in% as.Date(c("2007-02-01","2007-02-02")),]

# Make plot
plot(Global_active_power ~ DateTime, y, type = "l", ylab="Global Active Power (kilowatts)")

# Create PNG file
dev.copy(png, file ="plot2.png", width=480, height=480)
dev.off()

# Clean up
rm(x)
rm(y)