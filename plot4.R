# The data from household_power_consumption.txt was inserted into the SQLite
# database to be easy to extract only the data we need. see transform_csv_to_sqlite.R
db <- "data/household_power_consumption.db"

library(RSQLite)
library(grDevices)

con <- dbConnect(dbDriver("SQLite"), dbname=db)
data <- dbGetQuery(con, "select * from household_power_consumption a where a.Date == '1/2/2007' OR a.Date == '2/2/2007';")
dbDisconnect(con)

# Create a new column DateTime
data <- transform(data, Date = as.Date(Date, format="%d/%m/%Y"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Generate the graphic
png(filename = "plot4.png")
par(bg="transparent", mfcol=c(2, 2))
with(data, {
    plot(DateTime, Global_active_power, type="n",
                xlab="", ylab="Global Active Power (kilowatts)")
    lines(DateTime, Global_active_power)
    plot(DateTime, Sub_metering_1, type="n",
                xlab="", ylab="Energy sub metering")
    lines(DateTime, Sub_metering_1)
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col=c("black", "red", "blue"), pch="_", bty="n")
    plot(DateTime, Voltage, type="n",
                xlab="datetime", ylab="Voltage")
    lines(DateTime, Voltage)
    plot(DateTime, Global_reactive_power, type="n",
                xlab="datetime")
    lines(DateTime, Global_reactive_power)
})
dev.off()