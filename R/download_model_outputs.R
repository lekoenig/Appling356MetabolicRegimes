#' Download metabolism model outputs
#'
#' Download complete fits from metabolism estimation models. This function will download and load five data frames per model that collectively describe the model fits. See ScienceBase for a complete description of model output files. See metadata associated with data release item 6: \href{https://www.sciencebase.gov/catalog/item/59eb9ba6e4b0026a55ffe37f}{Model outputs}.
#'
#' @param sitename The sitename should be in the same format used in the site data. See examples below.
#' @param save_dir Path to save .zip file containing model outputs. If save_dir isn't specified, the zip file containing model outputs will not be saved locally.
#'
#' @return Returns a list containing five data frames per site that describe the model fits.
#' @export download_model_outputs
#'
#' @importFrom utils unzip read.csv
#'
#' @examples
#' download_model_outputs("nwis_01184000")
#'
#'
#' \dontrun{
#'
#' download_model_outputs("nwis_01184000",save_dir = "./data/model_outputs")
#' }
#'
#'
download_model_outputs <- function(sitename,save_dir=temp){

  if(length(sitename)>1) stop("Error: more than one site given in sitename")

  # ScienceBase item id for item #6 model outputs (https://www.sciencebase.gov/catalog/item/59eb9ba6e4b0026a55ffe37f):
  #sb_item_id <- "59eb9ba6e4b0026a55ffe37f"

  # Match requested site names to sb child ids:
  all_ids <- model_output_ids

  omit_sitenames <- sitename[which(!sitename %in% all_ids$site_name)]
  if(length(omit_sitenames) > 0) stop("Sitename does not have associated model output data. To see a list of sites with model output data, consult the table Appling356MetabolicRegimes:::model_output_ids")

  request_id <- all_ids[all_ids$site_name %in% sitename,"file_id"]

  # Download zip folders containing requested model outputs:
  temp <- tempdir()
  modeloutput_zips <- sbtools::item_file_download(sb_id = request_id,dest_dir = save_dir,overwrite_file = TRUE)

  # Unzip model outputs:
  unzip(zipfile=modeloutput_zips,overwrite = TRUE,exdir=temp)

  # Compile model outputs within a list:
  filetypes <- c("warnings.txt","KQ_binned.tsv","KQ_overall.tsv","overall.tsv","daily.tsv")
  warnings <- readLines(paste(temp,"/",filetypes[1],sep=""))
  KQ_binned <- read.csv(paste(temp,"/",filetypes[2],sep=""),header=TRUE,sep="\t",stringsAsFactors = FALSE)
  KQ_overall <- read.csv(paste(temp,"/",filetypes[3],sep=""),header=TRUE,sep="\t",stringsAsFactors = FALSE)
  overall <- read.csv(paste(temp,"/",filetypes[4],sep=""),header=TRUE,sep="\t",stringsAsFactors = FALSE)
  daily <- read.csv(paste(temp,"/",filetypes[5],sep=""),header=TRUE,sep="\t",stringsAsFactors = FALSE)

  mod_outputs <- list(warnings = warnings,
                      KQ_binned = KQ_binned,
                      KQ_overall = KQ_overall,
                      overall = overall,
                      daily = daily)
  return(mod_outputs)

}
