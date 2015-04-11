# The data from household_power_consumption.txt was inserted into the SQLite
# database to be easy to extract only the data we need.
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
png(filename = "plot2.png")
par(bg="transparent")
with(data, plot(DateTime, Global_active_power, type="n",
                xlab="", ylab="Global Active Power (kilowatts)"))
with(data, lines(DateTime, Global_active_power))
dev.off()