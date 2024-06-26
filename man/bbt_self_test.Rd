% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bbt_self_test.R
\name{bbt_self_test}
\alias{bbt_self_test}
\title{Do a self test to verify \link{babette} that works correctly.}
\usage{
bbt_self_test(beast2_options = beastier::create_beast2_options())
}
\arguments{
\item{beast2_options}{'BEAST2'  options,
as can be created by \link[beastier]{create_beast2_options}}
}
\value{
Nothing. Will raise an exception if something is wrong.
}
\description{
Do a self test to verify \link{babette} that works correctly.
}
\examples{
if (beautier::is_on_ci() && is_beast2_installed()) {
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

  bbt_self_test()

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
}
}
\author{
Richèl J.C. Bilderbeek
}
