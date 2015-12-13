data <- read.csv("household_power_consumption.txt", sep = ";", head = T)

dates <- as.Date(c("2007-02-01", "2007-02-02"))
data$Date = as.Date(data$Date,"%d/%m/%Y")
data = data[ dates[1] == data$Date | dates[2]== data$Date, ]

data$Global_active_power = as.numeric(as.character(data$Global_active_power))

png("fig1.png", width = 480, height = 480,bg="transparent")

with(data, hist( main = "Global Active Power",  x =  Global_active_power, col = "red",xlim = c(0, 7), xlab = "Global Active Power (kilowatts)",  axes = F  ))
axis(1, seq(0,6,by=2))
axis(2, seq(0,1200,by=200))

dev.off()

