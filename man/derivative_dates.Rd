\name{derivative_dates}
\alias{derivative_dates}
\title{Computes first derivative of the radiocarbon dates data}
\usage{
  derivative_dates(my_data, span = 0.75, ...)
}
\arguments{
  \item{my_data}{}

  \item{span}{the parameter α which controls the degree of
  smoothing for the loess interpolation. Default is 0.75.
  From stats::loess}
}
\value{
  The my_data data frame with one additional column, the
  'deriv' column. This contains the first order derivative
  of the dates.
}
\description{
  This function calculates the rate of age relative to
  depth below the surface. It is an estimate and
  visualization of sedimentation rates. It uses lowess
  interpolation to estimate a reasonable age, give the
  known ages of the deposit and then computes the first
  order derivative at each point. It assumes you have
  already got the data from the Google sheet.
}
\examples{
my_data <- get_data()
 my_data <- derivative_dates(my_data)
 # now plot the derivative with another variable in my_data
 biplot_with_correlation(my_data, 'deriv', 'Lithic_mass_g')
}
\seealso{
  \code{\link{get_data}} and \code{\link{interpolate_date}}
}

