#' Download site data
#'
#' Download site information for all sites contained within "Metabolic estimates for 356 rivers (2007-2017), \url{https://doi.org/10.5066/F70864KX}." See metadata associated with data item 1: \href{https://www.sciencebase.gov/catalog/item/59bff64be4b091459a5e098b}{Site data}.
#'
#' @param save_dir Path to save .tsv file containing site data. If save_dir isn't specified, site data will not be saved locally.
#'
#' @return Returns a data frame containing one row of site identifiers, details, and quality indicators per site
#' @keywords site
#' @export download_site_data
#'
#' @importFrom utils unzip read.csv
#'
#' @examples
#' download_site_data()
#'
#' \dontrun{
#'
#' pc_sites <- download_site_data(save_dir = "./data/site_data")
#' }
#'

download_site_data <- function(save_dir = temp){

  # Data release item #1: site info (https://www.sciencebase.gov/catalog/item/59bff507e4b091459a5e0982):
  sb_item_id <- "59bff64be4b091459a5e098b"

  # Download zip folders containing site data to temporary directory:
  temp <- tempdir()
  site_data <- sbtools::item_file_download(sb_item_id, dest_dir=save_dir,overwrite_file = TRUE)

  # Read file (metadata: https://www.sciencebase.gov/catalog/file/get/59eb9c0ae4b0026a55ffe389?f=__disk__d6%2F07%2Fbb%2Fd607bb041a2005311ff1318d695ed79907f439cf&transform=1&allowOpen=true)
  site_data_df <- read.csv(paste(save_dir,"/site_data.tsv",sep=""), sep = "\t",header=TRUE)

  return(site_data_df)

}


