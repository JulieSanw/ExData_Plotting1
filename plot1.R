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
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar = c(8, 8, 7, 6))
hist(powerDataN$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

# Close 
dev.off()