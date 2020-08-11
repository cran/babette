## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

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
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
    mcmc = mcmc
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## -----------------------------------------------------------------------------
mcmc <- create_test_mcmc(chain_length = 10000)

## ----example_2_mrca, cache=FALSE----------------------------------------------
if (is_beast2_installed()) {
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
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
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_3, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
    site_model = create_jc69_site_model(),
    mcmc = mcmc
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_4, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
    clock_model = create_rln_clock_model(),
    mcmc = mcmc
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_5, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
    tree_prior = create_bd_tree_prior(),
    mcmc = mcmc
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_6, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
    tree_prior = create_yule_tree_prior(
      birth_rate_distr = create_normal_distr(
        mean = 1.0,
        sigma = 0.1
      )
    ),
    mcmc = mcmc
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_7, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
    site_model = create_hky_site_model(
      gamma_site_model = create_gamma_site_model(prop_invariant = 0.5)
    ),
    mcmc = mcmc
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----example_8, cache=TRUE----------------------------------------------------
if (is_beast2_installed()) {
  posterior <- bbt_run(
    fasta_filename = fasta_filename,
    clock_model = create_strict_clock_model(
      clock_rate_param = 0.5
    ),
    mcmc = mcmc
  )
}

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

