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

### Set the PNG device and plot the graph  

png("plot1.png")
hist(
  operating_data$Global_active_power, 
  col="red", 
  xlab = "Global Active Power (kilowatts)", 
  main="Global Active Power"
  )
dev.off()