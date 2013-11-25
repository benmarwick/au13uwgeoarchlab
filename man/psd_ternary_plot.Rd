\name{psd_ternary_plot}
\alias{psd_ternary_plot}
\title{Displays all the samples on a ternary plot}
\usage{
  psd_ternary_plot(my_data, cex = 0.75, ...)
}
\arguments{
  \item{my_data}{the data resulting from the
  \code{\link{get_data}} function}

  \item{cex}{number indicating the amount by which plotting
  text should be scaled relative to the default. Default
  here is 0.75.}
}
\value{
  a ternary sediment texture plot
}
\description{
  Shows the sand-silt-clay percentages on a triangular
  graph
}
\examples{
my_data <- get_data()
 psd_ternary_plot(my_data)
}
\seealso{
  \code{\link{get_data}}
}

