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

#Subset data of 2007-02-01 and 2007-02-02
subsetData <- subset(data, Date %in% c("2007-02-01","2007-02-02"))

# set graphic device png and initialize variables width and height
png("plot1.png", width=480, height=480)

#plot
globalActivePower <- as.numeric(subsetData$Global_active_power)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

#Device off
dev.off()