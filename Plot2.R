processData <- function() 
{
  #########################################################################
  ## Plot 2 for the assignment at the end of week 1 of the EDA course.   ##
  ## Retrieves data from the  UC Irvine Machine Learning Repository.     ##
  #########################################################################
  
  if (!file.exists("data")) 
  { 
    stop("Data folder not found!")
  }
  
  ## Use the data.table library to read a large data table:
  library(data.table)
  library(dplyr)
  
  ## Fetch the household power consumption data:
  ## Only fetching the 2 days we need:
  householdData <- fread("data/household_power_consumption.txt",skip = 66637, nrows = 2880)
  
  names(householdData) <- c("Date",
                            "Time",
                            "Global_active_power",
                            "Global_reactive_power",
                            "Voltage",
                            "Global_intensity",
                            "Sub_metering_1",
                            "Sub_metering_2",
                            "Sub_metering_3")
  
  ## convert date and time column to a date/time for plotting:
  householdData <- mutate(householdData, newDatetime = as.POSIXct(strptime(paste(householdData$Date, householdData$Time), format = "%d/%m/%Y %H:%M:%S")))
  
  png(filename="Plot2.png", width = 480, height = 480)
  
  with(householdData, plot(Global_active_power ~ newDatetime, type="l", ylab = "Global Active Power (Kilowatts)", xlab=""))

  dev.off()
}