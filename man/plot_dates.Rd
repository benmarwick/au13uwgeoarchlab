\name{plot_dates}
\alias{plot_dates}
\title{Plot radiocarbon date data}
\usage{
  plot_dates(my_data, ...)
}
\arguments{
  \item{my_data}{The data frame that resutled from running
  the get_data function}
}
\value{
  a plot
}
\description{
  This function draws a depth-age plot from radiocarbon
  date data. You must already have connected to the Google
  sheet and imported the data into your R environment
  before running this function
}
\examples{
my_data <- get_data()
 plot_dates(my_data)
}
\seealso{
  \code{\link{get_data}}
}

