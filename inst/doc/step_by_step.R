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
inference_model <- create_inference_model()
inference_model$mcmc$chain_length <- 10000
inference_model$mcmc$tracelog$filename <- normalizePath(
  get_beautier_tempfilename(
    pattern = "tracelog_", fileext = ".log"
  ),
  mustWork = FALSE
)
inference_model$mcmc$treelog$filename <- normalizePath(
  get_beautier_tempfilename(
    pattern = "treelog_",
    fileext = ".trees"
  ),
  mustWork = FALSE
)

## -----------------------------------------------------------------------------
beast2_input_file <- tempfile(pattern = "beast2_", fileext = ".xml")
create_beast2_input_file_from_model(
  input_filename = get_babette_path("anthus_aco.fas"),
  inference_model = inference_model,
  output_filename = beast2_input_file
)

## -----------------------------------------------------------------------------
print(head(readLines(beast2_input_file)))

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  is_beast2_input_file(beast2_input_file)
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  beast2_options <- create_beast2_options(
    input_filename = beast2_input_file
  )
  beastier::check_can_create_file(beast2_options$output_state_filename)
  beastier::check_can_create_treelog_file(beast2_options)
  run_beast2_from_options(
    beast2_options = beast2_options
  )
  if (!file.exists(beast2_options$output_state_filename)) {
    stop("the filename should have been created.")
  }
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  print(head(readLines(inference_model$mcmc$tracelog$filename)))
  print(tail(readLines(inference_model$mcmc$tracelog$filename)))
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  print(head(readLines(inference_model$mcmc$treelog$filename)))
  print(tail(readLines(inference_model$mcmc$treelog$filename)))
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  print(head(readLines(beast2_options$output_state_filename)))
  print(tail(readLines(beast2_options$output_state_filename)))
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  knitr::kable(
    head(parse_beast_tracelog_file(inference_model$mcmc$tracelog$filename))
  )
}

## ----fig.width = 7, fig.height = 7--------------------------------------------
if (is_beast2_installed()) {
  plot_densitree(parse_beast_trees(inference_model$mcmc$treelog$filename))
}

## -----------------------------------------------------------------------------
if (is_beast2_installed()) {
  knitr::kable(
    head(parse_beast_state_operators(beast2_options$output_state_filename))
  )
}

## ----cleunup, include = FALSE-------------------------------------------------
if (is_beast2_installed()) {
  bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}

## ----check_empty_cache_at_end, include = FALSE--------------------------------
beastier::remove_beaustier_folders()
beastier::check_empty_beaustier_folders()

