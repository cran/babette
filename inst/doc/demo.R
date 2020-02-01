## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

## -----------------------------------------------------------------------------
inference_model <- create_test_inference_model()
inference_model$mcmc$tracelog$filename <- tempfile()
inference_model$mcmc$treelog$filename <- tempfile()
inference_model$mcmc$screenlog$filename <- tempfile()
mcmc <- inference_model$mcmc
sample_interval <- mcmc$tracelog$log_every

## -----------------------------------------------------------------------------
beast2_options <- create_beast2_options(
  input_filename = tempfile(),
  output_state_filename = tempfile()
)

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  out <- bbt_run_from_model(
    fasta_filename = get_babette_path("anthus_aco_sub.fas"),
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
  esses <- t(calc_esses(traces, sample_interval = sample_interval))
  colnames(esses) <- "ESS"
  knitr::kable(esses)
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  sum_stats <- t(calc_summary_stats(traces$posterior, sample_interval = sample_interval))
  colnames(sum_stats) <- "Statistic"
  knitr::kable(sum_stats)
}

## ----fig.width=7, fig.height=7------------------------------------------------
if (is_beast2_installed()) {
  plot_densitree(out$anthus_aco_sub_trees, width = 2)
}

