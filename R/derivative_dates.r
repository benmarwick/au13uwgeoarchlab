#' Computes first derivative of the radiocarbon dates data 
#' 
#' This function calculates the rate of age relative to depth below the surface. 
#' It is an estimate and visualization of sedimentation rates. It uses lowess 
#' interpolation to estimate a reasonable age, give the known
#' ages of the deposit and then computes the first order derivative at each point.
#' It assumes you have already got the data from the Google sheet. 
#' 
#' @param my_data 
#' 
#' @param span the parameter α which controls the degree of smoothing for the loess interpolation. Default is 0.75. From stats::loess 
#' 
#' @return The my_data data frame with one additional column, the 'deriv' column. 
#' This contains the first order derivative of the dates.
#' 
#' @seealso \code{\link{get_data}} and \code{\link{interpolate_date}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  my_data <- derivative_dates(my_data)
#'  # now plot the derivative with another variable in my_data
#'  biplot_with_correlation(my_data, 'deriv', 'Lithic_mass_g')
#'  
  

derivative_dates <- function(my_data,  span = 0.75, ...){
  
  # start as for interpolate_date
  
  dates <- na.omit(my_data[, c(
    'DirectAMS.code',
    'Submitter.ID',
    'OxCal.median',
    'OxCal.sigma')])
  
  # remove outlier
  dates <- dates[!dates$OxCal.median == 4071, ]
  
  # simplify data
  # get spit number from 'Submitter.ID' field
  dates$spit <- as.numeric(gsub("[^[:digit:]]", "", dates$Submitter.ID))
  # we don't yet have the spit data to compute exact depths of the spits, so
  # we'll approximate for now
  dates$depth <- (dates$spit * 5)/100 # each spit was nominally 5 cm thick
  # Compute values along loess curve to get ages for specific depths below the
  # surface (ie. ages for each sediment sample)
  # span <- 0.75 # this has a big influence on the shape of the curve, experiment with it!
  cal.date.lo <- loess(OxCal.median ~ depth, dates, span = span)
  cal.date.pr <- predict(cal.date.lo, data.frame(depth = seq(0, max(dates$depth), 0.01)))
  cal.date.pr <- data.frame(age = unname(cal.date.pr), depth = as.numeric(names(cal.date.pr)))
  
  cal.date.pr <- na.omit(cal.date.pr)
  
  # crude computation of first derivative
  
  cal.date.pr$deriv <- c(0, diff(cal.date.pr$age) / diff(cal.date.pr$depth))
  
  # align with depths of sediment samples for biplots
  cal.date.pr$depthm <- cal.date.pr$depth/100
  
  cal.date.pr <- cal.date.pr[cal.date.pr$depthm %in% my_data$Sample.ID, ]
  
  # we are a few data points short at either end, so pad with zeros
  # which ones are we missing?
  rows <- my_data$Sample.ID[!(my_data$Sample.ID %in% cal.date.pr$depthm)]
  # get them in as rows 
  for(i in 1:length(rows)){
  cal.date.pr[nrow(cal.date.pr)+1, ]$depthm <- rows[i]
  }
  # and put in order of Sample.ID
  cal.date.pr <- cal.date.pr[with(cal.date.pr, order(depthm)), ]
  
  # extract just deriv vector
  d <- cal.date.pr$deriv
  
  # attach back onto my_data
  my_data$deriv <- d


return(my_data)
  
}