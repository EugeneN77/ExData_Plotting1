options(java.parameters = "-Xmx8000m") #8 mgb RAM

myfile <- file.choose()

#Import data
hpc <- read.table(myfile,header = TRUE,sep = ";")

#Convert the date column
hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")

subhpc <- hpc[hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02",]

#Plot 2
with(subhpc, {
  plot(
    strptime(paste(subhpc$Date, subhpc$Time,sep = " "),"%Y-%m-%d %H:%M:%S"), 
    Global_active_power, 
    type="l",
    xlab = "",
    ylab = "Global Active Power (kilowatts)")
  })

dev.copy(png, file = "./plot2.png",width = 480, height = 480)
dev.off()