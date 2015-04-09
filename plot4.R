setwd("F:/coursra/Exploratory Data Analysis/project")

#read data
electric <- read.table("./P1/household_power_consumption.txt", head = TRUE, sep = ";",
                       colClasses = c("character","character","character","character","character","character","character","character","character"))

#subset data and change data type
edata <- electric[electric$Date %in% c("1/2/2007","2/2/2007"),]
edata$Time <- paste(edata$Date, edata$Time)
edata$Time <- strptime(edata$Time, "%d/%m/%Y %H:%M:%S")
edata$Date <- as.Date(edata$Date, "%d/%m/%Y")
edata[,3:9] <- sapply(edata[,3:9], as.numeric)  #missing value "?" will be changed into NA automatically
all(colSums(is.na(edata[,3:9]))==0)             #check if there is any missing value

#Plot 4
par(mfrow = c(2, 2), cex = 0.7)
with(edata, {
        plot(Time, Global_active_power, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(Time, Voltage, type = "l", 
             ylab = "Voltage", xlab = "datetime")
        plot(Time, Sub_metering_1, type = "n", ylab ="Energy sub metering", xlab = "")
        lines(Time, Sub_metering_1)
        lines(Time, Sub_metering_2, col ="red")
        lines(Time, Sub_metering_3, col ="blue")
        legend("topright", lty = 1, col = c("black","red", "blue"), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n", cex = 0.8)
        plot(Time, Global_reactive_power, type = "l", 
             ylab = "Global_reactive_power", xlab = "datetime")        
})

#save the plot
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()