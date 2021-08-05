#' Download time series data
#'
#' Download time series data for specified sites. Time series data contains data on water quality and quantity, collected or computed from outside sources. This function will download 1 zip file per site to the specified save directory. See metadata associated with data release item 3: \href{https://www.sciencebase.gov/catalog/item/59c03b72e4b091459a5e0b64}{timeseries data}.
#'
#' @usage
#' download_timeseries_data(
#' sitename,
#' save_dir,
#' overwrite_file = FALSE
#' )
#'
#' @param sitename The sitename should be in the same format used in the site data. See examples below.
#' @param save_dir Path of the desired save directory
#' @param overwrite_file Boolean indicating if local file should be overwritten if it already exists. (\code{\link[sbtools]{item_file_download}})
#'
#' @return Downloads one zip file per site to save_dir.
#' @export download_timeseries_data
#'
#' @importFrom utils unzip read.csv
#'
#' @keywords timeseries time series
#'
#' @examples
#' \dontrun{
#'
#' download_timeseries_data("nwis_01036390","./data/timeseries")
#' download_timeseries_data(sitename = c("nwis_01036390","nwis_01570500"),
#'                           save_dir = "./data/timeseries",TRUE)
#'
#' pc_sites <- download_site_data()
#' lapply(pc_sites$site_name,download_timeseries_data,
#'        save_dir = "./data/timeseries",overwrite_file=TRUE)
#'
#' }
#'
download_timeseries_data <- function(sitename,save_dir,overwrite_file=FALSE){

  # ScienceBase item id for item #3 time series data (https://www.sciencebase.gov/catalog/item/59c03b72e4b091459a5e0b64):
  #sb_item_id <- "59c03b72e4b091459a5e0b64"

  # Match requested site names to sb child ids:
  all_ids <- time_series_ids
  request_id <- all_ids[all_ids$site_name %in% sitename,"file_id"]

  # Download zip folders containing requested time series:
  temp <- tempdir()
  timeseries_zips <- lapply(request_id,sbtools::item_file_download,dest_dir = save_dir,overwrite_file=overwrite_file)

}
