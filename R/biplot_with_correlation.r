#' Plots a biplot of two variables and gives details about their correlation
#' 
#' Useful if you want to show how two variables interact. This function assumes 
#' you have already run the function \code{\link{get_data}}. The numbers on the 
#' axes are the minimum, lower-hinge, median, upper-hinge and maximum of the 
#' data. This is Tukey's five number summary. This plot has a very high data:ink
#' ratio, without, I think, looking too ultra- minimalist.
#' 
#' The function also calculates the correlation coeffient and displays it on the 
#' x-axis in the form of r = some number. This shows the probability value 
#' of the null hypothesis (that the computed correlation is due to random processes 
#' that we don't care about). This value will help us test the hypothesis 
#' that the overall slope of the linear regression is 0 (ie. there is no 
#' relationship between the two variables). A line with slope 0 (ie. r = 0 or 
#' very close to zero) is horizontal, which means that variable 1 does not 
#' depend on variable 2 at all. 
#' 
#' A correlation value (r) is considered to be interesting only when the p value
#' is less than 0.05 (or for some people, 0.01). This is just an arbitrary convention.
#' if itt's greater. If the p-value is greater than 0.05, then the correlation 
#' is most likely due to chance and not suggestive of anything interesting. So 
#' before you get excited about a high r value, do check that you also have a 
#' sufficiently low p-value. 
#' 
#' @param my_data string, the data resulting from the  \code{\link{get_data}} function
#' 
#' @param var1 string, a variable in the data frame resulting from the 
#' \code{\link{get_data}} function
#' 
#' @param var2 string, another variable in the data frame resulting from the 
#' \code{\link{get_data}} function 
#' 
#' @return a biplot and summary statistics of the correlation between the two variables
#' 
#' @seealso \code{\link{get_data}}
#' 
#' @export
#' 
#' @examples
#'  my_data <- get_data()
#'  biplot_with_correlation(my_data, 'mean.pH', 'mean.Organic')
#'  
  

biplot_with_correlation <- function(my_data, var1, var2, ...){
  
  # only get rows with geoarch dat
  
  my_data <- my_data[!is.na(my_data$Sample.ID),]
  
  x <- my_data[,names(my_data) %in% var1]
  y <- my_data[,names(my_data) %in% var2]
  df <- data.frame(x = x, y = y, Sample.ID = my_data$Sample.ID)
  # names(df) <- c(var1, var2, "Sample.ID")
  
  require(ggplot2)
  ggplot(df, aes(x, y, label = Sample.ID)) +        
    # make the basic plot object
    scale_x_continuous(limit=c(min(x),
                               max(x)), 
                       breaks=round(fivenum(x),1)) +     
    # set the locations of the x-axis labels
    xlab(paste(var1," (r = ", round(cor(x,y),4),", p-value = ", 
               round(anova(lm(x~y
               ))$'Pr(>F)'[1],5),")",sep="")) +      
    # paste in the r and p values with the axis label
    scale_y_continuous(limit=c(min(y),
                               max(y)),
                       breaks=round(fivenum(y),1)) +     
    # set the locations of the y-axis labels
    ylab(var2) +                   
    geom_text() + # specify that the data points are the sample names
    geom_rug(size=0.1) +   # specify that we want the rug plot
    geom_smooth(aes(group = 1), method="lm", fill="grey70", alpha=0.05,
                colour="grey50") + 
    # specify a line of best fit calculated by a linear model
    # fill is the colour of the standard error area
    # with fill set it to "white" it wont show at all
    # colour is the colour of the line
    theme(panel.background = element_blank(),               
          # suppress default background
          panel.grid.major = element_blank(),              
          # suppress default major gridlines
          panel.grid.minor = element_blank(),                         
         # suppress default minor gridlines
         axis.ticks = element_blank(),                    
         # suppress tick marks
         axis.title.x=element_text(size=15),              
         # increase axis title size slightly  
         axis.title.y=element_text(size=15, angle=90),    
         # increase axis title size slightly and rotate
         axis.text.x=element_text(size=12),              
         # increase size of numbers on x-axis
         axis.text.y=element_text(size=12))            
  # increase size of numbers on y-axis
    
  
  
  
}