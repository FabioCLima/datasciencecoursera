library(data.table)

PowerConsumption <- data.table::fread(input = "household_power_consumption.txt"
                                      , na.strings = "?")
head(PowerConsumption)

# Prevents histogram from printing in scientific notation
PowerConsumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


# Making a POSIXct date capable of being filtered and graphed by time of day
PowerConsumption[, DataTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
PowerConsumption <- PowerConsumption[(DataTime >= "2007-02-01") & (DataTime <= "2007-02-03")]
head(PowerConsumption)

## Plot 2
png("plot2.png", width = 480, height = 480)

plot(x = PowerConsumption[, DataTime]
     , y = PowerConsumption[, Global_active_power]
     , type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()
