##updated 2/7/15
## first read the entire dataset. wee aren't focusing 
##on execution efficiency at this point 

data <-read.table("./../household_power_consumption.txt", 
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

##open the PNG graphics device
png(filename = "./Plot2.png", width = 480, height = 480, units = "px")
##send the second plot to this device
with(data, plot(datetime, Global_active_power, 
                type = "l", col = "black", 
                xlab = "", 
                ylab = "Global Active Power (kilowatts)"))

##make sure you close the graphics device
dev.off() 