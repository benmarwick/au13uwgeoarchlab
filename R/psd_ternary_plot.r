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
  
  # data preparation function
  three_classes <- psd_three_classes(my_data)
  

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