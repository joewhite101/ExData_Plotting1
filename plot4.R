
#Read the data file
housing<-read.csv("household_power_consumption.txt",sep=";")

#Transform to a standard date columng
housing$Date <- as.Date(housing$Date, "%d/%m/%Y")

#Filter to only the dates we care about and convert the Global_active_power var to a numeric variable for plotting
housing<-housing[housing$Date =='2007-02-01' | housing$Date =='2007-02-02',]
housing$Global_active_power <- as.numeric(as.character(housing$Global_active_power))
housing$Global_reactive_power <- as.numeric(as.character(housing$Global_reactive_power))
housing$Sub_metering_1 <-as.numeric(as.character(housing$Sub_metering_1))
housing$Sub_metering_2 <-as.numeric(as.character(housing$Sub_metering_2))
housing$Sub_metering_3 <-as.numeric(as.character(housing$Sub_metering_3))
housing$Voltage <- as.numeric(as.character(housing$Voltage))

#Create a date time element since we care about hours in this case
housing$dateTime <- strptime(paste(housing$Date,housing$Time), format="%Y-%m-%d %H:%M:%S")

par( mfrow = c( 2, 2 ) )

#Open the PNG device, plot with the hist function and relable the graph
png(filename="plot4.png",width = 480, height = 480, units = "px")
par( mfrow = c( 2, 2 ) )
#Draw  first plot
plot(housing$dateTime, housing$Global_active_power, ylab="Global Active Power",xlab="", type="n")
lines(housing$dateTime, housing$Global_active_power)

#Draw voltage plot
plot(housing$dateTime, housing$Voltage, ylab="Voltage",xlab="datetime", type="n")
lines(housing$dateTime, housing$Voltage)

#Draw sub-metering plot
plot(housing$dateTime, housing$Sub_metering_1, ylab="Energy sub metering",xlab="", type="n")
lines(housing$dateTime, housing$Sub_metering_1,col="black")
lines(housing$dateTime, housing$Sub_metering_2,col="red")
lines(housing$dateTime, housing$Sub_metering_3,col="blue")
legend(x="topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)

#Draw reactive power plot
plot(housing$dateTime, housing$Global_reactive_power, ylab="Global_reactive_power",xlab="datetime", type="n")
lines(housing$dateTime, housing$Global_reactive_power)
dev.off()