#' Displays all the samples on a ternary plot
#' 
#' Shows the sand-silt-clay percentages on a triangular graph  
#' 
#' @param my_data the data resulting from the  \code{\link{get_data}} function
#' 
#' @param cex number indicating the amount by which plotting text should be 
#' scaled relative to the default. Default here is 0.75. 
#' 
#' @return a ternary sediment texture plot
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  psd_ternary_plot(my_data)
#'  
  

psd_ternary_plot <- function(my_data, cex = 0.75, ...){
  
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
  
  sand <- colSums(psd_t[ psd_t$size >= 62.5 & psd_t$size < 2000, ] ) 
  silt <- colSums(psd_t[ psd_t$size >= 4 & psd_t$size < 62.5, ] ) 
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
  
  # plot samples in ternary plot
  # see here for more details: 
  # http://cran.r-project.org/web/packages/soiltexture/vignettes/soiltexture_vignette.pdf
  # code for these functions comes from soiltexture.R that I pulled out of the
  # package soiltexture. That package was too buggy to require here. 
  # dev.off() # clear plotting area
  
  # draw triangle with samples plotted
  # Display the USDA texture triangle:
  geo <- TT.plot(class.sys="USDA.TT", 
                 cex.main = cex, # these are font sizes, adjust as you like
                 cex.axis = cex,
                 cex.lab = cex)
  # Display the text
TT.text(
    tri.data = abs(three_classes),
    geo = geo,
    labels =  rownames(three_classes),
    font = 2,
    col = "blue", 
    tri.sum.tst = FALSE,
    cex = cex # size of point labels, feel free to adjust
  ) #
  
  
}