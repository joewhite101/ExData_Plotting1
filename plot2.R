
#Read the data file
housing<-read.csv("household_power_consumption.txt",sep=";")

#Transform to a standard date columng
housing$Date <- as.Date(housing$Date, "%d/%m/%Y")

#Filter to only the dates we care about and convert the Global_active_power var to a numeric variable for plotting
housing<-housing[housing$Date =='2007-02-01' | housing$Date =='2007-02-02',]
housing$Global_active_power <- as.numeric(as.character(housing$Global_active_power))


#Create a date time element since we care about hours in this case
housing$dateTime <- strptime(paste(housing$Date,housing$Time), format="%Y-%m-%d %H:%M:%S")


#Open the PNG device, plot with the hist function and relable the graph
png(filename="plot2.png",width = 480, height = 480, units = "px")
plot(housing$dateTime, housing$Global_active_power, ylab="Global Active Power (kilowatts)",xlab="", type="n")
lines(housing$dateTime, housing$Global_active_power)

dev.off()