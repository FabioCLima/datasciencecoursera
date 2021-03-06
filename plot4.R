library(data.table)

PowerConsumption <- data.table::fread(input = "household_power_consumption.txt"
                                      , na.strings = "?")
head(PowerConsumption)

# Prevents histogram from printing in scientific notation
PowerConsumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
PowerConsumption[, DataTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-03
PowerConsumption <- PowerConsumption[(DataTime >= "2007-02-01") & (DataTime <= "2007-02-03")]

png("plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

# Plot 1
plot(PowerConsumption[, DataTime], PowerConsumption[, Global_active_power], type ="l", xlab ="", ylab ="Global Active Power")

# Plot 2
plot(PowerConsumption[, DataTime],PowerConsumption[, Voltage], type ="l", xlab="DataTime", ylab ="Voltage")

# Plot 3
plot(PowerConsumption[, DataTime], PowerConsumption[, Sub_metering_1], type = "l", xlab = "", ylab = "Energy sub metering")
lines(PowerConsumption[, DataTime], PowerConsumption[, Sub_metering_2], col = "red")
lines(PowerConsumption[, DataTime], PowerConsumption[, Sub_metering_3],col = "blue")
legend("topright", col = c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty = c(1,1)
       , bty = "n"
       , cex = .5) 

# Plot 4
plot(PowerConsumption[, DataTime], PowerConsumption[,Global_reactive_power], type = "l", xlab = "DataTime", ylab = "Global_reactive_power")

dev.off()