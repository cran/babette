#' Do a self test to verify \link{babette} that works correctly.
#' @inheritParams default_params_doc
#' @author Richèl J.C. Bilderbeek
#' @export
#' @examples
#' if (beautier::is_on_ci() && is_beast2_installed()) {
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#'
#'   bbt_self_test()
#'
#'   beastier::remove_beaustier_folders()
#'   beastier::check_empty_beaustier_folders()
#' }
bbt_self_test <- function(
  beast2_options = beastier::create_beast2_options()
) {
  testthat::expect_true(beastier::is_beast2_installed())
  inference_model <- beautier::create_test_inference_model()
  babette::bbt_run_from_model(
    fasta_filename = beautier::get_fasta_filename(),
    inference_model = inference_model,
    beast2_options = beast2_options
  )
  babette::bbt_delete_temp_files(
    inference_model = inference_model,
    beast2_options = beast2_options
  )
}
