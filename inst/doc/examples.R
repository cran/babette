## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----check_empty_cache_at_start, include = FALSE------------------------------
beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

## -----------------------------------------------------------------------------
posterior <- create_test_bbt_run_output()
posterior$anthus_aco_sub_trees <- posterior$anthus_aco_trees
names(posterior)

## -----------------------------------------------------------------------------
fasta_filename <- get_babette_path("anthus_aco_sub.fas")

## -----------------------------------------------------------------------------
mcmc <- create_test_mcmc(chain_length = 10000)

## ----example_1, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## -----------------------------------------------------------------------------
mcmc <- create_test_mcmc(chain_length = 10000)

## ----example_2_mrca, cache=FALSE----------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    mcmc = mcmc,
    mrca_prior = create_mrca_prior(
      taxa_names = sample(get_taxa_names(fasta_filename), size = 3),
      alignment_id = get_alignment_id(fasta_filename),
      is_monophyletic = TRUE,
      mrca_distr = create_normal_distr(
        mean = 15.0,
        sigma = 0.025
      )
    )
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_3, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    site_model = create_jc69_site_model(),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_4, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    clock_model = create_rln_clock_model(),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_5, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    tree_prior = create_bd_tree_prior(),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_6, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    tree_prior = create_yule_tree_prior(
      birth_rate_distr = create_normal_distr(
        mean = 1.0,
        sigma = 0.1
      )
    ),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_7, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    site_model = create_hky_site_model(
      gamma_site_model = create_gamma_site_model(prop_invariant = 0.5)
    ),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_8, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  inference_model <- create_inference_model(
    clock_model = create_strict_clock_model(
      clock_rate_param = 0.5
    ),
    mcmc = mcmc
  )
  beast2_options <- create_beast2_options()
  posterior <- bbt_run_from_model(
    fasta_filename = fasta_filename,
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----check_empty_cache_at_end, include = FALSE--------------------------------
beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

