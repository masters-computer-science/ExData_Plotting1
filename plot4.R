library(dplyr)

if (!file.exists("./data/exdata-data-household_power_consumption.zip")) {
  fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./data/exdata-data-household_power_consumption.zip",method="curl")
}

if (!file.exists("./data/household_power_consumption.txt")) {
  unzip("./data/exdata-data-household_power_consumption.zip", exdir="./data/")
}

corpus <- read.table("./data/household_power_consumption.txt", header=TRUE,
                     sep=";",na.strings = "?")

subset <- filter(corpus, corpus$Date == "1/2/2007" | corpus$Date == "2/2/2007")

subset$DateTime <- strptime(paste(subset$Date, subset$Time), "%d/%m/%Y %H:%M:%S")

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(subset, {
  
  plot(subset$DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  
  plot(subset$DateTime, Voltage, xlab = "datetime", type = "l", ylab = "Voltage")
  
  plot(1:nrow(subset),subset$Sub_metering_1,xlab="",ylab= "Energy sub metering",xaxt="n",type= "l",col="black")
  par(new=TRUE) 
  plot(1:nrow(subset),subset$Sub_metering_2,xlab="",ylab= "",xaxt="n",yaxt="n",ylim=c(min(subset$Sub_metering_1),max(subset$Sub_metering_1)),type= "l",col="red")
  par(new=TRUE) 
  plot(1:nrow(subset),subset$Sub_metering_3,xlab="",ylab= "",xaxt="n",yaxt="n",ylim=c(min(subset$Sub_metering_1),max(subset$Sub_metering_1)),type= "l",col="blue")
  xlim = dim(subset)[1]
  xcenter = xlim/2 + 1
  axis(1,at=c(1,xcenter,xlim),labels=c("Thu","Fri","Sat"))
  legend("topright",col=c("black","red","blue"),lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")) 
  
  
  plot(subset$DateTime, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  
})
dev.off()