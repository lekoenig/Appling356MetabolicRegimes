#' Download metabolism model inputs
#'
#' Download prepared time series inputs used for estimating metabolism. This function will download and load one data frame per site. See metadata associated with data release item 4: \href{https://www.sciencebase.gov/catalog/item/59eb9b9de4b0026a55ffe37c}{Model inputs}.
#'
#' @param sitename The sitename should be in the same format used in the site data. See examples below.
#' @param save_dir Path to save .tsv file containing model inputs. If save_dir isn't specified, model inputs will not be saved locally.
#' @param overwrite_file Boolean indicating if SITENAME_input.tsv file should be overwritten if it already exists. Default is FALSE.
#'
#' @return Returns one data frame per site containing formatted model input data.
#' @export download_model_inputs
#'
#' @keywords model input
#'
#' @importFrom utils unzip read.csv
#'
#' @examples
#' download_model_inputs("nwis_01184000")
#'
#'
#' \dontrun{
#'
#' # Load inputs for multiple sites and save .tsv files to local directory:
#' selected_sites <- c("nwis_01184000","nwis_01125100")
#' selected_inputs_ls <- lapply(selected_sites,download_model_inputs,save_dir = "./data/model_inputs")
#' names(selected_inputs_ls) <- selected_sites
#' }
#'

download_model_inputs <- function(sitename,save_dir=temp,overwrite_file=FALSE){

  if(length(sitename)>1) stop("Error: more than one site given in sitename")

  # ScienceBase item id for item #4 model inputs (https://www.sciencebase.gov/catalog/item/59eb9b9de4b0026a55ffe37c):
  #sb_item_id <- "59eb9b9de4b0026a55ffe37c"

  # Match requested site names to sb child ids:
  all_ids <- model_input_ids

  omit_sitenames <- sitename[which(!sitename %in% all_ids$site_name)]
  if(length(omit_sitenames) > 0) stop("Sitename does not have associated model input data. To see a list of sites with model input data, consult the table Appling356MetabolicRegimes:::model_input_ids")

  request_id <- all_ids[all_ids$site_name %in% sitename,"file_id"]

  # Download zip folders containing requested model inputs:
  temp <- tempdir()
  modelinput_zips <- sbtools::item_file_download(sb_id = request_id,dest_dir = temp,overwrite_file = TRUE)

  # Unzip model inputs:
  unzip(zipfile=modelinput_zips,exdir=save_dir,overwrite = overwrite_file)
  mod_input <- read.csv(paste(save_dir,"/",sitename,"_input.tsv",sep=""),header=TRUE,stringsAsFactors = FALSE,sep="\t")
  return(mod_input)
}
