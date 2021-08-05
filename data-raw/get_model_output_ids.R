## code to prepare `model_output_ids` dataset goes here

usethis::use_data(model_output_ids, overwrite = TRUE)

## Function within package: Appling356MetabolicRegimes
## last updated July 2021

# Functions to download model outputs (data release item # 6)
# Get model output ids:
get_model_output_ids <- function(){

  # Data release item #6: model outputs (https://www.sciencebase.gov/catalog/item/59eb9ba6e4b0026a55ffe37f):
  sb_item_id <- "59eb9ba6e4b0026a55ffe37f"

  # Find child items (containing 1 zip file per site):
  sb_id_children <- sbtools::item_list_children(sb_item_id,limit = 356)

  # Return time series (names, urls, and ScienceBase item id's):
  file_names <- sapply(sb_id_children, function(item) item$title)
  file_urls <- sapply(sb_id_children,function(item) item$link$url)
  file_ids <- sapply(sb_id_children,function(item) item$id)

  # return ids:
  model_output_ids <- data.frame(site_name = sub(pattern = "_fits",replacement="",x=file_names), file_id = file_ids)
  return(model_output_ids)

}
