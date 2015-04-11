# The data from household_power_consumption.txt was inserted into the SQLite
# database to be easy to extract only the data we need. see transform_csv_to_sqlite.R
db <- "data/household_power_consumption.db"

library(RSQLite)
library(grDevices)

con <- dbConnect(dbDriver("SQLite"), dbname=db)
data <- dbGetQuery(con, "select * from household_power_consumption a where a.Date == '1/2/2007' OR a.Date == '2/2/2007';")
dbDisconnect(con)

# Generate the plot
png(filename = "plot1.png")
par(bg="transparent", mar=c(5, 4, 2, 2))
hist(data$Global_active_power, col="red", main="Global Active Power", axes=FALSE,
     xlab="Global Active Power (kilowatts)", ylab="Frequency", xlim=c(0, 7))
axis(1, at=seq(0, 6, by=2))
axis(2, at=seq(0, 1200, by=200))
dev.off()
