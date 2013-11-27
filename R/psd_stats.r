#' Summary statistics for particle size distributions 
#' 
#' Computes summary statistics for particle size distributions 
#' 
#' @param my_data the data resulting from the  \code{\link{get_data}} function
#' 
#' @param plot logical. If TRUE, draws a plot. If FALSE you just get the data frame.
#' Default is TRUE
#' 
#' @param n integer. The number of clusters to identify in the data. Default is three. 
#' 
#' @return a data frame and if plot = TRUE, also a stratigraphic plot
#' 
#' @seealso \code{\link{get_data}} 
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  my_psd_stats <- psd_stats(my_data, plot = TRUE) # draws plot
#'  my_psd_stats <- psd_stats(my_data, plot = FALSE) # doesn't draw plot
#'  
  

psd_stats <- function(my_data, plot = TRUE, n = 3, ...){
  
  # call preparation function 
  psd_t <- psd_prep(my_data)
  # order 
  psd_t <- psd_t[ order(-as.numeric(psd_t$size)), ]
  # get size as a separate vector
  size <- psd_t$size
  # remove size col
  psd_t <- psd_t[, - which(names(psd_t) %in% 'size')]
  # add last size class of zero
  psd_t <- rbind(psd_t, c(rep(0, ncol(psd_t))))
  # add size classes as row name
  rownames(psd_t) <- round(c(size,0),5)
  # omit empty samples (ie. delete cols with NA)
  psd_t <- psd_t[ , colSums(is.na(psd_t)) == 0]
  

  
  # only allowed these sizes to compute the stats
  gransize <- c(25000, 20000, 16000, 12500, 10000, 8000, 
                6300, 5000, 4000, 2500, 2000, 1600, 1250, 1000, 800, 
                630, 500, 400, 315, 250, 200, 160, 125, 100, 80, 
                63, 50, 40, 0)
  
  
  # Interpolate from data to determine values at allowed sizes
  revsize <- as.numeric(rownames(psd_t))
  # compute loess function for each sample
  loes <- lapply(1:ncol(psd_t), function(x) loess(psd_t[,x] ~ revsize, psd_t))
  # generate predictions of values at allowed sizes for each sample
  predi <- lapply(loes, function(i) predict(i, data.frame(revsize = gransize[gransize < 2000])))
  
  # Interpolate from data to determine values at allowed sizes

  # make data frame
  interp_table <- data.frame(predi)
  # give row names
  row.names(interp_table) <- gransize[gransize < 2000]
  # remove column of sizes
  # interp_table <- interp_table[, -which(names(interp_table) == 'revsize'),  drop=FALSE]
  # change -ve numbers to zero
  interp_table[interp_table < 0 ] <- 0
  # give column names back for sample IDs
  colnames(interp_table) <- as.numeric(unlist(regmatches( colnames(psd_t),gregexpr("[[:digit:]]+\\.*[[:digit:]]*", colnames(psd_t)))))
    

  
  # compute particle size stats
  
  # This next line will make a table of commonly used 
  # grain size stats. We want mean, sd and skewness.
  
  # Note that when modes is set to TRUE, 
  # then you have to use mouse to click on the modal 
  # point for each plot, then press escape to move on to 
  # the next sample's plot. Currently I've set the function
  # to modes=FALSE so you don't have to worry about that.
  # After the last sample all the data will be generated. 
  # Definitions of the  terms used can be found here
  # http://cran.r-project.org/web/packages/G2Sd/G2Sd.pdf or by 
  # typing ?granstat at the R prompt
  #require(G2Sd)
  sink(tempfile())  # suppress cat messages
  stats <- as.data.frame(t(granstat(interp_table, statistic="all", aggr=TRUE, modes=FALSE)))
  sink() # suppress cat messages

  # subset table 
  stats <- stats[,c('mean.arith.um', 
                    'sd.arith.um' ,
                    'skewness.arith.um', 
                    'kurtosis.arith.um')]

  
  # convert to data frame of numeric type
  stats <- data.frame(apply(stats, 2, function(x) as.numeric(as.character(x))))
  
  # give sensible row names
  rownames(stats) <- as.numeric(unlist(regmatches( colnames(psd_t),gregexpr("[[:digit:]]+\\.*[[:digit:]]*", colnames(psd_t)))))

  
  if(plot){

  #### slightly more fancy plot: with dendrogram showing groups of similar samples
require(rioja)
  # ?chclust # to get information how the clustering is done
  # add a dendrogram from constrained cluster analysis
  # coniss is a stratigraphically constrained cluster analysis by
  # method of incremental sum of squares
  diss <- dist(stats)
  clust <- chclust(diss, method = "coniss")
  # broken stick model to suggest significant zones, 3?
  # bstick(clust)
  # plot with clusters
  # par(ask = T) # prompt for user
  x <- strat.plot(stats,
                  yvar = as.numeric(row.names(stats)),
                  y.rev = TRUE,
                  ylabel = "Depth below surface (m)",
                  col.line = "black", # try others that you like
                  lwd.line = 1,    # ditto
                  clust = clust,
  )
  # add lines to indicate clusters, leave out if it looks odd
  addClustZone(x, clust, n, col = "red")
  } else { 
    
    x <- 0 # do nothing
  
  }
  
  
  return(stats)
  
}