% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download_model_inputs.R
\name{download_model_inputs}
\alias{download_model_inputs}
\title{Download metabolism model inputs}
\usage{
download_model_inputs(sitename, save_dir = temp, overwrite_file = FALSE)
}
\arguments{
\item{sitename}{The sitename should be in the same format used in the site data. See examples below.}

\item{save_dir}{Path to save .tsv file containing model inputs. If save_dir isn't specified, model inputs will not be saved locally.}

\item{overwrite_file}{Boolean indicating if SITENAME_input.tsv file should be overwritten if it already exists. Default is FALSE.}
}
\value{
Returns one data frame per site containing formatted model input data.
}
\description{
Download prepared time series inputs used for estimating metabolism. This function will download and load one data frame per site. See metadata associated with data release item 4: \href{https://www.sciencebase.gov/catalog/item/59eb9b9de4b0026a55ffe37c}{Model inputs}.
}
\examples{
download_model_inputs("nwis_01184000")


\dontrun{

# Load inputs for multiple sites and save .tsv files to local directory:
selected_sites <- c("nwis_01184000","nwis_01125100")
selected_inputs_ls <- lapply(selected_sites,download_model_inputs,save_dir = "./data/model_inputs")
names(selected_inputs_ls) <- selected_sites
}

}
\keyword{input}
\keyword{model}
