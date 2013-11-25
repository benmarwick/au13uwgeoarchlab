\name{strat_plot_key_variables}
\alias{strat_plot_key_variables}
\title{Draw a stratigraphic plot of key geoarchaeological variables}
\usage{
  strat_plot_key_variables(my_data, list_of_variables,
    cluster = TRUE, n = 3, ...)
}
\arguments{
  \item{my_data}{the data resulting from the
  \code{\link{get_data}} function}

  \item{list_of_variables}{a list of variables in
  \code{my_data} which you can get by typing
  \code{names(my_data)}}

  \item{cluster}{if TRUE, compute a coniss cluster analysis
  and add the results to the plot}

  \item{n}{the number of clusters to identify in the data.
  If you're plotting with clusters, you should take careful
  note of what number of groups is indicated by the 'elbow'
  in the first plot produced by this function. That will be
  the n value. Default is three.}
}
\value{
  a stratigraphic plot
}
\description{
  This function draws a stratigraphic plot of key
  geoarchaeological variables. It assumes you have already
  got the data from the Google sheet.
}
\examples{
my_data <- get_data()
 my_date_plot <- plot_dates(my_data)
 strat_plot_key_variables(my_data, c('Sample.ID',
                                     'mean.pH',
                                     'mean.EC',
                                     'mean.MS.LF',
                                     'mean.MS.FD',
                                     'mean.Organic',
                                     'mean.CaCO3'),
                                     cluster = TRUE,
                                     n = 3)
}
\seealso{
  \code{\link{get_data}}
}

