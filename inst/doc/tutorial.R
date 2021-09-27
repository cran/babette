## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----check_empty_cache_at_start, include = FALSE------------------------------
beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()

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
  beast2_options <- create_beast2_options()
  out <- bbt_run_from_model(
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
inference_model <- create_test_inference_model(
  site_model = create_jc69_site_model()
)

## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  beast2_options <- create_beast2_options()
  out <- bbt_run_from_model(
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
inference_model <- create_test_inference_model(
  clock_model = create_strict_clock_model()
)

## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  beast2_options <- create_beast2_options()
  out <- bbt_run_from_model(
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
inference_model <- create_test_inference_model(
  tree_prior = create_yule_tree_prior()
)

## ----cache=TRUE---------------------------------------------------------------
if (is_beast2_installed()) {
  beast2_options <- create_beast2_options()
  out <- bbt_run_from_model(
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
  beast2_options <- create_beast2_options()
  out <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----check_empty_cache_at_end, include = FALSE--------------------------------
unlink(
  dirname(beastier::get_beastier_tempfilename()),
  recursive = TRUE
)
beautier::check_empty_beautier_folder()
beastier::check_empty_beastier_folder()
# beastierinstall::clear_beautier_cache() ; beastierinstall::clear_beastier_cache() # nolint

