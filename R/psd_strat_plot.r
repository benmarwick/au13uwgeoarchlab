#' Stratigraphic plot of sand-silt-clay percentages for all samples
#' 
#' Draws a stratigraphic plot of the three main sediment texture classes for a
#' all samples
#' 
#' @param my_data the data resulting from the  \code{\link{get_data}} function
#' 
#' @param cluster if TRUE, compute a coniss cluster analysis and add the results
#' to the plot
#' 
#' @param n the number of clusters to identify in the data. Default is three.
#' 
#' @return a stratigraphic plot
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  psd_strat_plot(my_data)
#'  
  

psd_strat_plot <-  function(my_data,  cluster = TRUE, n = 3, ...){
  
  # call three classes function
  three_classes <- psd_three_classes(my_data)
    
  # load library for stratigraphic plot 
  require(rioja)
  # change col names to be more pretty
  names(three_classes) <- tolower(names(three_classes))
  # put cols in a logical order
  three_classes <- three_classes[c("sand", "silt", "clay")]
  # dev.off() # clear plotting area
  
  if(cluster) {
    
    #### slightly more fancy plot: with dendrogram showing groups of similar samples
    # ?chclust # to get information how the clustering is done
    # add a dendrogram from constrained cluster analysis
    # coniss is a stratigraphically constrained cluster analysis by
    # method of incremental sum of squares
    diss <- dist(three_classes)
    clust <- chclust(diss, method = "coniss")
    # broken stick model to suggest significant zones, 3?
    # bstick(clust)
    # plot with clusters
    # par(ask = T) # prompt for user
    x <- strat.plot(three_classes,
                    yvar = as.numeric(row.names(three_classes)),
                    y.rev = TRUE,
                    ylabel = "Depth below surface (m)",
                    col.line = "black", # try others that you like
                    lwd.line = 1,    # ditto
                    clust = clust,
    )
    # add lines to indicate clusters, leave out if it looks odd
    addClustZone(x, clust, n, col = "red")
    
    
    
    
    
  } else {
    
    
 x <-  strat.plot(three_classes,
             yvar = as.numeric(row.names(three_classes)), 
             y.rev = TRUE, 
             ylabel = "Depth below surface (m)", 
             col.line = "black", # try others that you like
             lwd.line = 1,
             scale.percent=TRUE)
  
  }
 
 #  dev.off() # clear that plot    
  
}