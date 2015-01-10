## Plot3.R
##Set directory
setwd("c:/users/owner/My Documents/coursera/ExploratoryDataAnalysis")

## download and unzip data file
## below setting is Windows-specific
setInternet2(use = TRUE)
## grab file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        "project1.zip")
## get file name
fname = unzip("project1.zip", list=TRUE)$Name[1]
## unzip main data file
unzip("project1.zip", files=fname, overwrite = TRUE)
fname

## Read in data to memory
cols <- c("character", "character", "numeric","numeric",
        "numeric","numeric","numeric","numeric","numeric")

power <- read.table("household_power_consumption.txt", header=TRUE, sep=";",
        stringsAsFactors = FALSE, na.strings="?",colClasses=cols,
        nrows=2100000)

use <- power$Date == "1/2/2007" | power$Date == "2/2/2007"
pow <- power[use,]

dtime <- strptime(paste(pow$Date," ",pow$Time),format="%d/%m/%Y %H:%M:%S")
pow <- cbind(pow,dtime)


## Plot3
dev.set(2)
par(mfrow=c(1,1))
with(pow,plot(dtime,Sub_metering_1, type="l",
        xlab="",ylab="Energy sub metering"))
with(pow,lines(dtime,Sub_metering_2, type="l", col="red"))
with(pow,lines(dtime,Sub_metering_3, type="l", col="blue"))
legend("topright",legend= names(pow)[7:9],lty=1, col=c("black","red","blue"))
dev.copy(png,file="plot3.png", width=480, height=480)
dev.off()


