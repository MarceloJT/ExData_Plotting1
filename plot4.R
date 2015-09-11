## plot4

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
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
power$Global_reactive_power <- as.numeric(as.character(power$Global_reactive_power))
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))


## Creates the plots (plot4) and saves it as a .png file

par(mfrow=c(2,2))                   ## sets 4 graphs in 2 rows, 2 columns

## plot 1
plot(power$timestamp,power$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power")

## plot 2
plot(power$timestamp,power$Voltage, 
     type="l", 
     xlab="datetime", 
     ylab="Voltage")

## plot 3
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
       bty="n",                                   ## removes the box
       cex=.5)                                    ## shrinks the text

## plot 4
plot(power$timestamp,power$Global_reactive_power, 
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

## Generates the .png file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()


## Informs where the .png file has been saved
cat("plot4.png saved in", getwd())

