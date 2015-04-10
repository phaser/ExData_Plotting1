sourceFile <- "data/household_power_consumption.txt"
destFile <- "data/household_power_consumption.db"

library(RSQLite)

con <- dbConnect(dbDriver("SQLite"), dbname=destFile)
dbWriteTable(con, name="household_power_consumption", value=sourceFile, row.names=FALSE, header=TRUE, sep=";")
dbDisconnect(con)
