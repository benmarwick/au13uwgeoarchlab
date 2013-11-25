\name{interpolate_dates}
\alias{interpolate_dates}
\title{Interpolate a radiocarbon date from a given depth below the surface}
\usage{
  interpolate_dates(my_data, depth_in_m, ...)
}
\arguments{
  \item{my_data}{}
}
\value{
  An age estimate for the depth provided
}
\description{
  This function calculates the age at a specific depth
  below the surface. It uses loess interpolation to
  estimate a reasonable age, give the known ages of the
  deposit. It assumes you have already got the data from
  the Google sheet.
}
\examples{
my_data <- get_data()
 my_date_plot <- plot_dates(my_data)
 interpolate_dates(my_data, 1.20) # where 1.20 is the depth in meters
}
\seealso{
  \code{\link{get_data}}
}

