options(java.parameters = "-Xmx8000m") #8 mgb RAM

myfile <- file.choose()

#Import data
hpc <- read.table(myfile,header = TRUE,sep = ";")

#Convert the date column
hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")

subhpc <- hpc[hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02",]

#Plot 1 histogram
subhpc$Global_active_power <- as.numeric(as.character(subhpc$Global_active_power))
hist(subhpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "./plot1.png",width = 480, height = 480)
dev.off()