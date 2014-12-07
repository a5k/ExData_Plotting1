## basic set up clear all existing variables 
rm(list = ls(all=T))

## first read the entire dataset. wee aren't focusing 
##on execution efficiency at this point 

data <-read.table("./../../household_power_consumption.txt", 
                  header = TRUE, sep = ";", 
                  colClasses = NA, na.strings = "?")

## this reads in dates and times as characters
## so we first convert dates and times to date
## and time classes. 
data$Date <- as.Date(data$Date, "%d/%m/%Y") ## date conversion
##subset to just the days needed
data <- data[which(data$Date >="2007-02-01" & data$Date <= "2007-02-02"),]

## now create a DateTime column and convert to datetime format 
data$datetime <- as.POSIXct(paste(data$Date, data$Time))

## send it to the PNG device
##open the PNG graphics device
png(filename = "./Plot4.png", width = 480, height = 480, units = "px")

## set mfrow to two cols and two rows
par(mfrow = c(2,2))
## adjust margins
par(mar = c(4,4,2,2))
##create the first plot
with(data, plot(datetime, Global_active_power, 
                type = "l", col = "black", 
                xlab = "", 
                ylab = "Global Active Power"))

##create the second plot
with(data, plot(datetime, Voltage, 
                type = "l", col = "black", 
                xlab = "datetime", 
                ylab = "Voltage"))

##create the third plot
{with(data, plot(datetime, Sub_metering_1, 
                type = "l", xlab = "", 
                ylab = "Enery sub metering", 
                col = "black"))
## add the two other lines to this plot
lines(data$datetime, data$Sub_metering_2, type = "l", col = "red")
lines(data$datetime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1), bty = "n",
       col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))}


##create the final plot
with(data, plot(datetime, Global_reactive_power, 
                type = "l", col = "black", 
                xlab = "datetime", 
                ylab = "Global_reactive_power"))



##make sure you close the graphics device
dev.off() 