

# Create a temp file name
temp <- tempfile()

# fetch the file into the temp. file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

# extract the target file from temp file
data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";")

# Remove the temp file
unlink(temp)

#Format Date attribute
data$Date <- strptime(data$Date, format="%d/%m/%Y")
#data$Time <- strptime(data$Time, format="%H:%M:%S")

#Subset data of 2007-02-01 and 2007-02-02
subsetData <- subset(data, Date %in% c("2007-02-01","2007-02-02"))

# set graphic device png and initialize variables width and height
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

#plot
datetime <- strptime(paste(subsetData$Date, subsetData$Time, sep= " "), format="%Y-%m-%d %H:%M:%S")

globalActivePower <- as.numeric(subSetData$Global_active_power)
globalReactivePower <- as.numeric(subSetData$Global_reactive_power)
voltage <- as.numeric(subSetData$Voltage)
subMetering1 <- as.numeric(subSetData$Sub_metering_1)
subMetering2 <- as.numeric(subSetData$Sub_metering_2)
subMetering3 <- as.numeric(subSetData$Sub_metering_3)


 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()