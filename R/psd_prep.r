#' Prepares the particle size data for analysis and plotting
#' 
#' You don't need to run this function, it's automatically called by the functions
#' for plotting and statistical analysis. It just does a bit of rearranging and simplifying. 
#' 
#' @param my_data the data resulting from the  \code{\link{get_data}} function
#' 
#' @return a data table of particle size data
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 


psd_prep <- function(my_data, ...){
  
#   # get geoarch table
#   my_data <- my_data[[1]]
  
  # subset just the sieve and pipette data for geoarch samples
  psd <- my_data[!is.na(my_data$Sample.ID), names(my_data) %in% c("Sample.ID",
                                   "percent.mass.of.total.used.for.pipetting.in.5.6.mm.screen..g.",                                  
                                   "percent.mass.of.total.used.for.pipetting.in.4.75.mm.screen..g.",                                 
                                   "percent.mass.of.total.used.for.pipetting.in.2.8.mm.screen..g.",                                  
                                   "percent.mass.of.total.used.for.pipetting.2.33.mm.screen..g.",                                    
                                   "percent.mass.of.total.used.for.pipetting.in.2.00.mm.screen..g.",                                 
                                   "percent.mass.of.total.used.for.pipetting.in.1.18.mm.screen..g." ,                                
                                   "percent.mass.of.total.used.for.pipetting.in.1.00.mm.screen..g."  ,                               
                                   "percent.mass.of.total.used.for.pipetting.in.800.um.screen..g."    ,                              
                                   "percent.mass.of.total.used.for.pipetting.in.710.um.screen..g."     ,                             
                                   "percent.mass.of.total.used.for.pipetting.in.500.um.screen..g.",                                  
                                   "percent.mass.of.total.used.for.pipetting.in.425.um.screen..g." ,                                 
                                   "percent.mass.of.total.used.for.pipetting.in.355.um.screen..g."  ,                                
                                   "percent.mass.of.total.used.for.pipetting.in.250.um.screen..g."   ,                               
                                   "percent.mass.of.total.used.for.pipetting.in.125.um.screen..g."    ,                              
                                   "percent.mass.of.fraction.62.5...31.3.um",                                                        
                                   "percent.mass.of.fraction.31.3...15.6.um" ,                                                       
                                   "percent.mass.of.fraction.15.6...7.8.um"   ,                                                      
                                   "percent.mass.of.fraction..7.8...3.9.um"    ,                                                     
                                   "percent.mass.of.fraction.3.9...1.9.um"      ,                                                    
                                   "percent.mass.of.fraction.finer.than.2.um")]
  
  
  # replace google docs' '#DIV/0!' with something that R understands
  psd[ psd == '#DIV/0!']  = NA
  # convert data types from character to numeric so we 
  # can do calculations with it, do this as a batch
  psd[,1:(length(psd))] <- apply(psd[,1:(length(psd))], 2, function(x) as.numeric(as.character(x)))
  
  # get sizes from column names
  # psd_size <- as.numeric(unlist(regmatches(names(psd),gregexpr("[[:digit:]]+\\.*[[:digit:]]*",names(psd)))))
  # standardise units to um
  # psd_size <- ifelse(psd_size > 50,  psd_size, psd_size * 1000)
  psd_size <- c(62.5, 31.3, 15.6, 7.8, 3.9, 2, 5600, 4750, 2800, 
                2300, 2000, 1180, 1000, 800, 710, 500, 425, 355, 250, 125)
  
  # tranpose dataframe so we can have a column of size
  psd_t <- data.frame(t(psd))
  colnames(psd_t) <- psd$Sample.ID
  psd_t  <- data.frame(psd_t[-1,])
  psd_t$size <- psd_size
  
return (psd_t)
  
}