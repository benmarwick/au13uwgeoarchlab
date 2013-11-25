#' Plots the particle size distribution of a single sample
#' 
#' Useful if you want to show two or three plots to compare a few samples.  
#' 
#' @param my_data the data resulting from the  \code{\link{get_data}} function
#' 
#' @param sample numeric, the sample ID that you want to plot
#' 
#' @return a plot of the particle size distribution of a sample
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  psd_plot_one_sample(my_data, 1.5)
#'  
  

psd_plot_one_sample <- function(my_data, sample, ...){
  
  # call preparation function 
  psd_t <- psd_prep(my_data)
  
  # plot of particle size distribution per sample
  require(reshape2)
  psd_m <- melt(psd_t, id.var = 'size')
  
  # plot only one sample
  psd_m_1 <- psd_m[psd_m$variable == paste0("X",sample),] 
  xaxbreaks <-   c(4000, 2000, 1000, 500, 250, 125, 63, 31, 16, 8, 4, 2, 0.5, 0.12, 0.04)
  require(ggplot2)
x <-   ggplot(psd_m_1, aes(size, abs(value))) +
    scale_x_log10(breaks = xaxbreaks, labels = xaxbreaks) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))  +
    ylab("percentage mass") +
    xlab("Particle Size (um)") + 
    geom_vline(xintercept = c(62, 4), colour = 'grey70', size = 1) +
    xlab("Particle Size (um)") +   
    geom_text(aes(x=2,y=max(value),label = "Clay"),colour = 'grey60') +
    geom_text(aes(x=30,y=max(value),label = "Silt"),colour = 'grey60') +
    geom_text(aes(x=1900,y=max(value),label = "Sand"),colour = 'grey60') +
    geom_bar(stat="identity") +
    ggtitle(paste0("Particle size distribution for sample ",sample)) + 
    theme_minimal()
  
  
return (x)
  
}