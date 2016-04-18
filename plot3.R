#import data loading, etc. utility functions
source('loadData.R')

#current device.
plot3 <- function(pngDevice){
  print('Running plot3')
  
  data <- getData()
  
#if a new png is requested, open a new png device.
  if(pngDevice){
    dir.create('out', showWarnings='F')
    png('out/plot3.png', width=480, height=480, bg='transparent')
  }
  
#do the plot
  with(data, {
    plot(DateTime, Sub_metering_1, type='l', xlab='', ylab="Energy sub metering")
    lines(DateTime, Sub_metering_2, type='l', col='red')
    lines(DateTime, Sub_metering_3, type='l', col='blue')
  })
  
  legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd='1', col=c('black', 'red', 'blue'))
  
  #if a new png was created, dispose of it, which saves the file.
  if(pngDevice){
    dev.off()
  }
}
#its own png, but the plotting to plot3.png is carried out when plot3.R is called independently.
if(!disablePlottingToFile){
  plot3(T)
}