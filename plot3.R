## plot3

## Creates a temporary file
temp <- tempfile()

## Downloads the zip file 
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

## Unzips the file
unzippedFile <- unzip(temp)
unlink(temp)                    ## removes the temporary file

## Reads the data and sets the dates in the right format
data <- read.table(unzippedFile, header=TRUE, sep=";")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## Creates a subset of the data within the desired dates
power <- data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]

## Sets the variables into the right format
power <- transform(power, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))

## Creates the plot (plot3) and saves it as a .png file
plot(power$timestamp,power$Sub_metering_1, 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
lines(power$timestamp,power$Sub_metering_2,
      col="red")
lines(power$timestamp,power$Sub_metering_3,
      col="blue")
legend("topright", 
       col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), 
       lwd=c(1,1))

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()

## Informs where the .png file has been saved
cat("plot3.png saved in", getwd())

