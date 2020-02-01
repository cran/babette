## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_babette-------------------------------------------------------------
library(babette)

## -----------------------------------------------------------------------------
fasta_filename <- get_babette_path("anthus_aco_sub.fas")
library(testthat)
expect_true(file.exists(fasta_filename))

## -----------------------------------------------------------------------------
inference_model <- create_test_inference_model()
names(inference_model)

## -----------------------------------------------------------------------------
print(inference_model$mcmc$chain_length)

## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  out <- bbt_run_from_model(
   fasta_filename = fasta_filename,
   inference_model = inference_model
  )
}

## -----------------------------------------------------------------------------
inference_model <- create_test_inference_model(
  site_model = create_jc69_site_model()
)

## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  out <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model
  )
}

## -----------------------------------------------------------------------------
inference_model <- create_test_inference_model(
  clock_model = create_strict_clock_model()
)

## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  out <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model
  )
}

## -----------------------------------------------------------------------------
inference_model <- create_test_inference_model(
  tree_prior = create_yule_tree_prior()
)

## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  out <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model
  )
}

## -----------------------------------------------------------------------------
mrca_prior <- create_mrca_prior(
  alignment_id = get_alignment_id(fasta_filename = fasta_filename), 
  taxa_names = get_taxa_names(filename = fasta_filename)[1:2],
  is_monophyletic = TRUE
)

## -----------------------------------------------------------------------------
mrca_distr <- create_normal_distr(
  mean = 15.0, 
  sigma = 1.0
)

## -----------------------------------------------------------------------------
mrca_prior <- create_mrca_prior(
  alignment_id = get_alignment_id(fasta_filename = fasta_filename), 
  taxa_names = get_taxa_names(filename = fasta_filename),
  mrca_distr = mrca_distr
)

## -----------------------------------------------------------------------------
inference_model <- create_test_inference_model(
  mrca_prior = mrca_prior
)


## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  out <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model
  )
}

