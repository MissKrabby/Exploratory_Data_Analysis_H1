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

#Plot 1
with(edata, hist(Global_active_power, col = "red", 
                 xlab= "Global Active Power (kilowatts)", main = "Global Active Power"))

#save the plot
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()