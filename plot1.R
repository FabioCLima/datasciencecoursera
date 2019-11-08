library(data.table)

PowerConsumption <- data.table::fread(input = "household_power_consumption.txt"
                                      , na.strings = "?")
head(PowerConsumption)

# Prevents histogram from printing in scientific notation
PowerConsumption[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


# Change Date Column to Date Type
PowerConsumption[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
PowerConsumption <- PowerConsumption[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
head(PowerConsumption)

## Plot 1

png("plot1.png", width = 480, height = 480)

hist(PowerConsumption[, Global_active_power], main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
dev.off()
