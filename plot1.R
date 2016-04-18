#import data loading, etc. utility functions
source('loadData.R')

plot1 <- function(){
  print('Running plot1')
  
  data <- getData()
  
#create output directory if needed.
  dir.create('out', showWarnings='F')
  
#plot to png
  png('out/plot1.png', width=480, height=480, bg='transparent')
  hist(data$Global_active_power, main="Global Active Power", 
       xlab="Global Active Power (kilowatts)", col='red')
  dev.off()
}


plot1()