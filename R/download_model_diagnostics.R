#' Download model diagnostics
#'
#' Download diagnostics and assessments of metabolism model performance. See metadata associated with data release item 7: \href{https://www.sciencebase.gov/catalog/item/59eb9bafe4b0026a55ffe382}{Model diagnostics}.
#'
#' @usage download_model_diagnostics(
#' save_dir,
#' overwrite_file
#' )
#' @return Returns a data frame with one row per model.
#' @export download_model_diagnostics
#'
#' @param save_dir Path to save .tsv file containing model diagnostics. If save_dir isn't specified, model diagnostics file will not be saved locally.
#' @param overwrite_file Boolean indicating if diagnostics.tsv file should be overwritten if it already exists. Default is FALSE.
#'
#' @importFrom utils unzip read.csv
#'
#' @examples
#' download_model_diagnostics()
#'
#'
download_model_diagnostics <- function(save_dir=temp,overwrite_file=FALSE){

  # Data release item #7: model diagnostics (https://www.sciencebase.gov/catalog/item/59eb9bafe4b0026a55ffe382):
  sb_item_id <- "59eb9bafe4b0026a55ffe382"

  # Download zip folders containing site data to temporary directory:
  temp <- tempdir()
  model_diagn <- sbtools::item_file_download(sb_item_id, dest_dir=temp,overwrite_file = TRUE)

  # Unpack zip file and read in model configs:
  unzip(zipfile = paste(temp,"/diagnostics.zip",sep=""),exdir = save_dir,overwrite = overwrite_file)
  model_diagn_df <- read.csv(paste(save_dir,"/diagnostics.tsv",sep=""), sep = "\t",header=TRUE)

  return(model_diagn_df)

}


