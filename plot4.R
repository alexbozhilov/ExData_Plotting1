#import data loading, etc. utility functions
source('loadData.R')
plot4 <- function(){
  print('Running plot4')
  
  data <- getData()
  
#import the functions plot2() and plot3()
#and disable plotting, so the scripts don't render to their pngs.
  disablePlottingToFile <<- T
  source('plot2.R')
  source('plot3.R')
#functions imported, so reset the flag.
  disablePlottingToFile <<- F
  
#helper function to plot Voltage vs DateTime to current device.
  plotVoltage <- function(){
    with(data, {
      plot(DateTime, Voltage, xlab='datetime', type='l')
    })
  }
  
#helper function to plot Global reactive power vs DateTime to current device.
  plotGRP <- function(){
    with(data, {
      plot(DateTime, Global_reactive_power, xlab='datetime', type='l')
    })
  }
  
#create output directory if it doesn't exist    
  dir.create('out', showWarnings='F')
#create the png.
  png('out/plot4.png', width=480, height=480, bg='transparent')
  
#we want four graphs, 2 per row.
  par(mfrow=c(2,2))
  
#plot the four graphs.
  plot2(F, 'Global Active Power')
  plotVoltage()
  plot3(F)
  plotGRP()
  
  dev.off()
}

plot4()