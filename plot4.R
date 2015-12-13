data <- read.csv("household_power_consumption.txt", sep = ";", head = T)

data$Date = as.Date(data$Date,"%d/%m/%Y")
data$DateWeekday = format(data$Date,"%a")

dates <- as.Date(c("2007-02-01", "2007-02-02"))
data = data[ dates[1] == data$Date | dates[2]== data$Date, ]

data$Global_active_power = as.numeric(as.character(data$Global_active_power))

days_portuguese = c("qui","sex","sáb")
data = data[data$DateWeekday %in% days_portuguese,]


# png("fig2.png", width = 480, height = 480)
par(mfrow= c(2,2))

# 1
with(data, plot(y =  Global_active_power, 1:nrow(data),type="l",ylab = "Global Active Power (kilowatts)", xlab = "", xaxt="n"))
days_english = c("Thu","Fri","Sat")
index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)

# 2
with(data, plot(y =  Voltage, 1:nrow(data),type="l",ylab = "Voltage", xlab = "", xaxt="n"))
index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)

# 3
data$Sub_metering_1 = as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 = as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 = as.numeric(as.character(data$Sub_metering_3))

with(data, plot(y =  Sub_metering_1, 1:nrow(data),type="l",ylab = "Energy sub metering", xlab = "datetime", xaxt="n"))
with(data,  lines(col ="red",y =  data$Sub_metering_2, 1:nrow(data) ))
with(data,  lines(col ="blue",y =  data$Sub_metering_3, 1:nrow(data)  ))

index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)
legend("topright", lty = 1,  col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

dev.off()





# dev.off()