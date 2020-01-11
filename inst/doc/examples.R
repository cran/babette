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

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

## ----fig.width=7, fig.height=7------------------------------------------------
plot_densitree(posterior$anthus_aco_sub_trees, width = 2)

