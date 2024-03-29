% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_densitree.R
\name{plot_densitree}
\alias{plot_densitree}
\title{Draw multiple trees on top of one another.}
\usage{
plot_densitree(phylos, ...)
}
\arguments{
\item{phylos}{one or more phylogenies, must be of class \code{multiPhylo}}

\item{...}{options to be passed to \code{phangorn}'s
\link[phangorn]{densiTree} function}
}
\value{
nothing. Will produce a plot.
}
\description{
Draw multiple trees on top of one another.
}
\examples{
if (beautier::is_on_ci() && is_beast2_installed()) {
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()

  inference_model <- create_test_inference_model()
  beast2_options <- create_beast2_options()

   out <- bbt_run_from_model(
    get_babette_path("anthus_aco.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )

  plot_densitree(out$anthus_aco_trees)

  # Clean up temporary files created by babette
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  beastier::remove_beaustier_folders()
  beastier::check_empty_beaustier_folders()
}
}
\author{
Richèl J.C. Bilderbeek
}
