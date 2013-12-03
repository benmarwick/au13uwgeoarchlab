#' Get geoarchaeological and radiocarbon date data from a Google sheet 
#' 
#' This function connects to a Google sheet and brings the
#' data in the the R workspace. An internet connection is
#' required. 
#' 
#' @return A data frame
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
  


get_data <- function(){
  # connect to google sheet
  require(RCurl) # if you get an error message here that says something like 'there is no package called 'RCurl''
  # then you need to install the package by typing this into the console (and then hitting enter): install.packages("RCurl")
  # wait for the package to download and install, then run line 3 again before proceeding.
  options(RCurlOptions = list(capath = system.file("CurlSSL", "cacert.pem", package = "RCurl"), ssl.verifypeer = FALSE))
  # in google spreadsheet, go to file-> publish to web -> get link to publish to web -> get csv file
  goog <- "https://docs.google.com/spreadsheet/pub?key=0As7CmPqGXTzldE5UV3FOZTRlYy10ZF9JOWcxYy1tSGc&single=true&gid=0&output=csv"
  # assign data from google sheet to R object
  data <- read.csv(textConnection(getURL(goog)), stringsAsFactors = FALSE)
  
  # replace google docs' '#DIV/0!' with something that R understands
  data[ data == '#DIV/0!']  = NA
  # convert data types from character to numeric so we 

  # rename some variables so it's not such a mouthful
  names(data)[names(data) == 'MS.LF.reading.average.mass.susceptibility'] <- 'mean.MS.LF'
  names(data)[names(data) == 'MS.FD'] <- 'mean.MS.FD'
  names(data)[names(data) == 'LOI.percent.organic.material..Average'] <- 'mean.Organic'
  names(data)[names(data) == 'LOI.Percent.carbonate.content..Average'] <- 'mean.CaCO3'
  
  # only get geoarch dat
  
  geoarch <- data[!is.na(data$Sample.ID),1:174]
  
  # only get archaeological data
  
  # subset just sq B
  sqB <- data[data$square == "B", 176:242]
  # convert all to numeric
  sqB <- suppressWarnings(data.frame(apply(sqB, 2, as.numeric, as.character)))
  # replace NA with zero
  sqB[is.na(sqB)] <- 0
  # put in order by spit
  sqB <- with(sqB, sqB[order(spit), ])
  # combine teeth and bone masses from sq B
  sqB$Teeth_mass_g[is.na(sqB$Teeth_mass_g)] <- 0
  sqB$Bone_teeth_mass_g <- with(sqB, Teeth_mass_g + Bone_Bulk_mass_g)
  # approximate depth to make comparable to geoarch data
  # need to update this with real depth data from the spit sheets
  sqB$depth <- round((sqB$spit * 0.05), 1)
  
  # merge geoarch data with finds data by depth below surface
  xx <- merge(geoarch, sqB, by.x = 'Sample.ID', by.y = 'depth', all.x = TRUE)
  # remove dupoicate lines where finds have multiple matches with one depth
  xx <- xx[!duplicated(xx$Sample.ID), ]
  
  return(xx)
  
}