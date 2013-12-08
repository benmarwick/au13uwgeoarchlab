#' Plot radiocarbon date data 
#' 
#' This function draws a depth-age plot from radiocarbon date data. You must 
#' already have connected to the Google sheet and imported the data into your
#' R environment before running this function
#' 
#' @param my_data The data frame that resutled from running the get_data function
#' 
#' @param se draw the standard error area in the plot? Default in TRUE. To turn 
#' off the shaded standard error area, use se=FALSE
#' 
#' @return a plot
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  plot_dates(my_data)
  

plot_dates <- function(my_data, se=TRUE, ...){
# get date data from google sheet
# Raw data on AMS ages from DirectAMS, then prepare for OxCal batch conversion
# at https://c14.arch.ox.ac.uk/oxcal/OxCal.html
# In OxCal, File -> New then click the table view button and past in the dates
# in this format:
# Plot()
# {
#   R_Date("D-AMS 004027",347,26);
#   R_Date("D-AMS 004028",3372,27);
#   R_Date("D-AMS 004029",3767,30);
#   R_Date("D-AMS 004030",3733,29);
#   R_Date("D-AMS 004031",3843,29);
#   R_Date("D-AMS 004032",3923,30);
#   R_Date("D-AMS 004035",5973,30);
#   R_Date("D-AMS 004036",6127,31);
#   R_Date("D-AMS 004037",6506,38);
#   R_Date("D-AMS 004038",7961,39);
#   R_Date("D-AMS 004040",8526,42);
#   R_Date("D-AMS 004041",3726,33);
#   R_Date("D-AMS 004042",8735,38);
#   R_Date("D-AMS 004043",15863,69);
#   R_Date("D-AMS 004044",11719,48);
# };
# edit format and settings to return results in BP and get median and sigma
# using IntCal 13 curve
# then click File -> Run, then File -> Save As to get calibrated dates in a CSV
# add data from downloaded CSV to google docs (already done!)
# subset dates data from main data
  
#   # get geoarch table
#   my_data <- my_data[[1]]
  
dates <- na.omit(my_data[,c("DirectAMS.code",                                                                              
                         "Submitter.ID" ,                                                                                  
                         "d.13C..per.mil",                                                                                
                         "Fraction.of.modern.pMC",                                                                         
                         "Fraction.of.modern.1s.error",                                                                   
                         "Radiocarbon.age.BP",                                                                             
                         "Radiocarbon.age.1s.error",                                                                      
                         "OxCal.from",                                                                                     
                         "OxCal.to",                                                                                       
                         "OxCal..",                                                                                        
                         "OxCal.sigma",                                                                                    
                         "OxCal.median")])
# simplify data
# get spit number from 'Submitter.ID' field
dates$spit <- as.numeric(gsub("[^[:digit:]]", "", dates$Submitter.ID))
# we don't yet have the spit data to compute exact depths of the spits, so
# we'll approximate for now
dates$depth <- (dates$spit * 5)/100 # each spit was nominally 5 cm thick

###########################################################################
############### plot depth and age curve ##################################

# plot calibrated dates with a loess curve
require(ggplot2)
d <- ggplot(dates, aes(OxCal.median/1000, depth)) +
  geom_point(size = 4) + 
  stat_smooth(se=se) +
  ylab("Depth below surface (m)") +
  xlab("Age (x 1000 y cal BP)") +
  scale_y_reverse() +
  theme_minimal(...)

return (d)
  
}