### Load the correct two days of data into memory

suppressMessages(library(lubridate))

data_file_name <- 'household_power_consumption.txt'
column_names <- strsplit(readLines(data_file_name, 1), ";")[[1]]                       # get column names
lines_to_skip <- grep("^1/2/2007", readLines('household_power_consumption.txt'))[1] - 1 # first occurrence of "1/2/2007" minus 1
rows_to_read <- 60 * 24 * 2                                                             # number of minutes in two days
operating_data <- read.table(
  data_file_name, 
  sep = ";", 
  skip = lines_to_skip, 
  nrows = rows_to_read, 
  col.names = column_names,
  stringsAsFactors = FALSE,
  na.strings = c("?","NA")
)
operating_data$DateTime = dmy_hms(paste(operating_data$Date, operating_data$Time))

### Set the PNG device and the graph flow

png("plot4.png")

par(mfrow = c(2,2))

### GRAPH 1: Global active power ~ DateTime (copied from plot2.R)

with(
  operating_data, 
  plot(
    DateTime, 
    Global_active_power, 
    type="l", 
    xlab="", 
    ylab="Global Active Power (kilowatts)"
  )
)

### GRAPH 2: Voltage ~ DateTime
with(
  operating_data, 
  plot(
    DateTime, 
    Voltage, 
    type="l", 
    xlab="datetime", 
    ylab="Voltage"
  )
)


### GRAPH 3: Energy sub metering ~ DateTime (mostly copied from plot3.R)
#axes, labels, and Sub_metering_1 in black
with(
  operating_data, 
  plot(
    DateTime, 
    Sub_metering_1, 
    type="l", 
    xlab="", 
    ylab="Energy sub metering"
  )
)

#add sub_metering_2 in red
with(
  operating_data, 
  lines(
    DateTime, 
    Sub_metering_2, 
    col="red"
  )
)

#add sub_metering_3 in blue
with(
  operating_data, 
  lines(
    DateTime, 
    Sub_metering_3, 
    col="blue"
  )
)

#add legend
legend(
  "topright", 
  c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
  col = c("black","red","blue"), 
  lty = c(1, 1, 1),
  bty = "n"   # different from plot3 - no legend box
)

### GRAPH 4: Global reactive power ~ DateTime
with(
  operating_data, 
  plot(
    DateTime, 
    Global_reactive_power, 
    type="l", 
    xlab="datetime", 
    ylab="Global_reactive_power"
  )
)

dev.off()