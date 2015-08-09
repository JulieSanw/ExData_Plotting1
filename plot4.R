# Read data from file
start <- function() {
  
  library(data.table)
  #Get the data table
  file_name <- "household_power_consumption.txt"
  powerData <- fread(file_name, header=TRUE, sep=";", colClasses="character", na="?")
  
  #Set date format and get two-day data
  FormatDateTime <- powerData
  powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
  powerDataN <-  powerData[powerData$Date >= "2007-02-01" & powerData$Date <= "2007-02-02"]
  powerDataN <- data.frame(powerDataN)
  for(col in c(3:9)) {
    powerDataN[,col] <- as.numeric(as.character(powerDataN[,col]))
  }
  
  # Format DateTime
  powerDataN$DateTime <- paste(powerDataN$Date, powerDataN$Time)
  powerDataN$DateTime <- strptime(powerDataN$DateTime, format = "%Y-%m-%d %H:%M:%S")
  
  return (powerDataN)
}

#Reading the data
powerDataN <- start()

#Construct the plot and save it to a PNG file
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow=c(2,2))

#First Plot
plot(powerDataN$DateTime, powerDataN$Global_active_power, type="l", xlab=" ", ylab="Global Active Power")

#Second Plot
plot(powerDataN$DateTime, powerDataN$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Third Plot
plot(powerDataN$DateTime, powerDataN$Sub_metering_1, col = "black", type="l", xlab=" ", ylab="Energy sub metering")
lines(powerDataN$DateTime, powerDataN$Sub_metering_2, col = "red")
lines(powerDataN$DateTime, powerDataN$Sub_metering_3, col = "blue")
legend("topright", col=c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

#Fourth Plot
plot(powerDataN$DateTime, powerDataN$Global_reactive_power, type="n", xlab = "datetime", ylab = "Global_reactive_power")
lines(powerDataN$DateTime, powerDataN$Global_reactive_power)

# Close 
dev.off()

