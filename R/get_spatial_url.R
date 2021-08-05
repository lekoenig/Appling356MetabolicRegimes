#' Get spatial url
#'
#' While direct download of spatial data (data release \href{https://www.sciencebase.gov/catalog/item/5a5e3791e4b06e28e9be48c1}{item 2} containing spatial coordinates and site catchment boundaries) is not currently enabled, this function returns the web url where spatial data can be downloaded manually.
#'
#' @return Returns a character string containing the web url to access spatial data
#' @keywords spatial
#' @export get_spatial_url
#'
#'
#' @examples
#' get_spatial_url

get_spatial_url <- function(){

  # Data release item #2: spatial data - site coordinates (https://www.sciencebase.gov/catalog/item/5a5e3791e4b06e28e9be48c1):
  sb_item_id <- "5a5e3791e4b06e28e9be48c1"
  #sb_id_children <- sbtools::item_list_children(sb_item_id)

  # Return spatial data items (names, urls, and ScienceBase item id's):
  #file_names <- sapply(sb_id_children, function(item) item$title)
  #file_urls <- sapply(sb_id_children,function(item) item$link$url)
  #file_ids <- sapply(sb_id_children,function(item) item$id)

  message("For now, the spatial data items must be downloaded manually from https://www.sciencebase.gov/catalog/item/5a5e3791e4b06e28e9be48c1")

}

