data <- read.csv("household_power_consumption.txt", sep = ";", head = T)

data$Date = as.Date(data$Date,"%d/%m/%Y")

dates <- as.Date(c("2007-02-01", "2007-02-02"))
data = data[ dates[1] == data$Date | dates[2]== data$Date, ]

data$Sub_metering_1 = as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 = as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 = as.numeric(as.character(data$Sub_metering_3))

png("fig3.png", width = 480, height = 480,bg="transparent")

with(data, plot(y =  Sub_metering_1, 1:nrow(data),type="l",ylab = "Energy sub metering", xlab = "", xaxt="n"))
with(data,  lines(col ="red",y =  data$Sub_metering_2, 1:nrow(data) ))
with(data,  lines(col ="blue",y =  data$Sub_metering_3, 1:nrow(data)  ))

days_english = c("Thu","Fri","Sat")
index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)
legend("topright", lty = 1,  col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()







