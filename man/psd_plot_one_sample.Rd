\name{psd_plot_one_sample}
\alias{psd_plot_one_sample}
\title{Plots the particle size distribution of a single sample}
\usage{
  psd_plot_one_sample(my_data, sample, ...)
}
\arguments{
  \item{my_data}{the data resulting from the
  \code{\link{get_data}} function}

  \item{sample}{numeric, the sample ID that you want to
  plot}
}
\value{
  a plot of the particle size distribution of a sample
}
\description{
  Useful if you want to show two or three plots to compare
  a few samples.
}
\examples{
my_data <- get_data()
 psd_plot_one_sample(my_data, 1.5)
}
\seealso{
  \code{\link{get_data}}
}

