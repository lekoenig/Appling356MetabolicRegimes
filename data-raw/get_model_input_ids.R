## code to prepare `model_input_ids` dataset goes here

usethis::use_data(model_input_ids, overwrite = TRUE)

## Function within package: Appling356MetabolicRegimes
## last updated July 2021

# Functions to download model inputs (data release item # 4)
# Get time series ids:
get_model_input_ids <- function(sitename){

  # Data release item #4: model inputs (https://www.sciencebase.gov/catalog/item/59eb9b9de4b0026a55ffe37c):
  sb_item_id <- "59eb9b9de4b0026a55ffe37c"

  # Find child items (containing 1 zip file per site):
  sb_id_children <- sbtools::item_list_children(sb_item_id,limit = 356)

  # Return time series (names, urls, and ScienceBase item id's):
  file_names <- sapply(sb_id_children, function(item) item$title)
  file_urls <- sapply(sb_id_children,function(item) item$link$url)
  file_ids <- sapply(sb_id_children,function(item) item$id)

  # return ids:
  model_input_ids <- data.frame(site_name = sub(pattern = "_input",replacement="",x=file_names), file_id = file_ids)
  return(model_input_ids)

}
