data <- read.csv("household_power_consumption.txt", sep = ";", head = T)

data$Date = as.Date(data$Date,"%d/%m/%Y")
data$DateWeekday = format(data$Date,"%a")

dates <- as.Date(c("2007-02-01", "2007-02-02"))
data = data[ dates[1] == data$Date | dates[2]== data$Date, ]

data$Global_active_power = as.numeric(as.character(data$Global_active_power))

days_portuguese = c("qui","sex","sáb")
data = data[data$DateWeekday %in% days_portuguese,]


png("fig4.png", width = 480, height = 480,bg="transparent")

par(mfrow= c(2,2))

# 1
with(data, plot(y =  Global_active_power, 1:nrow(data),type="l",ylab = "Global Active Power", xlab = "", xaxt="n"))
days_english = c("Thu","Fri","Sat")
index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)

# 2
plot(y =  data$Voltage, 1:nrow(data),type="l",ylab = "Voltage", xlab = "datetime", yaxt = "n", xaxt="n")
index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)
axis(2, seq(900,2100,by=200), c(234,"",238,"",242,"",246))


# 3
data$Sub_metering_1 = as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 = as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 = as.numeric(as.character(data$Sub_metering_3))

with(data, plot(y =  Sub_metering_1, 1:nrow(data),type="l",ylab = "Energy sub metering", xlab = "datetime", xaxt="n"))
with(data,  lines(col ="red",y =  data$Sub_metering_2, 1:nrow(data) ))
with(data,  lines(col ="blue",y =  data$Sub_metering_3, 1:nrow(data)  ))

index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)
legend("topright", lty = 1, bty="n", col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

#4
with(data, plot(y =  Global_reactive_power, 1:nrow(data),type="l", xlab = "datetime" , xaxt="n" , yaxt="n"))
days_english = c("Thu","Fri","Sat")
index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)
axis(2, seq(0,225,by=45), paste(seq(0,0.5,by=0.1),"",sep=""))

dev.off()



