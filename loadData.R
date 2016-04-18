#Use sqldf to load only the data required. 
if(!require('sqldf')){
  install.packages('sqldf')
}
library(sqldf)

#This function loads the data and caches it.
loadData <- function(){    
#this function downloads the zip file if it's not in the current working folder.
  downloadData <- function(url, zipFile){    
    if(!file.exists(zipFile)){
#download file. Try default method first. If that fails (e.g. for https and linux), try wget.
      tryCatch(
        download.file(url, destfile=zipFile)
        , error = function(e){
          download.file(url, destfile=zipFile, method='wget')
        }
      )
    }
  }
  
#this function extracts the zip file if the target data file is not 
#already in the current working folder.
  extractFile <- function(file, zipFile) {
    if(!file.exists(file)) {
      unzip(zipFile, files=file)
    }
  }
  
#this function extracts the required data, downloading and extracting files as needed.
#it returns the cleaned target data.
  prepareData <- function(){
    url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    targetFile <- 'household_power_consumption.txt'
    zipFile <- 'exdata-data-household_power_consumption.zip'
    
    downloadData(url, zipFile)
    extractFile(targetFile, zipFile)
    
#vector specifying the column data types.
    cols <- c("character", "character", rep("numeric", 7))
    
#sql query to fetch only the required columns.
    sql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
    
#read in the required rows.
    d <- read.csv.sql(targetFile, sql, sep=';'
                      ,colClasses=cols
                      ,header=T)
    
#we need to get the datetime in order to plot against it.
    dateTime <- paste(d$Date, d$Time, sep=' ')
    dateTime <- strptime(dateTime, format="%d/%m/%Y %H:%M:%S")
    
#we add the datetime vector as a new column to the imported data.
    d$DateTime <- dateTime
    
#we return the data.
    d
  }
  
#return the data for plotting.
  prepareData()
}

#this function gets the clean data into the outer namespace, if not already there,
#and returns it. This means the data is loaded only once in a session.
getData <- function(){
  if(!exists('loadedData')){
    loadedData <<- loadData()
  }
  
  loadedData
}

#as needed.
if(!exists('disablePlottingToFile'))
  disablePlottingToFile <- F