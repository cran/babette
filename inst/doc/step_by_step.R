## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load_babette, results='hide', warning=FALSE, error=FALSE, message=FALSE----
library(babette)

## -----------------------------------------------------------------------------
mcmc <- create_test_mcmc()
sample_interval <- mcmc$tracelog$log_every

## -----------------------------------------------------------------------------
beast2_input_file <- tempfile()
create_beast2_input_file(
  get_babette_path("anthus_aco.fas"),
  output_filename = beast2_input_file,
  mcmc = mcmc
)
testit::assert(file.exists(beast2_input_file))

## -----------------------------------------------------------------------------
print(head(readLines(beast2_input_file)))

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  testit::assert(is_beast2_input_file(beast2_input_file))
}

## -----------------------------------------------------------------------------
log_filename <- get_tracerer_path("beast2_example_output.log")
trees_filename <- get_tracerer_path("beast2_example_output.trees")
state_filename <- get_tracerer_path("beast2_example_output.xml.state")

if (is_beast2_installed()) {

  state_filename <- beastier::create_temp_state_filename()
  run_beast2(
    input_filename = beast2_input_file,
    output_state_filename = state_filename
  )
  testit::assert(file.exists(state_filename))
}

## -----------------------------------------------------------------------------
print(head(readLines(log_filename)))
print(tail(readLines(log_filename)))

## -----------------------------------------------------------------------------
print(head(readLines(trees_filename)))
print(tail(readLines(trees_filename)))

## -----------------------------------------------------------------------------
print(head(readLines(state_filename)))
print(tail(readLines(state_filename)))

## -----------------------------------------------------------------------------
knitr::kable(head(parse_beast_log(log_filename)))

## ----fig.width = 7, fig.height = 7--------------------------------------------
plot_densitree(parse_beast_trees(trees_filename))

## -----------------------------------------------------------------------------
knitr::kable(head(parse_beast_state_operators(state_filename)))

