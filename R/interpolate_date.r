#' Interpolate a radiocarbon date from a given depth below the surface 
#' 
#' This function calculates the age at a specific depth below the surface. 
#' It uses lowess interpolation to estimate a reasonable age, give the known
#' ages of the deposit. It assumes you have already got the data from the 
#' Google sheet. 
#' 
#' Lowess works by fitting a weighted linear model to a local subset of 
#' the data. So we cannot interpolate ages for depths less than the 
#' shallowest date or greater than the deepest date, where we have no 
#' date data. To compute dates for those depths we need to extrapolate. 
#' Reliable non-linear statistical methods of extrapolation are hard to find 
#' (I don't think there are any), so we're better off just eye-balling the 
#' values from a depth-age plot. If you try to compute an age for a depth
#' outside of the range of dated samples this function will return NA
#' 
#' @param my_data 
#' 
#' @return An age estimate for the depth provided
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  my_date_plot <- plot_dates(my_data)
#'  interpolate_date(my_data, 1.20) # where 1.20 is the depth in meters

#'  
  

interpolate_date <- function(my_data, depth_in_m, ...){
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
  # Compute values along loess curve to get ages for specific depths below the
  # surface (ie. ages for each sediment sample)
  span <- 0.75 # this has a big influence on the shape of the curve, experiment with it!
  cal.date.lo <- loess(OxCal.median ~ depth, dates, span = span)
  cal.date.pr <- predict(cal.date.lo, data.frame(depth = seq(0, max(dates$depth), 0.01)))
  cal.date.pr <- data.frame(age = unname(cal.date.pr), depth = as.numeric(names(cal.date.pr)))
  
  
  # here is a function to compute ages for specific depths... 
  d <- cal.date.pr[cal.date.pr$depth == round(depth_in_m*100),]$age # returns an estimated age 
                                                   # in ky BP from loess 
  # from http://stackoverflow.com/questions/6461209/how-to-round-up-to-the-nearest-10-or-100-or-x
  rounder <- function(x, round=10) ceiling(max(x+10^-9)/round + 1/round)*round
  d <- rounder(d, 10)
  
  # make the numbers look pretty
  prettynum <- function(i) formatC(round(i, 0), big.mark=",",format="f", drop0trailing = TRUE)
  d <- prettynum(d)

return(d)
  
}