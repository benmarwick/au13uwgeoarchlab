\name{biplot_with_correlation}
\alias{biplot_with_correlation}
\title{Plots a biplot of two variables and gives details about their correlation}
\usage{
  biplot_with_correlation(my_data, var1, var2, ...)
}
\arguments{
  \item{my_data}{string, the data resulting from the
  \code{\link{get_data}} function}

  \item{var1}{string, a variable in the data frame
  resulting from the \code{\link{get_data}} function}

  \item{var2}{string, another variable in the data frame
  resulting from the \code{\link{get_data}} function}
}
\value{
  a biplot and summary statistics of the correlation
  between the two variables
}
\description{
  Useful if you want to show how two variables interact.
  This function assumes you have already run the function
  \code{\link{get_data}}. The numbers on the axes are the
  minimum, lower-hinge, median, upper-hinge and maximum of
  the data. This is Tukey's five number summary. This plot
  has a very high data:ink ratio, without, I think, looking
  too ultra- minimalist.
}
\details{
  The function also calculates the correlation coeffient
  and displays it on the x-axis in the form of r = some
  number. This shows the probability value of the null
  hypothesis (that the computed correlation is due to
  random processes that we don't care about). This value
  will help us test the hypothesis that the overall slope
  of the linear regression is 0 (ie. there is no
  relationship between the two variables). A line with
  slope 0 (ie. r = 0 or very close to zero) is horizontal,
  which means that variable 1 does not depend on variable 2
  at all.

  A correlation value (r) is considered to be interesting
  only when the p value is less than 0.05 (or for some
  people, 0.01). This is just an arbitrary convention. if
  itt's greater. If the p-value is greater than 0.05, then
  the correlation is most likely due to chance and not
  suggestive of anything interesting. So before you get
  excited about a high r value, do check that you also have
  a sufficiently low p-value.
}
\examples{
my_data <- get_data()
 biplot_with_correlation(my_data, 'mean.pH', 'mean.Organic')
}
\seealso{
  \code{\link{get_data}}
}

