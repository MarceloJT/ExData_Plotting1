## plot1

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
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))


## Creates the histogram (plot1) and saves it as a .png file
hist(power$Global_active_power,                    ## variable to plot
     main = paste("Global Active Power"),          ## main title
     col="red",                                    ## sets the color
     xlab="Global Active Power (kilowatts)")       ## x axis lable

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

## Informs where the .png file has been saved
cat("plot1.png saved in", getwd())

