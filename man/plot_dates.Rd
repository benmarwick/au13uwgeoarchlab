\name{plot_dates}
\alias{plot_dates}
\title{Plot radiocarbon date data}
\usage{
  plot_dates(my_data, se = TRUE, ...)
}
\arguments{
  \item{my_data}{The data frame that resutled from running
  the get_data function}

  \item{se}{draw the standard error area in the plot?
  Default in TRUE. To turn off the shaded standard error
  area, use se=FALSE}
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

