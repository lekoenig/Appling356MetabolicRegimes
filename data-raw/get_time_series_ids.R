## code to prepare `time_series_ids` dataset goes here

usethis::use_data(time_series_ids, overwrite = TRUE)

## Function within package: Appling356MetabolicRegimes
## last updated July 2021

# Functions to download time series data (data release item # 3)
# Get time series ids:
get_time_series_ids <- function(){

  # Data release item #3: time series data (https://www.sciencebase.gov/catalog/item/59c03b72e4b091459a5e0b64):
  sb_item_id <- "59c03b72e4b091459a5e0b64"

  # Find child items (containing 1 zip file per site):
  sb_id_children <- sbtools::item_list_children(sb_item_id,limit = 602)

  # Return time series (names, urls, and ScienceBase item id's):
  file_names <- sapply(sb_id_children, function(item) item$title)
  file_urls <- sapply(sb_id_children,function(item) item$link$url)
  file_ids <- sapply(sb_id_children,function(item) item$id)

  # return ids:
  time_series_ids <- data.frame(site_name = sub(pattern = "_timeseries",replacement="",x=file_names), file_id = file_ids)
  return(time_series_ids)

}
