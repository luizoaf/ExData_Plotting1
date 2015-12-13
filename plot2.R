data <- read.csv("household_power_consumption.txt", sep = ";", head = T)

data$Date = as.Date(data$Date,"%d/%m/%Y")
data$DateWeekday = format(data$Date,"%a")

dates <- as.Date(c("2007-02-01", "2007-02-02"))
data = data[ dates[1] == data$Date | dates[2]== data$Date, ]

data$Global_active_power = as.numeric(as.character(data$Global_active_power))

days_portuguese = c("qui","sex","sáb")
data = data[data$DateWeekday %in% days_portuguese,]


png("fig2.png", width = 480, height = 480, bg="transparent")

with(data, plot(y =  Global_active_power, 1:nrow(data),type="l",ylab = "Global Active Power (kilowatts)", xlab = "", xaxt="n"))
days_english = c("Thu","Fri","Sat")
index_friday = which(as.character(data$Time)=="00:00:00")[2]
axis(1, c(1,index_friday,nrow(data)),days_english)

dev.off()







