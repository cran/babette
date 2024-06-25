## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----check_empty_cache_at_start, include = FALSE------------------------------
beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

## -----------------------------------------------------------------------------
library(babette)

## -----------------------------------------------------------------------------
out_jc69 <- create_test_bbt_run_output()
out_jc69$ns$marg_log_lik <- c(-1.1)
out_jc69$ns$marg_log_lik_sd <- c(0.1)
out_gtr <- out_jc69

## -----------------------------------------------------------------------------
interpret_bayes_factor <- function(bayes_factor) {
  if (bayes_factor < 10^-2.0) {
    "decisive for GTR"
  } else if (bayes_factor < 10^-1.5) {
    "very strong for GTR"
  } else if (bayes_factor < 10^-1.0) {
    "strong for GTR"
  } else if (bayes_factor < 10^-0.5) {
    "substantial for GTR"
  } else if (bayes_factor < 10^0.0) {
    "barely worth mentioning for GTR"
  } else if (bayes_factor < 10^0.5) {
    "barely worth mentioning for JC69"
  } else if (bayes_factor < 10^1.0) {
    "substantial for JC69"
  } else if (bayes_factor < 10^1.5) {
    "strong for JC69"
  } else if (bayes_factor < 10^2.0) {
    "very strong for JC69"
  } else {
    "decisive for JC69"
  }
}
# Should all be TRUE
interpret_bayes_factor(1 / 123.0) == "decisive for GTR"
interpret_bayes_factor(1 / 85.0) == "very strong for GTR"
interpret_bayes_factor(1 / 12.5) == "strong for GTR"
interpret_bayes_factor(1 / 8.5) == "substantial for GTR"
interpret_bayes_factor(1 / 1.5) == "barely worth mentioning for GTR"
interpret_bayes_factor(0.99) == "barely worth mentioning for GTR"
interpret_bayes_factor(1.01) == "barely worth mentioning for JC69"
interpret_bayes_factor(1.5) == "barely worth mentioning for JC69"
interpret_bayes_factor(8.5) == "substantial for JC69"
interpret_bayes_factor(12.5) == "strong for JC69"
interpret_bayes_factor(85.0) == "very strong for JC69"
interpret_bayes_factor(123.0) == "decisive for JC69"

## ----fig.width=7--------------------------------------------------------------
fasta_filename <- get_babette_path("anthus_aco_sub.fas")
image(ape::read.FASTA(fasta_filename))

## -----------------------------------------------------------------------------
mcmc <- beautier::create_test_ns_mcmc()

## -----------------------------------------------------------------------------
if (is_beast2_installed() && is_beast2_pkg_installed("NS")) {
  inference_model <- create_inference_model(
    site_model = beautier::create_jc69_site_model(),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options(
    beast2_path = beastier::get_default_beast2_bin_path()
  )
  out_jc69 <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  inference_model <- create_inference_model(
    site_model = beautier::create_gtr_site_model(),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options(
    beast2_path = beastier::get_default_beast2_bin_path()
  )
  out_gtr <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## -----------------------------------------------------------------------------
if (is_beast2_installed() && is_beast2_pkg_installed("NS")) {
  df <- data.frame(
    model = c("JC69", "GTR"),
    mar_log_lik = c(out_jc69$ns$marg_log_lik, out_gtr$ns$marg_log_lik),
    mar_log_lik_sd = c(out_jc69$ns$marg_log_lik_sd, out_gtr$ns$marg_log_lik_sd)
  )
  knitr::kable(df)
}

## -----------------------------------------------------------------------------
if (is_beast2_installed() && is_beast2_pkg_installed("NS")) {
  bayes_factor <- exp(out_jc69$ns$marg_log_lik) / exp(out_gtr$ns$marg_log_lik)
  print(interpret_bayes_factor(bayes_factor))
}

## ----check_empty_cache_at_end, include = FALSE--------------------------------
beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

