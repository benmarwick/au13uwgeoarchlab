#' Draw a stratigraphic plot of key geoarchaeological variables
#' 
#' This function draws a stratigraphic plot of key geoarchaeological variables.
#' It assumes you have already got the data from the Google sheet. 
#' 
#' @param my_data the data resulting from the  \code{\link{get_data}} function
#' @param list_of_variables a list of variables in \code{my_data} which you can 
#' get by typing \code{names(my_data)}
#' @param cluster if TRUE, compute a coniss cluster analysis and add the results
#' to the plot
#' @param n the number of clusters to identify in the data. If you're plotting 
#' with clusters, you should take careful note of what number of groups is 
#' indicated by the 'elbow' in the first plot produced by this function. That will
#' be the n value. Default is three.
#' 
#' @return a stratigraphic plot
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  my_date_plot <- plot_dates(my_data)
#'  strat_plot_key_variables(my_data, c('Sample.ID',
#'                                      'mean.pH', 
#'                                      'mean.EC',
#'                                      'mean.MS.LF',
#'                                      'mean.MS.FD',
#'                                      'mean.Organic',
#'                                      'mean.CaCO3'),
#'                                      cluster = TRUE, 
#'                                      n = 3)

#'  
  

strat_plot_key_variables <- function(my_data, list_of_variables, cluster = TRUE, n = 3, ...){

  
  # only get rows with geoarch dat
  
  my_data <- my_data[!is.na(my_data$Sample.ID),]
  
  
# subset key variables
  subs <- my_data[ ,colnames(my_data) %in% list_of_variables]
  
  
  # replace google docs' '#DIV/0!' with something that R understands
  subs[ subs == '#DIV/0!']  = NA
  # convert data types from character to numeric so we 
  # can do calculations with it, do this as a batch
  subs[,1:(length(subs)-1)] <- apply(subs[,1:(length(subs))-1], 2, function(x) as.numeric(as.character(x)))
  
if(cluster){
  
  #### slightly more fancy plot ################
  require(rioja) # load library
  # with dendrogram showing groups of similar samples
  # ?chclust # to get information how the clustering is done
  # We will add a dendrogram from constrained cluster analysis
  # to help identify groups of similar samples. We might conclude
  # that similar samples represent similar environments of deposition
  
  # We'll use 'coniss', a stratigraphically constrained cluster 
  # analysis by method of incremental sum of squares
  diss <- dist(subs[,-1])
  clust <- chclust(diss, method = "coniss")
  # broken stick model to suggest significant zones, 3?
  # bstick(clust) # look for a sharp elbow, that's the ideal number of clusters
  
  # Now, plot with clusters, you might want to include this one in your report
  # par(ask=T)  # ask the user for input
  x <- strat.plot(subs[,-1],
                  yvar = subs$Sample.ID, 
                  y.rev = TRUE, 
                  ylabel = "Depth below surface (m)", 
                  col.line = "black", # try others that you like
                  lwd.line = 1,    # ditto
                  clust = clust,
                  ...
                  )
  # add lines to indicate clusters, leave out if it looks odd
  addClustZone(x, clust, n, col = "red")
  

} else {
  
  require(rioja) 
  x <-   strat.plot(subs[,-1],
                    yvar = subs$Sample.ID, 
                    y.rev = TRUE, 
                    ylabel = "Depth below surface (m)", 
                    col.line = "black", # try others that you like
                    lwd.line = 1,
                    ...)
  

  
}


  
}