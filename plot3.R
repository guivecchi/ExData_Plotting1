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

## The third plot is a line chart of all three sub meterings
## First, let's create a datetime variable
datetime <- strptime(paste(power_data$Date, power_data$Time, sep=" "), "%Y-%m-%d %H:%M:%S") 

## Let's plot it. 
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
       lty = 1)

## Now we'll copy it to a png file.
dev.copy(png, file = "plot3.png")
dev.off()