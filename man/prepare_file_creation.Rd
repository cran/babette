% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prepare_file_creation.R
\name{prepare_file_creation}
\alias{prepare_file_creation}
\title{Internal function to prepare for 'BEAST2' creating files}
\usage{
prepare_file_creation(inference_model, beast2_options)
}
\arguments{
\item{inference_model}{a Bayesian phylogenetic inference model,
as returned by \link[beautier]{create_inference_model}}

\item{beast2_options}{'BEAST2'  options,
as can be created by \link[beastier]{create_beast2_options}}
}
\value{
Nothing.
}
\description{
The inference model and 'BEAST2' options contain paths that may point
to sub-sub-sub folders. Create those folders and test
if these folders can be written to
}
\examples{
# This example will fail on the CRAN
# r-oldrel-macos-x86_64 platform
if (rappdirs::app_dir()$os != "mac") {
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

  # For a test inference model, the files can be prepared
  inference_model <- create_test_inference_model()
  beast2_options <- create_beast2_options()
  prepare_file_creation(inference_model, beast2_options)

  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
}
}
