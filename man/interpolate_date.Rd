\name{interpolate_date}
\alias{interpolate_date}
\title{Interpolate a radiocarbon date from a given depth below the surface}
\usage{
  interpolate_date(my_data, depth_in_m, ...)
}
\arguments{
  \item{my_data}{}
}
\value{
  An age estimate for the depth provided
}
\description{
  This function calculates the age at a specific depth
  below the surface. It uses lowess interpolation to
  estimate a reasonable age, give the known ages of the
  deposit. It assumes you have already got the data from
  the Google sheet.
}
\details{
  Lowess works by fitting a weighted linear model to a
  local subset of the data. So we cannot interpolate ages
  for depths less than the shallowest date or greater than
  the deepest date, where we have no date data. To compute
  dates for those depths we need to extrapolate. Reliable
  non-linear statistical methods of extrapolation are hard
  to find (I don't think there are any), so we're better
  off just eye-balling the values from a depth-age plot. If
  you try to compute an age for a depth outside of the
  range of dated samples this function will return NA
}
\examples{
my_data <- get_data()
 my_date_plot <- plot_dates(my_data)
 interpolate_date(my_data, 1.20) # where 1.20 is the depth in meters
}
\seealso{
  \code{\link{get_data}}
}

