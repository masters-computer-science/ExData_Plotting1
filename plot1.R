
if (!file.exists("./data/exdata-data-household_power_consumption.zip")) {
  fileUrl="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./data/exdata-data-household_power_consumption.zip",method="curl")
}

if (!file.exists("./data/household_power_consumption.txt")) {
  unzip("./data/exdata-data-household_power_consumption.zip", exdir="./data/")
}

corpus <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
subset <- filter(corpus, corpus$Date == "1/2/2007" | corpus$Date == "2/2/2007")

png(filename = "plot1.png", 
    width = 480, height = 480)
hist(subset$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     breaks=12, ylim = c(0, 1200))
dev.off()