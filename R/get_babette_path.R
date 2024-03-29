#' Get the full path of a file in the \code{inst/extdata} folder
#' @param filename the file's name, without the path
#' @return the full path of the filename, if and only if
#'   the file is present. Will stop otherwise.
#' @author Richèl J.C. Bilderbeek
#' @seealso for more files, use \code{\link{get_babette_paths}}
#' @examples
#' beastier::remove_beaustier_folders()
#' beastier::check_empty_beaustier_folders()
#'
#' get_babette_path("anthus_aco.fas")
#'
#' beastier::remove_beaustier_folders()
#' beastier::check_empty_beaustier_folders()
#' @export
get_babette_path <- function(filename) {

  full <- system.file("extdata", filename, package = "babette")
  if (!file.exists(full)) {
    stop("'filename' must be the name of a file in 'inst/extdata'")
  }
  full
}
