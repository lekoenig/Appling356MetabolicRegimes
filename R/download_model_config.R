#' Download metabolism model configurations
#'
#' Download model specifications used for estimating metabolism. This function will download and load a table containing one row per model. See metadata associated with data release item 5: \href{https://www.sciencebase.gov/catalog/item/59eb9b86e4b0026a55ffe379}{Model configurations}.
#'
#' @usage download_model_config()
#'
#' @return Returns one data frame with one row per model.
#' @export download_model_config
#'
#' @importFrom utils unzip read.csv
#'
#' @examples
#' download_model_config()
#'
#'
download_model_config <- function(){

  # Data release item #5: model configurations (https://www.sciencebase.gov/catalog/item/59eb9b86e4b0026a55ffe379):
  sb_item_id <- "59eb9b86e4b0026a55ffe379"

  # Download zip folders containing site data to temporary directory:
  temp <- tempdir()
  model_configs <- sbtools::item_file_download(sb_item_id, dest_dir=temp,overwrite_file = TRUE)

  # Unpack zip file and read in model configs:
  unzip(zipfile = paste(temp,"/config.zip",sep=""),exdir = temp)
  model_config_df <- read.csv(paste(temp,"/config.tsv",sep=""), sep = "\t",header=TRUE)

  return(model_config_df)

}


