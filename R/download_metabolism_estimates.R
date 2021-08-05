#' Download metabolism estimates and predictors
#'
#' Download daily metabolism estimates and potential predictor variables for 356 rivers. See metadata associated with data release item 8: \href{https://www.sciencebase.gov/catalog/item/59eb9c0ae4b0026a55ffe389}{Metabolism estimates and predictors}.
#'
#' @param save_dir Path to save .tsv file containing daily metabolism estimates. If save_dir isn't specified, metabolism estimates will not be saved locally.
#' @param overwrite_file Boolean indicating if daily_predictions.tsv file should be overwritten if it already exists.
#'
#' @return Returns one data frame containing daily metabolism estimates for 356 rivers.
#' @export download_metabolism_estimates
#'
#' @importFrom utils unzip read.csv
#'
#' @examples
#' download_metabolism_estimates()
#'
#' \dontrun{
#' download_metabolism_estimates(save_dir = "./data/daily_estimates",overwrite_file=TRUE)
#'}
#'
download_metabolism_estimates <- function(save_dir = temp,overwrite_file=FALSE){

  # Data release item #8: metabolism estimates and predictors (https://www.sciencebase.gov/catalog/item/59eb9c0ae4b0026a55ffe389):
  sb_item_id <- "59eb9c0ae4b0026a55ffe389"

  # Download zip folders containing site data to temporary directory:
  temp <- tempdir()
  metab_est <- sbtools::item_file_download(sb_item_id, dest_dir=temp,overwrite_file = TRUE)

  # Unpack zip file and read in model configs:
  unzip(zipfile = paste(temp,"/daily_predictions.zip",sep=""),exdir = save_dir,overwrite = overwrite_file)
  metab_est_df <- read.csv(paste(save_dir,"/daily_predictions.tsv",sep=""), sep = "\t",header=TRUE)

  return(metab_est_df)

}


