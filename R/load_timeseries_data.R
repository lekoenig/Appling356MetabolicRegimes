#' Load time series data
#'
#' Load time series data for a specified site. Timeseries data contains data on water quality and quantity, collected or computed from outside sources. See metadata associated with data release item 3: \href{https://www.sciencebase.gov/catalog/item/59c03b72e4b091459a5e0b64}{timeseries data}.
#'
#' @usage
#' load_timeseries_data(
#' sitename,
#' zip_dir
#' )
#'
#' @param sitename The sitename should be in the same format used in the site data. See examples below.
#' @param zip_dir Path indicating location of downloaded timeseries.zip files. See download_time_series_data().
#'
#' @return Returns a list for one site containing data frames housing the different water quality and quantity data sets.
#' @export load_timeseries_data
#'
#' @importFrom utils unzip read.csv
#'
#' @examples
#' \dontrun{
#'
#' # Timeseries zip files for selected sites must have been previously downloaded,
#' # see download_timeseries_data():
#' load_timeseries_data("nwis_01036390",zip_dir = "./data/timeseries")
#'
#' # Load timeseries data from multiple sites in a nested list:
#' selected_sites <- c("nwis_01021050","nwis_01125100")
#' selected_sites_ls <- lapply(selected_sites,load_timeseries_data,zip_dir = "./data/timeseries")
#' names(selected_sites_ls) <- selected_sites
#'}

load_timeseries_data <- function(sitename,zip_dir){

  if(length(sitename)>1) stop("Error: more than one site given in sitename. See examples to load time series files for multiple sites")

  # List timeseries files contained within save directory:
  time_series_files <- list.files(path=zip_dir,pattern="_timeseries.zip")
  time_series_files_which_sites <- sub('^([^_]+_[^_]+).*', '\\1', time_series_files)

  # Find timeseries files that match user-specified sitename:
  match_sites <- sitename[which(sitename%in% time_series_files_which_sites)]
  if(length(match_sites) < 1) stop("No timeseries.zip folder found for the given sitename. Check save_dir argument or try running download_time_series_data()")

  # Unzip timeseries.zip folders:
  temp <- tempdir()
  unzipped_files <- unzip(zipfile=paste(zip_dir,"/",match_sites,"_timeseries.zip",sep=""),
                          exdir=temp,overwrite = TRUE)

  # Load time series data for given sitename:
  file_names <- substr(unzipped_files,start=nchar(temp)+2,stop=1000)
  file_names_abbrev <- gsub(".*-|.tsv.*", "", file_names)

  timeseries_data <- lapply(unzipped_files,function(x) read.csv(x,header=TRUE,sep="\t",stringsAsFactors = FALSE))
  names(timeseries_data) <- file_names_abbrev
  return(timeseries_data)

}
