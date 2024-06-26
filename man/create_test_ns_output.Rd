% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_test_ns_output.R
\name{create_test_ns_output}
\alias{create_test_ns_output}
\title{Create NS testing output}
\usage{
create_test_ns_output()
}
\value{
a text of type character vector.
}
\description{
Create testing output similar to when running a 'BEAST2' run
with nested sampling
}
\examples{
beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

create_test_ns_output()

beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()
}
\seealso{
Use \link{parse_beast2_output_to_ns} to parse
this output to a Nested Sampling result.
See \link[beautier]{create_ns_mcmc} to see how to do a marginal
likelihood estimation using Nested Sampling.
}
\author{
Richèl J.C. Bilderbeek
}
