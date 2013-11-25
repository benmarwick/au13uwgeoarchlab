\name{psd_strat_plot}
\alias{psd_strat_plot}
\title{Stratigraphic plot of sand-silt-clay percentages for all samples}
\usage{
  psd_strat_plot(my_data, cluster = TRUE, n = 3, ...)
}
\arguments{
  \item{my_data}{the data resulting from the
  \code{\link{get_data}} function}

  \item{cluster}{if TRUE, compute a coniss cluster analysis
  and add the results to the plot}

  \item{n}{the number of clusters to identify in the data.
  Default is three.}
}
\value{
  a stratigraphic plot
}
\description{
  Draws a stratigraphic plot of the three main sediment
  texture classes for a all samples
}
\examples{
my_data <- get_data()
 psd_strat_plot(my_data)
}
\seealso{
  \code{\link{get_data}}
}

