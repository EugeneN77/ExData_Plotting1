options(java.parameters = "-Xmx8000m") #8 mgb RAM

myfile <- file.choose()

#Import data
hpc <- read.table(myfile,header = TRUE,sep = ";")

#Convert the date column
hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")

subhpc <- hpc[hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02",]

#Set the next sub metering fields as numeric so that they can be used
subhpc$Sub_metering_1 <- as.numeric(as.character(subhpc$Sub_metering_1))
subhpc$Sub_metering_2 <- as.numeric(as.character(subhpc$Sub_metering_2))
subhpc$Sub_metering_3 <- as.numeric(as.character(subhpc$Sub_metering_3))
subhpc$Voltage <- as.numeric(as.character(subhpc$Voltage))
subhpc$Global_reactive_power <- as.numeric(as.character(subhpc$Global_reactive_power))

par(mfrow = c(2,2))
with(subhpc, {
  plot(
    strptime(paste(subhpc$Date, subhpc$Time,sep = " "),"%Y-%m-%d %H:%M:%S"), 
    Global_active_power, 
    type="l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)")
  plot(
    strptime(paste(subhpc$Date, subhpc$Time,sep = " "),"%Y-%m-%d %H:%M:%S"), 
    Voltage, 
    type="l",
    xlab = "",
    ylab = "Voltage"
  )  
  plot(
    strptime(paste(subhpc$Date, subhpc$Time,sep = " "),"%Y-%m-%d %H:%M:%S"), 
    Sub_metering_1, 
    type="l",
    xlab = "",
    ylab = "Energy sub metering"
  )
  lines(strptime(paste(subhpc$Date, subhpc$Time,sep = " "),"%Y-%m-%d %H:%M:%S"),subhpc$Sub_metering_2,col="red")
  lines(strptime(paste(subhpc$Date, subhpc$Time,sep = " "),"%Y-%m-%d %H:%M:%S"),subhpc$Sub_metering_3,col="blue")
  legend("topright", lty = "solid", col = c("black","red","blue"),
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         text.width = strwidth("Sub_meter"),
         ncol = 1,
         cex = 0.9,
         pt.lwd = 0.5,
         x.intersp = 7.,
         y.intersp = 0.8,
         adj = 0.55,
         bty = "n",
         seg.len = 1,
         inset = -0.03,
         xjust = 1,yjust = 1)
  plot(
    strptime(paste(subhpc$Date, subhpc$Time,sep = " "),"%Y-%m-%d %H:%M:%S"), 
    Global_reactive_power, 
    type="l",
    xlab = "",
    ylab = "Global_reactive_power"
  )
})

dev.copy(png, file = "./plot4.png",width = 480, height = 480)
dev.off()