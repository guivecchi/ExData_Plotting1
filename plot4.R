## Let's start by reading the txt file and storing it into the power_data variable.
power_data <- read.csv("household_power_consumption.csv", sep = ";")

# Convert "?" in NAs
power_data[power_data == "?"] <- NA

## Convert numeric columns to the numeric data type
power_data[, 3:9] <- sapply(power_data[, 3:9], as.numeric)

## We have loaded all the data, so let's subset the dataset only for the dates defined.
## First let's convert the Date column to the Date format
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")
power_data <- subset(power_data, power_data$Date == "2007-02-01" | power_data$Date == "2007-02-02")

## The fourth plot is a combination of 4 plots
## First, let's create a datetime variable
datetime <- strptime(paste(power_data$Date, power_data$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

## Let's create the plot grid
par(mfrow = c(2, 2))

## Plot 1: Global Active Power line chart 
plot(datetime, power_data$Global_active_power, 
     type = "l", 
     xlab="",
     ylab="Global Active Power (kilowatts)")

## Plot 2: Voltage line chart
plot(datetime, power_data$Voltage, 
     type = "l", 
     xlab="",
     ylab="Voltage")

## Plot 3: Sub metering line chart
plot(datetime, power_data$Sub_metering_1, 
    type = "l", 
    xlab="",
    ylab="Energy sub metering")
lines(datetime, power_data$Sub_metering_2, 
     col = "red")
lines(datetime, power_data$Sub_metering_3, 
      col = "blue")

## Finally let's add the legend
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty = c(1,1,1), bty="n", cex=0.5)

## Plot 4: Global_reactive_power line chart
plot(datetime, power_data$Global_reactive_power, 
     type = "l", 
     xlab="",
     ylab="Global Reactive Power")

## Now we'll copy it to a png file.
dev.copy(png, file = "plot4.png")
dev.off()