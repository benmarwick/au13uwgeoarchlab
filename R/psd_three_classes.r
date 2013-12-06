#' Summarizes the particle size data into sand-silt-clay
#' 
#' You don't need to run this function, it's automatically called by the functions
#' for plotting and statistical analysis. It just does a bit of rearranging and simplifying.
#' 
#' @param my_data the data resulting from the  \code{\link{get_data}} function
#' 
#' 
#' @return a data frame
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 

#'  
  

psd_three_classes <- function(my_data,  ...){
  
  # call preparation function 
  psd_t <- psd_prep(my_data)
  
  # plot of particle size distribution per sample
  require(reshape2)
  psd_m <- melt(psd_t, id.var = 'size')
  
  
  # combine variables into three groups: sand, silt and clay
  # using Wentworth classes...
  # sand: 2000 - 62.5 um
  # silt: 62.5 - 4 um
  # clay: < 4 um
  
  sand <- colSums(psd_t[ psd_t$size > 62.5 & psd_t$size < 2000, ] ) 
  silt <- colSums(psd_t[ psd_t$size >= 4 & psd_t$size <= 62.5, ] ) 
  clay <- colSums(psd_t[ psd_t$size >= 0 & psd_t$size < 4, ] )
  
  # combine into one data frame
  three_classes <- data.frame(CLAY = clay,
                              SILT = silt,
                              SAND = sand)
  
  # remove size row
  three_classes <- three_classes[-nrow(three_classes),]
  
  # clean up row names
  rownames(three_classes) <- as.numeric(unlist(regmatches(rownames(three_classes),gregexpr("[[:digit:]]+\\.*[[:digit:]]*",rownames(three_classes)))))
  
  # remove NAs
  three_classes <- na.omit(three_classes)
  
return(three_classes)
  
  
}