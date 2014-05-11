#Setting working directory containing the source file
#setwd("...")

filename <- "household_power_consumption.txt"

#If file does not exists then it is downloaded and unzipped in the working directory
if(!file.exists(filename)) {
  temp <- tempfile()
  file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file.url, temp)
  unzip(temp)
  unlink(temp)
}

#Reading data
col.classes <- c("character", "character", rep("numeric", 7))
sourcedata <- read.csv(filename, sep= ";", colClasses= col.classes, na.strings=c("?"))

#Selecting dates
sel.dates <- subset(sourcedata, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, "%d/%m/%Y") == "2007-02-02" ) 

#Converting dates
sel.dates2 <- cbind.data.frame(
            strptime( paste(sel.dates$Date, " ", sel.dates$Time) , "%d/%m/%Y %H:%M:%S"), 
            sel.dates[, -c(1,2)]
            )
names(sel.dates2)[1] <- "Datetime"

#Setting locale
Sys.setlocale("LC_TIME", "English")

#Opening PNG output
png("plot2.png", 
    width = 480, 
    height = 480,
    bg= "transparent",
    antialias= "cleartype")

#Plotting
plot(sel.dates2$Datetime, sel.dates2$Global_active_power,
                      pch= ".",
                      xlab= "",
                      ylab= "Global Active Power (kilowatts)",
                      main= "")

lines(sel.dates2$Datetime, sel.dates2$Global_active_power)


dev.off()
