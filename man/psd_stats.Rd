\name{psd_stats}
\alias{psd_stats}
\title{Summary statistics for particle size distributions}
\usage{
  psd_stats(my_data, plot = TRUE, n = 3, ...)
}
\arguments{
  \item{my_data}{the data resulting from the
  \code{\link{get_data}} function}

  \item{plot}{logical. If TRUE, draws a plot. If FALSE you
  just get the data frame. Default is TRUE}

  \item{n}{integer. The number of clusters to identify in
  the data. Default is three.}
}
\value{
  a data frame and if plot = TRUE, also a stratigraphic
  plot
}
\description{
  Computes summary statistics for particle size
  distributions
}
\examples{
my_data <- get_data()
 my_psd_stats <- psd_stats(my_data, plot = TRUE) # draws plot
 my_psd_stats <- psd_stats(my_data, plot = FALSE) # doesn't draw plot
}
\seealso{
  \code{\link{get_data}}
}

