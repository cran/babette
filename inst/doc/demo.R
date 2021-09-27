## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----check_empty_cache_at_start, include = FALSE------------------------------
# This is only needed to pass the CRAN Windows build.
#
# This vignette is tested to clean up nicely on GitHub Actions
# and r-hub on Windows
#
unlink(
  dirname(beastier::get_beastier_tempfilename()),
  recursive = TRUE
)

beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()
# beastierinstall::clear_beautier_cache() ; beastierinstall::clear_beastier_cache() # nolint

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

## -----------------------------------------------------------------------------
inference_model <- create_test_inference_model()

## -----------------------------------------------------------------------------
beast2_options <- create_beast2_options(verbose = TRUE)

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco_sub.fas"),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  library(ggplot2)
  p <- ggplot(
    data = out$estimates,
    aes(x = Sample)
  )
  p + geom_line(aes(y = TreeHeight), color = "green")
  p + geom_line(aes(y = YuleModel), color = "red")
  p + geom_line(aes(y = birthRate), color = "blue")
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  traces <- remove_burn_ins(
    traces = out$estimates,
    burn_in_fraction = 0.2
  )
  esses <- t(
    calc_esses(
      traces,
      sample_interval = inference_model$mcmc$tracelog$log_every
    )
  )
  colnames(esses) <- "ESS"
  knitr::kable(esses)
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  sum_stats <- t(
    calc_summary_stats(
      traces$posterior,
      sample_interval = inference_model$mcmc$tracelog$log_every
    )
  )
  colnames(sum_stats) <- "Statistic"
  knitr::kable(sum_stats)
}

## ----fig.width=7, fig.height=7------------------------------------------------
if (is_beast2_installed()) {
  plot_densitree(out$anthus_aco_sub_trees, width = 2)
}

## ----check_empty_cache_at_end, include = FALSE--------------------------------
# This is only needed to pass the CRAN Windows build.
#
# This vignette is tested to clean up nicely on GitHub Actions
# and r-hub on Windows
#
unlink(
  dirname(beastier::get_beastier_tempfilename()),
  recursive = TRUE
)
beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()
# beastierinstall::clear_beautier_cache() ; beastierinstall::clear_beastier_cache() # nolint

