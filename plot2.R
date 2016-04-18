#import data loading, etc. utility functions
source('loadData.R')

#plot 2. The parameter ylab defaults to plot2's target label, but setting this
#parameter enables us to override the y axis label.
plot2 <- function(pngDevice, ylab='Global Active Power (kilowatts)'){
  print('Running plot2')
  
  data <- getData()
  
#if a new png is requested, open a new png device.
  if(pngDevice){
    dir.create('out', showWarnings='F')
    png('out/plot2.png', width=480, height=480, bg='transparent')
  }
  
#do the plot
  with(data, {
    plot(DateTime, Global_active_power, type='l', xlab='', ylab=ylab)
  })
  
#if a new png was created, dispose of it, which saves the file.
  if(pngDevice){
    dev.off()
  }
}
#its own png, but the plotting to plot2.png is carried out when plot2.R is called independently.
if(!disablePlottingToFile){
  plot2(T)
}